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
  wire key_expanded;
  reg run;

  assign hazir = key_expanded & run;
  assign sifre = states[10];
  assign c_gecerli = g_gecerli;

  genvar i;

  keyexpansion do_keyexpansion(.key(anahtar), .start(~run), .clk(clk), .rst(rst), .out(expanded), .finish(key_expanded));

  assign states[0] = blok ^ expanded[1407-:128];

  generate for (i = 1; i < 10; i = i + 1)
    begin
        round do_round(.clk(clk & run), .rst(rst), .key(expanded[(1407-128*i)-:128]), .state(states[i - 1]), .out(states[i]));
    end
  endgenerate

  lastround last(.clk(clk & run), .rst(rst), .key(expanded[127:0]), .state(states[9]), .out(states[10]));

  initial begin
      run = 1'b0;
  end

  always @ (posedge clk) begin
      if (rst) begin
          run = 1'b0;
      end else if (key_expanded) begin
          run = 1'b1;
      end
  end

endmodule
