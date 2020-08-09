`timescale 1ns / 1ps

module addroundkey(input [127:0] state, // State blok
                   input [1407:0] key, // Expanded key
                   input [3:0] roundnumber, // Current round
                   input start, // Start signal
                   input clk, // Clock input
                   input rst, // Reset input
                   output reg [127:0] out, // Output modified state
                   output reg finish
                   );
    integer i;
    reg [127:0] result_next;

    
    reg ready = 1'b1;

    initial finish = 1'b0;
    
    always@*
    begin
        if (start)
        begin
            finish = 0;
            out = key[(1407-128*roundnumber)-:128] ^ state;
            finish = 1;
        end
    end

    /*always@(posedge clk)
    begin
        if (rst)
        begin
            out <= 0;
            finish <= 0;
            finish_next <= 0;
        end else
        begin
            out <= result_next;
            finish <= finish_next;
        end
    end*/
endmodule
