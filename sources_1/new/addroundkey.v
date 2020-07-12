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
                   output finish
                   );         
    integer i;
    always@* 
    begin
        if (start)
        begin
            for (i = 0; i < 128; i = i + 1) 
            begin
                result[i] = result[i] ^ key[roundnumber * 128 + i];
            end
        end
    end
    
    always@(posedge clk)
        result <= state;
    begin
        
    end
endmodule
