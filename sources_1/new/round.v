`timescale 1ns / 1ps

module round (
    input clk,
    input rst,
    input [127:0] key,
    input [127:0] state,
    output reg [127:0] out
);
    wire [127:0] subbytes_out, shiftrows_out, mixcolumns_out, final;

    subbytes do_subbytes (.state(state), .out(subbytes_out));
    shiftrows do_shiftrows (.state(subbytes_out), .out(shiftrows_out));
    mixcolumns do_mixcolumns (.state(shiftrows_out), .out(mixcolumns_out));

    /* Addroundkey */
    assign final = mixcolumns_out ^ key;

    /* Reset the output with signal. (The clock stops afterwards.) */
    always @ (rst) begin
        out <= 128'd0;
    end

    /* At each clock strike, write the output */
    always @ (posedge clk) begin
        out <= final;
    end
endmodule
