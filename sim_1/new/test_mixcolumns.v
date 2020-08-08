`timescale 1ns / 1ps

module test_mixcolumns();

    reg [127:0] in;
    wire [127:0] out;

    mixcolumns uut1(
        .state(in),
        .out(out)
    );

    initial begin
        #1;
        in = 128'd0;
        #0.01;
        in = 128'd331;
        #0.01;
        in[127:120]=8'd0;  in[119:112]=8'd1;  in[111:104]=8'd2;  in[103:96]=8'd3;
        in[95:88]=8'd4;    in[87:80]=8'd5;    in[79:72]=8'd6;    in[71:64]=8'd7;
        in[63:56]=8'd8;    in[55:48]=8'd9;    in[47:40]=8'd10;   in[39:32]=8'd11;
        in[31:24]=8'd12;   in[23:16]=8'd13;   in[15:8]=8'd14;    in[7:0]=8'd15;
    end

endmodule
