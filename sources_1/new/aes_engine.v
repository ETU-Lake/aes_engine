`timescale 1ns / 1ps

module aes_engine(
    input clk,
    input rst,
    input anahtar[127:0],
    input blok[127:0],
    input g_gecerli,
    output hazir,
    output reg sifre[127:0],
    output c_gecerli
);

    reg [1407:0] key;

    initial begin
        run <= 1'b0;
        rnd_num <= 4'd0;
        c_gecerli <= 1'b0;
        sifre <= 128'd0;
    end

    always @ (posedge clk) begin
        if (rst) begin
           run <= 1'b0;
           rnd_num <= 4'd0;
           c_gecerli <= 1'b0;
           sifre <= 128'd0;
           hazir <= 1'b0;
        end else if (g_gecerli && ~run) begin
            run = ~run;
        end

        if (run) begin
        end
    end

endmodule
