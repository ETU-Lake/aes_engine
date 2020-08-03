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
  //low_time fonksiyonu, ?ifreleme s?ras?nda gerekli olan x'in alt kuvvetleri için GF(256) galois filedinda çarpma islemi yapar.
  
  function [7:0] low_time;
    input [7:0] x;
    begin
      low_time = (x & 8'h80) ? ((x << 1) ^ 8'h1B) : (x << 1);
    end
  endfunction
 
  //Her input state degisiminde MixColumns matrisindeki degerleri gunceller.
  //MixColumns algoritmasi her seferinde tek sutun uzerinde islem yaptigindan tek bir loop kullanarak butun sutunlari paralel olarak guncelleyebiliriz.
 
  generate for (i = 0; i < 4; i = i + 1) begin: gen_loop_enc
    always @(initial_state)
    begin: enc_colMix
      //Bu algoritma Rijndael algoritmasinda MixColumns icin hesaplanan Galois Filed(256)lik matris carpimi ile tasarlandi.
      reg[7:0] b0, b1, b2, b3, temp;
      reg[32 - 1:0] r[3:0];
      r[0] = initial_state[31:0];
      r[1] = initial_state[63:32];
      r[2] = initial_state[95:64];
      r[3] = initial_state[127:96];
 
      b0 = r[0][((i + 1) * 8) - 1:(i * 8)];
      b1 = r[1][((i + 1) * 8) - 1:(i * 8)];
      b2 = r[2][((i + 1) * 8) - 1:(i * 8)];
      b3 = r[3][((i + 1) * 8) - 1:(i * 8)];
      temp = b0 ^ b1 ^ b2 ^ b3;
      enc_row[0][((i + 1) * 8) - 1:(i * 8)] = r[0][((i + 1) * 8) - 1:(i * 8)] ^ temp ^ xtime(b0 ^ b1);
      enc_row[1][((i + 1) * 8) - 1:(i * 8)] = r[1][((i + 1) * 8) - 1:(i * 8)] ^ temp ^ xtime(b1 ^ b2);
      enc_row[2][((i + 1) * 8) - 1:(i * 8)] = r[2][((i + 1) * 8) - 1:(i * 8)] ^ temp ^ xtime(b2 ^ b3);
      enc_row[3][((i + 1) * 8) - 1:(i * 8)] = r[3][((i + 1) * 8) - 1:(i * 8)] ^ temp ^ xtime(b3 ^ b0);
    end
  end
  endgenerate

endmodule
