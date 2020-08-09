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
    reg [3:0] ctr;
    reg run, valid;

    assign states[0] = blok ^ expanded[1407-:128];
    assign hazir = key_expanded;
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
        run = 1'b0;
        valid = 1'b0;
        ctr = 4'd0;
    end

    always @ (posedge clk) begin
        if (rst) begin
            run <= 1'b0;
            ctr <= 4'd0;
        end else if (key_expanded) begin
            run <= 1'b1;
        end

        if (valid) begin
            valid = 1'b0;
        end

        if (g_gecerli && hazir) begin
            if (ctr == 4'd0) begin
                ctr = 4'd1;
            end
        end
        if (run) begin
            $display("%d" , ctr);
            if (ctr == 4'd10) begin
                valid <= 1'b1;
                ctr <= 4'd0;
            end else if (~(ctr == 4'd0)) begin
                ctr = ctr + 4'd1;
            end
        end
    end
endmodule
