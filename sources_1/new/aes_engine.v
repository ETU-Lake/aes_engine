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
    reg [3:0] ctr [10:0];
    reg run, valid;

    assign states[0] = first;
    assign hazir = key_expanded && ((ctr[0] == 4'd0) || (ctr[1] == 4'd0) || (ctr[2] == 4'd0) || (ctr[3] == 4'd0) || (ctr[4] == 4'd0) ||
                                    (ctr[5] == 4'd0) || (ctr[6] == 4'd0) || (ctr[7] == 4'd0) || (ctr[8] == 4'd0) || (ctr[9] == 4'd0) ||
                                    (ctr[10] == 4'd0));
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
        ctr[2] <= 4'd0;
        ctr[3] <= 4'd0;
        ctr[4] <= 4'd0;
        ctr[5] <= 4'd0;
        ctr[6] <= 4'd0;
        ctr[7] <= 4'd0;
        ctr[8] <= 4'd0;
        ctr[9] <= 4'd0;
        ctr[10] <= 4'd0;
    end

    always @ (posedge clk) begin
        if (rst) begin
            run <= 1'b0;
            ctr[0] <= 4'd0;
            ctr[1] <= 4'd0;
            ctr[2] <= 4'd0;
            ctr[3] <= 4'd0;
            ctr[4] <= 4'd0;
            ctr[5] <= 4'd0;
            ctr[6] <= 4'd0;
            ctr[7] <= 4'd0;
            ctr[8] <= 4'd0;
            ctr[9] <= 4'd0;
            ctr[10] <= 4'd0;
            first <= 128'd0;
        end else if (key_expanded && g_gecerli) begin
            run <= 1'b1;
        end

        if (valid) begin
            if (~(ctr[0] == 4'd10 || ctr[1] == 4'd10 || ctr[2] == 4'd10 || ctr[3] == 4'd10 || ctr[4] == 4'd10 ||
                  ctr[5] == 4'd10 || ctr[6] == 4'd10 || ctr[7] == 4'd10 || ctr[8] == 4'd10 || ctr[9] == 4'd10 ||
                  ctr[10] == 4'd10)) begin
                valid = ~valid;
            end
        end

        if (g_gecerli && hazir) begin
            if (ctr[0] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[0] <= 4'd1;
            end else if (ctr[1] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[1] <= 4'd1;
            end else if (ctr[2] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[2] <= 4'd1;
            end else if (ctr[3] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[3] <= 4'd1;
            end else if (ctr[3] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[3] <= 4'd1;
            end else if (ctr[4] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[4] <= 4'd1;
            end else if (ctr[5] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[5] <= 4'd1;
            end else if (ctr[6] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[6] <= 4'd1;
            end else if (ctr[7] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[7] <= 4'd1;
            end else if (ctr[8] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[8] <= 4'd1;
            end else if (ctr[9] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[9] <= 4'd1;
            end else if (ctr[10] == 4'd0) begin
                first = blok ^ expanded[1407-:128];
                ctr[10] <= 4'd1;
            end
        end

        if (run) begin
            if (ctr[0] == 4'd10) begin
                valid <= 1'b1;
                ctr[0] <= 1'b0;
            end else if (ctr[1] == 4'd10) begin
                valid <= 1'b1;
                ctr[1] <= 4'd0;
            end else if (ctr[2] == 4'd10) begin
                valid <= 1'b1;
                ctr[2] <= 4'd0;
            end else if (ctr[3] == 4'd10) begin
                valid <= 1'b1;
                ctr[3] <= 4'd0;
            end else if (ctr[4] == 4'd10) begin
                valid <= 1'b1;
                ctr[4] <= 4'd0;
            end else if (ctr[5] == 4'd10) begin
                valid <= 1'b1;
                ctr[5] <= 4'd0;
            end else if (ctr[6] == 4'd10) begin
                valid <= 1'b1;
                ctr[6] <= 4'd0;
            end else if (ctr[7] == 4'd10) begin
                valid <= 1'b1;
                ctr[7] <= 4'd0;
            end else if (ctr[8] == 4'd10) begin
                valid <= 1'b1;
                ctr[8] <= 4'd0;
            end else if (ctr[9] == 4'd10) begin
                valid <= 1'b1;
                ctr[9] <= 4'd0;
            end else if (ctr[10] == 4'd10) begin
                valid <= 1'b1;
                ctr[10] <= 4'd0;
            end

            if (~(ctr[0] == 4'd0)) begin
                ctr[0] = ctr[0] + 4'd1;
            end

            if (~(ctr[1] == 4'd0)) begin
                ctr[1] = ctr[1] + 4'd1;
            end

            if (~(ctr[2] == 4'd0)) begin
                ctr[2] = ctr[2] + 4'd1;
            end

            if (~(ctr[3] == 4'd0)) begin
                ctr[3] = ctr[3] + 4'd1;
            end

            if (~(ctr[4] == 4'd0)) begin
                ctr[4] = ctr[4] + 4'd1;
            end

            if (~(ctr[5] == 4'd0)) begin
                ctr[5] = ctr[5] + 4'd1;
            end

            if (~(ctr[6] == 4'd0)) begin
                ctr[6] = ctr[6] + 4'd1;
            end

            if (~(ctr[7] == 4'd0)) begin
                ctr[7] = ctr[7] + 4'd1;
            end

            if (~(ctr[8] == 4'd0)) begin
                ctr[8] = ctr[8] + 4'd1;
            end

            if (~(ctr[9] == 4'd0)) begin
                ctr[9] = ctr[9] + 4'd1;
            end

            if (~(ctr[10] == 4'd0)) begin
                ctr[10] = ctr[10] + 4'd1;
            end
        end
    end
endmodule
