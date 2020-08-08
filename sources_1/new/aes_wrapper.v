`timescale 1ns / 1ps

module aes_wrapper(
  input clk,
  input rst,

  output bitti
  );

  /*
  reg clk = 0, rst;

  always begin
    clk = #5 ~clk;
  end

  initial begin
    rst = 1;
    #100;
    rst = 0;
  end
  */

  wire[127:0] anahtar = {{64{1'b1}},{64{1'b0}}};

  wire hazir;
  wire c_gecerli;
  (*dont_touch = "true"*) reg [6:0] c_count;
  (*dont_touch = "true"*) reg [127:0] sifre_r;
  wire [127:0] sifre;

  wire clk_deriv;
  wire mmcm_locked;

  reg[127:0] blok;

  clk_wiz cw_i
  (
    .clk_in1(clk),
    .clk_out1(clk_deriv),
    .reset(rst),
    .locked(mmcm_locked)
  );

  // ----------------------------------------------------------
  // -------------- Asagidakileri degistirebilirsiniz ---------
  // ----------------------------------------------------------

  // Projede gelistirdiginiz modulu
  // bu sekilde olusturup ayni giris
  // cikislari baglayin.
  // Ya da bu ornekle verilen aes_engine
  // modulunun icinde de olusturabilirsiniz.
  aes_engine aes_engine_i
  (
    .clk(clk_deriv),
    .rst(rst | ~mmcm_locked),
    .anahtar(anahtar),
    .blok(blok),
    // Modul calismaya FIFO doldugunda baslayacak
    .g_gecerli(1'b1),
    .hazir(hazir),
    .sifre(sifre),
    .c_gecerli(c_gecerli)
  );

  // ----------------------------------------------------------
  // -------------- Buradan sonraki kodu degistirmeyin --------
  // ----------------------------------------------------------
  assign bitti = (&c_count);

  reg[31:0] yurutme_zamani;
  reg       saymaya_basla;

  always @(posedge clk_deriv) begin
    sifre_r <= sifre;
    if(rst | ~mmcm_locked) begin
      c_count <= 0;
      yurutme_zamani <= 0;
      saymaya_basla <= 0;
      blok <= 0;
    end
    else begin
      blok <= (blok << 1) | 1'b1;
      saymaya_basla <= hazir ? 1'b1 : saymaya_basla;
      if(saymaya_basla)
        yurutme_zamani <= yurutme_zamani + 1;
      else
        yurutme_zamani <= yurutme_zamani;
      if(c_gecerli)
        c_count <= c_count + 1;
      else
        c_count <= c_count;
    end
  end


endmodule
