`timescale 1ns / 1ps

module MixColumns(
  input wire clk,
  input wire[127:0] initial_state,
  output reg[127:0] output_state
    );
  //enc_row her biri 32 bitten olusan 4 bitlik veri tutar.
  // MixColumns adimindaki matrisin her bir sutununu 4 bitlerin her biri temsil eder.  
  reg[31:0] enc_row[3:0];
  always @(posedge clk)
  begin
   //Her yeni yukselen saat darbesinde enc_rowdaki degerleri kullanarak output olusturulur.
        output_state = {enc_row[3], enc_row[2], enc_row[1], enc_row[0]};
  end
  //gf_mult2 GaloisField(256)'da 2 ile Rijndael matrix carpimi yapan fonksiyondur.
  function [7 : 0] gf_mult2(input [7 : 0] c);
    begin
      gf_mult2 = {c[6 : 0], 1'b0} ^ (8'h1b & {8{c[7]}});
    end
  endfunction 
//gf_mult3 GaloisField(256)'da 3 ile Rijndael matrix carpimi yapan fonksiyondur.
  function [7 : 0] gf_mult3(input [7 : 0] c);
    begin
      gf_mult3 = gf_mult2(c) ^ c;
    end
   endfunction 
 
  
    always @(initial_state)
    begin: temp_mixCol
      //asagidaki 8 bit uzunlugundaki reglerin her biri farkli harf(a,b,c,d) olmak uzere 4*4luk matristeki bir sutunu gosterir.
      reg[7:0] a0,a1,a2,a3,b0, b1, b2, b3,c0,c1,c2,c3,d0,d1,d2,d3;
      //w herbiri 32 bitlik 4 sutundan olusan matrix gibi dusunulebilir. Yukarida tanimlanan enc_row un yerel degiskeni gibidir.
      reg[31:0] w[3:0];
      //w nin her bir sutununa inputun sirasiyla 32ser bitleri eklendi.
      w[0] = initial_state[31:0];
      w[1] = initial_state[63:32];
      w[2] = initial_state[95:64];
      w[3] = initial_state[127:96];

     //asagidaki farkli harflerin her bir rakam kombinasyonu(0,1,2,3) her bir sutundaki sirasiyla dizilmis 8 bitlik 4 elemani temsil eder.
     a0 = w[0][31:24];
     a1 = w[0][23 : 16];
     a2 = w[0][15 : 8];
     a3 = w[0][7:0];
     //////////////////////
     b0=w[1][31:24];
     b1 = w[1][23 : 16];
     b2 = w[1][15 : 8];
     b3 = w[1][7:0];
     ////////////////////////
     c0=w[2][31:24];
     c1 = w[2][23 : 16];
     c2 = w[2][15 : 8];
     c3 = w[2][7:0];
     //////////////////////
     d0=w[3][31:24];
     d1 = w[3][23 : 16];
     d2 = w[3][15 : 8];
     d3 = w[3][7:0];
     ////////////////////////
      
      
      
      //her bir sutun elemani sirasiyla
      //  _       _
      // | 2 3 1 1 |
      // | 1 2 3 1 |
      // | 1 1 2 3 |   Rijndael Galois Filed matrix ile carpilir.2 ve 3 ile carpim polinomal olarak 2 yi x gibi 3 u de x+1 gibi kabul ederk isler.
      // | 3 1 1 2 |
      // -         -
      enc_row[0][31:24] = gf_mult2(a0)  ^ gf_mult3(a1)^ a2 ^ a3;
      enc_row[0][23 : 16] = a0  ^ gf_mult2(a1)^ gf_mult3(a2) ^ a3;
      enc_row[0][15 : 8] = a0  ^ a1^ gf_mult2(a2) ^ gf_mult3(a3);
      enc_row[0][7:0] = gf_mult3(a0)  ^ a1^ a2 ^ gf_mult2(a3);
      
      enc_row[1][31:24] = gf_mult2(b0)  ^ gf_mult3(b1)^ b2 ^ b3;
      enc_row[1][23 : 16] = b0  ^ gf_mult2(b1)^ gf_mult3(b2) ^ b3;
      enc_row[1][15 : 8] = b0  ^ b1^ gf_mult2(b2) ^ gf_mult3(b3);
      enc_row[1][7:0] = gf_mult3(b0)  ^ b1^ b2 ^ gf_mult2(b3);
      
      
      enc_row[2][31:24] = gf_mult2(c0)  ^ gf_mult3(c1)^ c2 ^ c3;
      enc_row[2][23 : 16] = c0  ^ gf_mult2(c1)^ gf_mult3(c2) ^ c3;
      enc_row[2][15 : 8] = c0  ^ c1^ gf_mult2(c2) ^ gf_mult3(c3);
      enc_row[2][7:0] = gf_mult3(c0)  ^ c1^ c2 ^ gf_mult2(c3);
      
      
      enc_row[3][31:24] = gf_mult2(d0)  ^ gf_mult3(d1)^ d2 ^ d3;
      enc_row[3][23 : 16] = d0  ^ gf_mult2(d1)^ gf_mult3(d2) ^ d3;
      enc_row[3][15 : 8] = d0  ^ d1^ gf_mult2(d2) ^ gf_mult3(d3);
      enc_row[3][7:0] = gf_mult3(d0)  ^ d1^ d2 ^ gf_mult2(d3);
             
      end
   
endmodule
