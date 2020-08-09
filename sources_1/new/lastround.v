`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/07/2020 12:39:24 PM
// Design Name: 
// Module Name: lastround
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


module lastround(
        input clk,
        input rst,
        input [1407:0] key,
        input start,
        input [127:0] state,
        output reg [127:0] out
    );
    
    wire finish;
    
    wire [127:0] sb_out;
    wire [127:0] shrw_out;
    wire [127:0] addrk_out;
    
    subbytes sb(.state(state), .out(sb_out));
    shiftrows shrw(.state(sb_out), .out(shrw_out));
    addroundkey addrk(.state(shrw_out), .key(key), .roundnumber(10), .start(1), .clk(clk), .rst(rst), .out(addrk_out), .finish(finish));
    
    always@(posedge clk)
        if (state && start) out <= addrk_out; 
    begin 
        
    end
endmodule
