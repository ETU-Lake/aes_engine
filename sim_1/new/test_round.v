`timescale 1ns / 1ps

module test_round();

    reg [127:0] key_first, key_second, state;
    wire [127:0] out, step;
    reg clk;

    round first (
        .clk(clk),
        .state(state),
        .key(key_first),
        .out(step)
    );

    round second (
        .clk(clk),
        .state(step),
        .key(key_second),
        .out(out)
    );

    initial begin
        clk = 1'b0;
        state[127:120]=8'd0;  state[119:112]=8'd1;  state[111:104]=8'd2;  state[103:96]=8'd3;
        state[95:88]=8'd4;    state[87:80]=8'd5;    state[79:72]=8'd6;    state[71:64]=8'd7;
        state[63:56]=8'd8;    state[55:48]=8'd9;    state[47:40]=8'd10;   state[39:32]=8'd11;
        state[31:24]=8'd12;   state[23:16]=8'd13;   state[15:8]=8'd14;    state[7:0]=8'd15;
        key_first = {8'h37, 8'hf8, 8'h06, 8'h50, 8'h1c, 8'h32, 8'hee, 8'h52, 8'h5b, 8'h58, 8'hc7, 8'h67, 8'h79, 8'haf, 8'h9a, 8'h41};
        key_second = 128'h6e4085e672726bb4292aacd350853692;
    end

    always begin
        clk = ~clk; #1;
    end
endmodule
