`timescale 1ns / 1ps
/*
4x4l�k bir matrise 128 bit yerle�tirildi�inde a�a��daki gibi dizilir.

127:120	  119:112   111:104	  103:96
95:88	  87:80	    79:72	  71:64
63:56	  55:48	    47:40	  39:32
31:24	  23:16	    15:8	  7:0

*/
module shiftrows(
input [127:0]in,
output [127:0]out
    );

//1. Sat�r elemanlar� 0 birim sola kayd�r�l�yor. De�i�iklik yap�lm�yor. 
//1. Sat�r�n �nceki hali:   127:120	 119:112   111:104 	 103:96
//1. Sat�r�n �imdiki hali:  127:120	 119:112   111:104 	 103:96
assign out[127:96]=in[127:96];
    
//2. Sat�r elemanlar� 1 birim sola kayd�r�l�yor.
//2. Sat�r�n �nceki hali:  95:88	87:80	  79:72	    71:64
//2. Sat�r�n �imdiki hali: 87:80	79:72	  71:64     95:88
assign out[95:88]=in[87:80];
assign out[87:80]=in[79:72];
assign out[79:72]=in[71:64];
assign out[71:64]=in[95:88];

//3. Sat�r elemanlar� 2 birim sola kayd�r�l�yor.
//3. Sat�r�n �nceki hali:  63:56  55:48	  47:40	  39:32
//3. Sat�r�n �imdiki hali: 47:40  39:32   63:56	  55:48
assign out[63:56]=in[47:40];
assign out[55:48]=in[39:32];
assign out[47:40]=in[63:56];
assign out[39:32]=in[55:48];

//4. Sat�r elemanlar� 3 birim sola kayd�r�l�yor.
//4. Sat�r�n �nceki hali:   31:24 	 23:16	  15:8	   7:0
//4. Sat�r�n �imdiki hali:  7:0	     31:24	  23:16	   15:8	  
assign out[31:24]=in[7:0];
assign out[23:16]=in[31:24];
assign out[15:8]=in[23:16];
assign out[7:0]=in[15:8];

endmodule
