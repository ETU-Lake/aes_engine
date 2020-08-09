`timescale 1ns / 1ps

module aes_engine(
  input         clk,
  input         rst,

  input[127:0]  anahtar,
  input[127:0]  blok,

  input         g_gecerli,
  output        hazir,

  output[127:0] sifre,
  output        c_gecerli
  );

  wire [1407:0] expanded;
  wire [127:0] states[0:10];
  reg run;
  wire finish1, finish2;

  assign hazir = finish1;
  assign sifre = states[10];
  assign c_gecerli = g_gecerli;

  genvar i;

  keyexpansion expander(.key(anahtar), .start(~finish1), .clk(clk), .rst(rst), .out(expanded), .finish(finish1)); // ensure run once

  assign states[0] = blok ^ expanded[1407-:128];

  generate for (i = 1; i < 10; i = i + 1)
    begin
        round rnd(.clk(clk & finish1), .rst(rst), .key(expanded[(1407-128*i)-:128]), .state(states[i - 1]), .out(states[i]));
    end
  endgenerate

  lastround last(.clk(clk & finish1), .rst(rst), .key(expanded[127:0]), .state(states[9]), .out(states[10]));

  initial begin
      run = 1'b0;
  end

  always @ (posedge clk) begin
      if (finish1) begin
          run = 1'b1;
      end
  end

endmodule
