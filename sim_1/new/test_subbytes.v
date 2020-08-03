`timescale 1ns / 1ps
module test_subbytes();
   
   
    reg [127:0] IN1;
    wire [127:0] OUT1;
    
    //subbytes'daki degerler cagiriliyor
    //subbytes'daki input IN1 ve output OUT1 olarak adlandirildi
    subbytes uut1(
    .state(IN1),
    .out(OUT1)
    );
    
    initial begin
IN1[127:120]=8'd0;  IN1[119:112]=8'd1;  IN1[111:104]=8'd2;  IN1[103:96]=8'd3;
IN1[95:88]=8'd4;    IN1[87:80]=8'd5;    IN1[79:72]=8'd6;    IN1[71:64]=8'd7;
IN1[63:56]=8'd8;    IN1[55:48]=8'd9;    IN1[47:40]=8'd10;   IN1[39:32]=8'd11;
IN1[31:24]=8'd12;   IN1[23:16]=8'd13;   IN1[15:8]=8'd14;    IN1[7:0]=8'd15;
    end
    
endmodule
