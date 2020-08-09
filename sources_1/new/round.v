`timescale 1ns / 1ps

module round (
        input clk,
        input rst,
        input [127:0] key,
        input [127:0] state,
        output reg [127:0] out
);

    wire finish;
    wire [127:0] subbytes_out;
    wire [127:0] shiftrows_out;
    wire [127:0] mixcolumns_out;

    subbytes do_subbytes (.state(state), .out(subbytes_out));
    shiftrows do_shiftrows (.state(subbytes_out), .out(shiftrows_out));
    mixcolumns do_mixcolumns (.state(shiftrows_out), .clk(clk), .out(mixcolumns_out));

    always @ (posedge clk) begin
        out <= mixcolumns_out ^ key;
    end
endmodule
