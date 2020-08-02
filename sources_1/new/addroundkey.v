`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2020 02:52:47 PM
// Design Name: 
// Module Name: addroundkey
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module addroundkey(input [127:0] state, // State blok
                   input [1407:0] key, // Expanded key
                   input [3:0] roundnumber, // Current round
                   input start, // Start signal
                   input clk, // Clock input
                   input rst, // Reset input
                   output reg [127:0] result, // Output modified state
                   output reg finish
                   );         
    integer i;
    reg [127:0] result_prev;
    
    reg finish_prev = 1'b0;
    reg run = 1'b0;
    
    always@* 
    begin
        if (start && ~run)
        begin
            run = ~run;
            for (i = 0; i < 128; i = i + 1) 
                result_prev[i] = state[i] ^ key[roundnumber * 128 + i];
            finish_prev = 1'b1;      
        end
        else
            finish_prev = 1'b0;
    end
    
    always@(posedge clk)
    begin
        if (rst)
        begin
            result <= 0;
            finish <= 0;
        end else
        begin
            result <= result_prev;
            finish <= finish_prev;
        end
    end
endmodule
