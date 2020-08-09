`timescale 1ns / 1ps

module test_keyexpansion();
    reg [127:0] in, part, before, after;
    wire [1407:0] out;
    wire finish;
    reg clk, rst, start;

    keyexpansion uut(
        .key(in),
        .start(start),
        .clk(clk),
        .rst(rst),
        .finish(finish),
        .out(out)
    );

    initial begin
        clk = 0; rst = 0; start = 0;
        in = {8'h65, 8'h78, 8'h70, 8'h61, 8'h6E, 8'h64, 8'h20, 8'h33,
              8'h32, 8'h2D, 8'h62, 8'h79, 8'h74, 8'h65, 8'h20, 8'h6B };
        before[127:120]=8'd0;  before[119:112]=8'd1;  before[111:104]=8'd2;  before[103:96]=8'd3;
        before[95:88]=8'd4;    before[87:80]=8'd5;    before[79:72]=8'd6;    before[71:64]=8'd7;
        before[63:56]=8'd8;    before[55:48]=8'd9;    before[47:40]=8'd10;   before[39:32]=8'd11;
        before[31:24]=8'd12;   before[23:16]=8'd13;   before[15:8]=8'd14;    before[7:0]=8'd15;
        #2;
        start = 1;
    end

    always begin
        clk = ~clk; #1;
        if (finish) begin
           part = out[(1407-128*6)-:128];
           after = before ^ part;
       end
    end
endmodule
