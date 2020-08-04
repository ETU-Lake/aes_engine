`timescale 1ns / 1ps

/*
shiftrows oncesi   shiftrows sonrasi
00	04	08	0c		00	04	08	0c
01	05	09	0d		05	09	0d  01
02	06	0a	0e		0a	0e  02	06
03	07	0b	0f		0f	03	07	0b

Giris: 00  01  02  03  04  05  06  07  08  09  0a  0b  0c  0d  0e  0f
Cikis: 00  05  0a  0f  04  09  0e  03  08  0d  02  07  0c  01  06  0b
*/

module test_shiftrows( );

reg [127:0]IN;
wire [127:0]OUT;

shiftrows test(
.state(IN),
.out(OUT)
);

initial begin

IN[127:120]=8'd0;  IN[119:112]=8'd1;  IN[111:104]=8'd2;  IN[103:96]=8'd3;
IN[95:88]=8'd4;    IN[87:80]=8'd5;    IN[79:72]=8'd6;    IN[71:64]=8'd7;
IN[63:56]=8'd8;    IN[55:48]=8'd9;    IN[47:40]=8'd10;   IN[39:32]=8'd11;
IN[31:24]=8'd12;   IN[23:16]=8'd13;   IN[15:8]=8'd14;    IN[7:0]=8'd15;

end

endmodule
