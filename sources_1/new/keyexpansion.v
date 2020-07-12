`timescale 1ns / 1ps

module keyexpansion(
    input [127:0] key,
    input start,
    input clk,
    input rst,
    output reg [1407:0] out,
    output reg finish
);
    integer i, j, k;
    reg [7:0] tmp[3:0], sboxin[3:0];

    wire [7:0] sboxout[3:0];

    sbox tmp1 (.in(sboxin[0]), .out(sboxout[0]));
    sbox tmp2 (.in(sboxin[1]), .out(sboxout[1]));
    sbox tmp3 (.in(sboxin[2]), .out(sboxout[2]));
    sbox tmp4 (.in(sboxin[3]), .out(sboxout[3]));

    initial begin
        finish = 1'b0;
        i = 4;

        out =0;
        out[127:0] = { 8'h65, 8'h78, 8'h70, 8'h61, 8'h6E, 8'h64, 8'h20, 8'h33, 
                       8'h32, 8'h2D, 8'h62, 8'h79, 8'h74, 8'h65, 8'h20, 8'h6B };
        //out = 1408'd12367;
        /*
        for (i=0; i < 128; i = i+1)
            out[i] = key[i];
        */
        $display("%h", out);
    end

    always @ (posedge clk) begin
        if (i < 44) begin

        k = (i-1)*4;

        tmp[0] = out[(8*(k+0))+:8];
        tmp[1] = out[(8*(k+1))+:8];
        tmp[2] = out[(8*(k+2))+:8];
        tmp[3] = out[(8*(k+3))+:8];

        if (i%4 == 0) begin
            sboxin[0] = tmp[1];
            sboxin[1] = tmp[2];
            sboxin[2] = tmp[3];
            sboxin[3] = tmp[0];

            $display("%h", sboxin[0]);

            tmp[0] = sboxout[0];
            tmp[1] = sboxout[1];
            tmp[2] = sboxout[2];
            tmp[3] = sboxout[3];

            $display("%h", sboxout[0]);
        end
        j = i*4;
        k = (i-1)*4;
        out[8*j+:8] = out[8*k+:8] ^ tmp[0];
        out[(8*(j+1))+:8] = out[(8*(k+1))+:8] ^ tmp[1];
        out[(8*(j+2))+:8] = out[(8*(k+2))+:8] ^ tmp[2];
        out[(8*(j+3))+:8] = out[(8*(k+3))+:8] ^ tmp[3];
        i = i + 1;
    end else begin
        finish = 1'b1;
    end
    end

endmodule
