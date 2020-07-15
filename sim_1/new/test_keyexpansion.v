`timescale 1ns / 1ps

module test_keyexpansion();
    reg [127:0] in;
    wire [1407:0] out;
    wire finish;
    reg clk, rst, start;

    keyexpansion uut(
        .key(in),
        .start(start),
        .clk(clk),
        .rst(rst),
        .finish(finish),
        .out(out)
    );

    initial begin
        clk = 0; rst = 0; start = 0;
        //in = {8'h6b, 8'h20, 8'h65, 8'h64, 8'h79, 8'h62, 8'h2d, 8'h32,
          //  8'h33, 8'h20, 8'h64, 8'h6e, 8'h61, 8'h70, 8'h78, 8'h65 };
        in = {8'h65, 8'h78, 8'h70, 8'h61, 8'h6E, 8'h64, 8'h20, 8'h33, 
              8'h32, 8'h2D, 8'h62, 8'h79, 8'h74, 8'h65, 8'h20, 8'h6B };
        #2;
        start = 1;
    end

    always begin
        clk = ~clk; #1;
    end
endmodule
