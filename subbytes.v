`timescale 1ns / 1ps

//Mesaj sinyalini 8'er bit olarak ayırıp her 8 bitini s box'a input olarak verilip
//sbox da linear transformasyona ugrayacak. 
//Ve sbox'dan gelen output da subbyte'in outputu olacaktir. 
//Yani mesaj sinyalindeki degerler sbox'dakilerle yer degistirilmis olacaktir.

module subbytes(
input [127:0] state, 
output [127:0] out  //Bu asamadan sonra cikti ShiftRows'a gidecektir
    );
   // 8 bit yani 1 byte yer degistiriliyor
     sbox s0( .in(state[127:120]),.out(out[127:120]) );
     sbox s1( .in(state[119:112]),.out(out[119:112]) );
     sbox s2( .in(state[111:104]),.out(out[111:104]) );
     sbox s3( .in(state[103:96]),.out(out[103:96]) );
     
     sbox s4( .in(state[95:88]),.out(out[95:88]) );
     sbox s5( .in(state[87:80]),.out(out[87:80]) );
     sbox s6( .in(state[79:72]),.out(out[79:72]) );
     sbox s7( .in(state[71:64]),.out(out[71:64]) );
     
     sbox s8( .in(state[63:56]),.out(out[63:56]) );
     sbox s9( .in(state[55:48]),.out(out[55:48]) );
     sbox s10(.in(state[47:40]),.out(out[47:40]) );
     sbox s11(.in(state[39:32]),.out(out[39:32]) );
     
     sbox s12(.in(state[31:24]),.out(out[31:24]) );
     sbox s13(.in(state[23:16]),.out(out[23:16]) );
     sbox s14(.in(state[15:8]),.out(out[15:8]) );
     sbox s16(.in(state[7:0]),.out(out[7:0]) );
    

endmodule


