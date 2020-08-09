`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/09/2020 12:21:05 PM
// Design Name: 
// Module Name: test_aes_engine
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


module test_aes_engine(

    );
     
  wire[127:0] anahtar = {8'h65, 8'h78, 8'h70, 8'h61, 8'h6E, 8'h64, 8'h20, 8'h33,
              8'h32, 8'h2D, 8'h62, 8'h79, 8'h74, 8'h65, 8'h20, 8'h6B };

  wire hazir;
  wire c_gecerli;
  (*dont_touch = "true"*) reg [6:0] c_count;
  (*dont_touch = "true"*) reg [127:0] sifre_r;
  wire [127:0] sifre;
  
  reg[127:0] blok = { 8'h71, 8'h77, 8'h65, 8'h72, 8'h74, 8'h79, 8'h75, 8'h69, 8'h6f, 8'h70, 8'h61, 8'h73, 8'h64, 8'h66, 8'h67, 8'h68 };
  
  reg clk = 1'b0;
  reg rst = 1'b0;
  
    aes_engine aes_engine_i
  (
    .clk(clk),
    .rst(rst),
    .anahtar(anahtar),
    .blok(blok),
    // Modul calismaya FIFO doldugunda baslayacak
    .g_gecerli(1'b1),
    .hazir(hazir),
    .sifre(sifre),
    .c_gecerli(c_gecerli)
  );
  
  always 
  begin
    clk = ~clk; #1;
  end
  
endmodule
