`timescale 1ns / 1ps


module MixColumns(
  input wire clk,
  input wire[127:0] initial_state,
  output reg[127:0] output_state
    );
    genvar i;
  reg[31:0] enc_row[3:0];
  always @(posedge clk)
  begin
   //Her yeni saat sinyalinde enc_rowdaki degerleri kullanarak output olusturulur.
        output_state = {enc_row[3], enc_row[2], enc_row[1], enc_row[0]};
  end
  //gf_mult fonksiyonu, ?ifreleme s?ras?nda gerekli olan x'in alt kuvvetleri için GF(256) galois filedinda çarpma islemi yapar.
  
  function [7:0] gf_mult;
    input [7:0] x;
    begin
      gf_mult = (x & 8'h80) ? ((x << 1) ^ 8'h1B) : (x << 1);
    end
  endfunction
 
  //Her input state degisiminde MixColumns matrisindeki degerleri gunceller.
  //MixColumns algoritmasi her seferinde tek sutun uzerinde islem yaptigindan tek bir loop kullanarak butun sutunlari paralel olarak guncelleyebiliriz.
 
  generate for (i = 0; i < 4; i = i + 1) begin: temp_loop
    always @(initial_state)
    begin: temp_mixCol
      //Bu algoritma Rijndael algoritmasinda MixColumns icin hesaplanan Galois Filed(256)lik matris carpimi ile tasarlandi.
      reg[7:0] b0, b1, b2, b3, temp;
      reg[31:0] w[3:0];
      w[0] = initial_state[31:0];
      w[1] = initial_state[63:32];
      w[2] = initial_state[95:64];
      w[3] = initial_state[127:96];
 
      b0 = w[0][((i + 1) * 8) - 1:(i * 8)];
      b1 = w[1][((i + 1) * 8) - 1:(i * 8)];
      b2 = w[2][((i + 1) * 8) - 1:(i * 8)];
      b3 = w[3][((i + 1) * 8) - 1:(i * 8)];
      temp = b0 ^ b1 ^ b2 ^ b3;
      enc_row[0][((i + 1) * 8) - 1:(i * 8)] = w[0][((i + 1) * 8) - 1:(i * 8)]  ^ gf_mult(b0 ^ b1)^ temp;
      enc_row[1][((i + 1) * 8) - 1:(i * 8)] = w[1][((i + 1) * 8) - 1:(i * 8)]  ^ gf_mult(b1 ^ b2)^ temp;
      enc_row[2][((i + 1) * 8) - 1:(i * 8)] = w[2][((i + 1) * 8) - 1:(i * 8)]  ^ gf_mult(b2 ^ b3)^ temp;
      enc_row[3][((i + 1) * 8) - 1:(i * 8)] = w[3][((i + 1) * 8) - 1:(i * 8)]  ^ gf_mult(b3 ^ b0)^ temp;
    end
  end
  endgenerate

endmodule
