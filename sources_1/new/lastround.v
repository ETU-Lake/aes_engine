`timescale 1ns / 1ps

module lastround (
        input clk,
        input rst,
        input [127:0] key,
        input [127:0] state,
        output reg [127:0] out
);

    wire finish;

    wire [127:0] subbytes_out;
    wire [127:0] shiftrows_out;

    subbytes do_subbytes(.state(state), .out(subbytes_out));
    shiftrows do_shiftrows(.state(subbytes_out), .out(shiftrows_out));

    always @ (rst) begin
        out <= 128'd0;
    end

    always @ (posedge clk)
        if (~rst) begin
            out <= shiftrows_out ^ key;
        end
    begin

    end
endmodule
