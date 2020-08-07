`timescale 1ns / 1ps

module aes_engine(
  input         clk,
  input         rst,
  
  input[127:0]  anahtar,
  input[127:0]  blok,
  
  input         g_gecerli,
  output        hazir,
  
  output[127:0] sifre,
  output        c_gecerli
  );
 
  assign hazir = 1'b1;
  assign sifre = blok ^ anahtar;
  assign c_gecerli = g_gecerli;

endmodule
