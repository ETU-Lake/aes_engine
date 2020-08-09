`timescale 1ns / 1ps

module test_aes_engine();

  wire hazir;
  wire c_gecerli;
  (*dont_touch = "true"*) reg [6:0] c_count;
  (*dont_touch = "true"*) reg [127:0] sifre_r;
  wire [127:0] sifre;

  reg [127:0] blok, anahtar;
  reg clk, rst, g_gecerli;

  aes_engine aes_engine_i (
    .clk(clk),
    .rst(rst),
    .anahtar(anahtar),
    .blok(blok),
    // Modul calismaya FIFO doldugunda baslayacak
    .g_gecerli(g_gecerli),
    .hazir(hazir),
    .sifre(sifre),
    .c_gecerli(c_gecerli)
  );

  initial begin
      anahtar = { 8'h65, 8'h78, 8'h70, 8'h61, 8'h6E, 8'h64, 8'h20, 8'h33, 8'h32, 8'h2D, 8'h62, 8'h79, 8'h74, 8'h65, 8'h20, 8'h6B };
      clk = 1'b0; rst = 1'b0; g_gecerli = 1'b0; blok = 128'h123;
      #90;
      blok = { 8'h71, 8'h77, 8'h65, 8'h72, 8'h74, 8'h79, 8'h75, 8'h69, 8'h6f, 8'h70, 8'h61, 8'h73, 8'h64, 8'h66, 8'h67, 8'h68 };
      #90;
      rst = 1'b1; #2; rst = 1'b0;
  end

  always @ (posedge hazir) begin
          #4; g_gecerli = 1'b1; #4; g_gecerli = 1'b0;
  end

  always begin
      clk = ~clk; #1;
  end

endmodule
