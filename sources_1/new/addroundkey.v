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

    reg finish_next = 1'b0;
    reg ready = 1'b1;

    always@ (state or start or ready)
    begin
        if (start && ready && ~finish_next)
        begin
            finish_next = 0;
            ready = ~ready;
            for (i = 0; i < 128; i = i + 1)
                result_next[i] = state[i] ^ key[roundnumber * 128 + i];
            ready = ~ready;
            finish_next = 1;
            out = result_next;
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
