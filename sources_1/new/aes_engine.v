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
  wire finish1, finish2;
 
  assign hazir = finish1;
  assign states[0] = blok;
  assign sifre = states[10];
  assign c_gecerli = g_gecerli;
  
  genvar i;

  keyexpansion expander(.key(anahtar), .start(~finish1), .clk(clk), .rst(rst), .out(expanded), .finish(finish1)); // ensure run once
  addroundkey addrk(.state(blok), .key(expanded), .roundnumber(0), .start(finish1), .clk(clk), .rst(rst), .out(states[0]), .finish(finish2));

  
  generate for (i = 1; i < 10; i = i + 1)
  begin
    round rnd(.clk(clk), .rst(rst), .start(finish2), .key(expanded), .state(states[i - 1]), .roundnumber(i), .out(states[i]));
  end
  endgenerate
  
  lastround last(.clk(clk), .rst(rst), .start(finish2), .key(expanded), .state(states[9]), .out(states[10]));
  
endmodule
