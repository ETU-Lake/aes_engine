`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/29/2020 02:43:41 PM
// Design Name: 
// Module Name: test_addroundkey
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


module test_addroundkey(

    );
    
    reg clk = 1'b0; 
    reg rst = 1'b0;
    reg [127:0] state = { 8'h0, 8'h1, 8'h2, 8'h3, 8'h4, 8'h5, 8'h6, 8'h7, 8'h8, 8'h9, 8'hA, 8'hB, 8'hC, 8'hD, 8'hE, 8'hF };
    reg [1407:0] key = { 8'h65, 8'h78, 8'h70, 8'h61, 8'h6E, 8'h64, 8'h20, 8'h33, 8'h32, 8'h2D, 8'h62, 8'h79, 8'h74, 8'h65, 
                         8'h20, 8'h6B, 8'h29, 8'hCF, 8'hF, 8'hF3, 8'h47, 8'hAB, 8'h2F, 8'hC0, 8'h75, 8'h86, 8'h4D, 8'hB9, 
                         8'h1, 8'hE3, 8'h6D, 8'hD2, 8'h3A, 8'hF3, 8'hBA, 8'h8F, 8'h7D, 8'h58, 8'h95, 8'h4F, 8'h8, 8'hDE, 
                         8'hD8, 8'hF6, 8'h9, 8'h3D, 8'hB5, 8'h24, 8'h19, 8'h26, 8'h8C, 8'h8E, 8'h64, 8'h7E, 8'h19, 8'hC1, 
                         8'h6C, 8'hA0, 8'hC1, 8'h37, 8'h65, 8'h9D, 8'h74, 8'h13, 8'h4F, 8'hB4, 8'hF1, 8'hC3, 8'h2B, 8'hCA, 
                         8'hE8, 8'h2, 8'h47, 8'h6A, 8'h29, 8'h35, 8'h22, 8'hF7, 8'h5D, 8'h26, 8'h37, 8'hF8, 8'h6, 8'h50, 
                         8'h1C, 8'h32, 8'hEE, 8'h52, 8'h5B, 8'h58, 8'hC7, 8'h67, 8'h79, 8'hAF, 8'h9A, 8'h41, 8'h6E, 8'h40, 
                         8'h85, 8'hE6, 8'h72, 8'h72, 8'h6B, 8'hB4, 8'h29, 8'h2A, 8'hAC, 8'hD3, 8'h50, 8'h85, 8'h36, 8'h92, 
                         8'hB9, 8'h45, 8'hCA, 8'hB5, 8'hCB, 8'h37, 8'hA1, 8'h1, 8'hE2, 8'h1D, 8'hD, 8'hD2, 8'hB2, 8'h98, 
                         8'h3B, 8'h40, 8'h7F, 8'hA7, 8'hC3, 8'h82, 8'hB4, 8'h90, 8'h62, 8'h83, 8'h56, 8'h8D, 8'h6F, 8'h51, 
                         8'hE4, 8'h15, 8'h54, 8'h11, 8'h3D, 8'h87, 8'h41, 8'hEB, 8'h89, 8'h17, 8'h23, 8'h68, 8'hDF, 8'h9A, 
                         8'h4C, 8'h39, 8'h3B, 8'h8F, 8'h18, 8'h28, 8'h78, 8'h2A, 8'h75, 8'h9, 8'hF1, 8'h3D, 8'h56, 8'h61, 
                         8'h2E, 8'hA7, 8'h1A, 8'h58, 8'h15, 8'h28, 8'h2, 8'h70 };
    reg [3:0] roundnumber = 4'b0101;
    wire [127:0] result;
    wire finish;
    
    always #1 clk = ~clk;
    
    addroundkey uut(.state(state), // State blok
                   .key(key), // Expanded key
                   .roundnumber(roundnumber), // Current round
                   .start(1), // Start signal
                   .clk(clk), // Clock input
                   .rst(rst), // Reset input
                   .result(result), // Output modified state
                   .finish(finish)
                   );
                   
    always@(posedge clk)
    begin
        if (result == { 8'h37, 8'hF9, 8'h4, 8'h53, 
                        8'h18, 8'h37, 8'hE8, 8'h55, 
                        8'h53, 8'h51, 8'hCD, 8'h6C, 
                        8'h75, 8'hA2, 8'h94, 8'h4E })
        begin
            $display ("OK");
            $finish;
        end
    end
endmodule
