`timescale 1ns / 1ps

//Mesaj sinyali 8'er bit olarak ayr�lm�� olup her 8 biti s box'a input olarak verilip
//sbox da transformasyona u�rayacakt�r. 
//Ve sbox dan gelen output da subbyte'�n outputunu olu�turacakt�r. 
//Yani mesaj sinyalindeki de�erler sbox'daki de�erler ile yer de�i�tirilmi� olacakt�r.

module subbytes(
input [127:0] blok, 
output [127:0] sb 
    );
    
   // 8 bit yani 1 byte yer de�i�tiriliyor
     sbox s0( .in(blok[127:120]),.out(sb[127:120]) );
     sbox s1( .in(blok[119:112]),.out(sb[119:112]) );
     sbox s2( .in(blok[111:104]),.out(sb[111:104]) );
     sbox s3( .in(blok[103:96]),.out(sb[103:96]) );
     
     sbox s4( .in(blok[95:88]),.out(sb[95:88]) );
     sbox s5( .in(blok[87:80]),.out(sb[87:80]) );
     sbox s6( .in(blok[79:72]),.out(sb[79:72]) );
     sbox s7( .in(blok[71:64]),.out(sb[71:64]) );
     
     sbox s8( .in(blok[63:56]),.out(sb[63:56]) );
     sbox s9( .in(blok[55:48]),.out(sb[55:48]) );
     sbox s10(.in(blok[47:40]),.out(sb[47:40]) );
     sbox s11(.in(blok[39:32]),.out(sb[39:32]) );
     
     sbox s12(.in(blok[31:24]),.out(sb[31:24]) );
     sbox s13(.in(blok[23:16]),.out(sb[23:16]) );
     sbox s14(.in(blok[15:8]),.out(sb[15:8]) );
     sbox s16(.in(blok[7:0]),.out(sb[7:0]) );
    

endmodule




