`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/07/2020 12:08:49 PM
// Design Name: 
// Module Name: round
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


module round(
        input clk,
        input rst,
        input [1407:0] key,
        input start,
        input [127:0] state,
        input [3:0] roundnumber,
        output reg [127:0] out
    );
    
    wire finish;
    wire [127:0] sb_out;
    wire [127:0] shrw_out;
    wire [127:0] mixcl_out;
    wire [127:0] addrk_out;

    subbytes sb(.state(state), .out(sb_out));
    shiftrows shrw(.state(sb_out), .out(shrw_out));
    mixcolumns mixcl (.state(shrw_out), .clk(clk), .out(mixcl_out));
    addroundkey addrk(.state(mixcl_out), .key(key), .roundnumber(roundnumber), .start(start), .clk(clk), .rst(rst), .out(addrk_out), .finish(finish));
    
    always@(posedge clk)
    begin
        if (state) out <= addrk_out;
    end
endmodule
