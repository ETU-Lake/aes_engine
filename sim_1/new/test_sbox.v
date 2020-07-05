`timescale 1ns / 1ps

module test_sbox();
    reg [7:0] in;
    wire [7:0] out;

    sbox uut (
        .in(in),
        .out(out)
    );

    initial begin
        in = 8'd0;

        while (in != 8'b11111111) begin
            #3; in = in + 8'd1;
        end
    end
endmodule
