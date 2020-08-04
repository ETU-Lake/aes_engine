`timescale 1ns / 1ps

module shiftrows(
input [127:0]state,
output [127:0]out
    );

// 4x4lük bir matrise 128 bit yerleþtirildiðinde aþaðýdaki gibi dizilirse

// 127:120	  95:88     63:56 	  31:24
// 119:112	  87:80	    55:48	  23:16
// 111:104	  79:72 	47:40	  15:8
// 103:96	  71:64	    39:32	  7:0

//1. Satir elemanlari 0 birim sola kaydiriliyor. Degisiklik yapilmiyor. 
//1. Satirin onceki hali:   127:120	   95:88    63:56 	  31:24
//1. Satirin simdiki hali:  127:120	   95:88    63:56 	  31:24
assign out[127:120]=state[127:120];
assign out[95:88]=state[95:88];
assign out[63:56]=state[63:56];
assign out[31:24]=state[31:24];
    
//2. Satir elemanlari 1 birim sola kaydiriliyor.
//2. Satirin onceki hali:  119:112	  87:80	    55:48	  23:16
//2. Satirin simdiki hali: 87:80	  55:48	    23:16    119:112
assign out[119:112]=state[87:80];
assign out[87:80]=state[55:48];
assign out[55:48]=state[23:16];
assign out[23:16]=state[119:112];

//3. Satir elemanlari 2 birim sola kaydiriliyor.
//3. Satirin onceki hali:   111:104	  79:72 	 47:40	    15:8
//3. Satirin simdiki hali: 	 47:40	   15:8     111:104	    79:72 
assign out[111:104]=state[47:40];
assign out[79:72]=state[15:8];
assign out[47:40]=state[111:104];
assign out[15:8]=state[79:72];

//4. Satir elemanlari 3 birim sola kaydiriliyor.
//4. Satirin onceki hali:   103:96	  71:64	    39:32	  7:0
//4. Satirin simdiki hali:   7:0     103:96	    71:64	 39:32	  	  
assign out[103:96]=state[7:0];
assign out[71:64]=state[103:96];
assign out[39:32]=state[71:64];
assign out[7:0]=state[39:32];


endmodule
