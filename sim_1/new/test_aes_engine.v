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
     
  wire[127:0] anahtar = {{64{1'b1}},{64{1'b0}}};

  wire hazir;
  wire c_gecerli;
  (*dont_touch = "true"*) reg [6:0] c_count;
  (*dont_touch = "true"*) reg [127:0] sifre_r;
  wire [127:0] sifre;

  wire clk_deriv;
  wire mmcm_locked;
  
  reg[127:0] blok = { 8'h0, 8'h1, 8'h2, 8'h3, 8'h4, 8'h5, 8'h6, 8'h7, 8'h8, 8'h9, 8'hA, 8'hB, 8'hC, 8'hD, 8'hE, 8'hF };
  
  reg clk = 1'b0;
  reg rst = 1'b0;
  
    aes_engine aes_engine_i
  (
    .clk(clk),
    .rst(rst | ~mmcm_locked),
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
