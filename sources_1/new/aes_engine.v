`timescale 1ns / 1ps

module aes_engine (
    input          clk,
    input          rst,
    input [127:0]  anahtar,
    input [127:0]  blok,
    input          g_gecerli,
    output         hazir,
    output [127:0] sifre,
    output         c_gecerli
);

    wire [1407:0] expanded;
    wire [127:0] states [0:10];
    wire key_expanded;
    reg [127:0] first;
    reg [3:0] ctr [1:0];
    reg run, valid;

    assign states[0] = first;
    assign hazir = key_expanded & ((ctr[0] == 4'd0) | (ctr[1] == 4'd0));
    assign sifre = states[10];
    assign c_gecerli = valid;

    genvar i;

    keyexpansion do_keyexpansion(.key(anahtar), .start(~run), .clk(clk), .rst(rst), .out(expanded), .finish(key_expanded));

    generate
        for (i = 1; i < 10; i = i + 1) begin
            round do_round(.clk(clk & run), .rst(rst), .key(expanded[(1407-128*i)-:128]), .state(states[i - 1]), .out(states[i]));
        end
    endgenerate

    lastround do_lastround(.clk(clk & run), .rst(rst), .key(expanded[127:0]), .state(states[9]), .out(states[10]));

    initial begin
        run <= 1'b0;
        valid <= 1'b0;
        ctr[0] <= 4'd0;
        ctr[1] <= 4'd0;
    end

    always @ (posedge clk) begin
        if (rst) begin
            run <= 1'b0;
            ctr[0] <= 4'd0;
            ctr[1] <= 4'd0;
            first <= 128'd0;
        end else if (key_expanded && g_gecerli) begin
            run <= 1'b1;
        end

        if (valid) begin
            $display("%d %d", ctr[0], ctr[1]);
            if (~(ctr[0] == 4'd10 || ctr[1] == 4'd10)) begin
                valid = ~valid;
            end
        end

        if (g_gecerli && hazir) begin
            if (ctr[0] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[0] <= 4'd1;
            end

            if (ctr[1] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[1] <= 4'd1;
            end

        end

        if (run) begin
            if (ctr[0] == 4'd10) begin
                valid <= 1'b1;
                ctr[0] <= 4'd0;
            end else if (~(ctr[0] == 4'd0)) begin
                ctr[0] = ctr[0] + 4'd1;
            end else if (ctr[1] == 4'd10) begin
                valid <= 1'b1;
                ctr[1] <= 4'd0;
            end else if (~(ctr[1] == 4'd0)) begin
                ctr[1] = ctr[1] + 4'd1;
            end

        end
    end
endmodule
