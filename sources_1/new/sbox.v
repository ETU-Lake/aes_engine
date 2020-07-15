`timescale 1ns / 1ps

/*
 * The S-box is made according to the paper specified in
 * https://eprint.iacr.org/2011/332.pdf. Because of the project's
 * focus, only the linear tranformations in forward direction is used.
 * Furthermore, it should be noted that the paper and verilog uses reverse
 * significance conventions so input/output indexes should be 7-$PAPERINDEX.
 */

module sbox(input [7:0] in, output [7:0] out);
    wire [26:0] top;
    wire [62:0] mid;
    wire [29:0] bot;

    /* Top linear transformation. */
    xor (top[ 0], in [ 7], in [ 4]);
    xor (top[ 1], in [ 7], in [ 2]);
    xor (top[ 2], in [ 7], in [ 1]);
    xor (top[ 3], in [ 4], in [ 2]);
    xor (top[ 4], in [ 3], in [ 1]);
    xor (top[ 5], top[ 0], top[ 4]);
    xor (top[ 6], in [ 6], in [ 5]);
    xor (top[ 7], in [ 0], top[ 5]);
    xor (top[ 8], in [ 0], top[ 6]);
    xor (top[ 9], top[ 5], top[ 6]);
    xor (top[10], in [ 6], in [ 2]);
    xor (top[11], in [ 5], in [ 2]);
    xor (top[12], top[ 2], top[ 3]);
    xor (top[13], top[ 5], top[10]);
    xor (top[14], top[ 4], top[10]);
    xor (top[15], top[ 4], top[11]);
    xor (top[16], top[ 8], top[15]);
    xor (top[17], in [ 4], in [ 0]);
    xor (top[18], top[ 6], top[17]);
    xor (top[19], top[ 0], top[18]);
    xor (top[20], in [ 1], in [ 0]);
    xor (top[21], top[ 6], top[20]);
    xor (top[22], top[ 1], top[21]);
    xor (top[23], top[ 1], top[ 9]);
    xor (top[24], top[19], top[16]);
    xor (top[25], top[ 2], top[15]);
    xor (top[26], top[ 0], top[11]);

    /* Middle linear transformation. */
    and (mid[ 0], top[12], top[ 5]);
    and (mid[ 1], top[22], top[ 7]);
    xor (mid[ 2], top[13], mid[ 0]);
    and (mid[ 3], top[18], in [ 0]);
    xor (mid[ 4], mid[ 3], mid[ 0]);
    and (mid[ 5], top[ 2], top[15]);
    and (mid[ 6], top[21], top[ 8]);
    xor (mid[ 7], top[25], mid[ 5]);
    and (mid[ 8], top[19], top[16]);
    xor (mid[ 9], mid[ 8], mid[ 5]);
    and (mid[10], top[ 0], top[14]);
    and (mid[11], top[ 3], top[26]);
    xor (mid[12], mid[11], mid[10]);
    and (mid[13], top[ 1], top[ 9]);
    xor (mid[14], mid[13], mid[10]);
    xor (mid[15], mid[ 2], mid[ 1]);
    xor (mid[16], mid[ 4], top[23]);
    xor (mid[17], mid[ 7], mid[ 6]);
    xor (mid[18], mid[ 9], mid[14]);
    xor (mid[19], mid[15], mid[12]);
    xor (mid[20], mid[16], mid[14]);
    xor (mid[21], mid[17], mid[12]);
    xor (mid[22], mid[18], top[24]);
    xor (mid[23], mid[21], mid[22]);
    and (mid[24], mid[21], mid[19]);
    xor (mid[25], mid[20], mid[24]);
    xor (mid[26], mid[19], mid[20]);
    xor (mid[27], mid[22], mid[24]);
    and (mid[28], mid[27], mid[26]);
    and (mid[29], mid[25], mid[23]);
    and (mid[30], mid[19], mid[22]);
    and (mid[31], mid[26], mid[30]);
    xor (mid[32], mid[26], mid[24]);
    and (mid[33], mid[20], mid[21]);
    and (mid[34], mid[23], mid[33]);
    xor (mid[35], mid[23], mid[24]);
    xor (mid[36], mid[20], mid[28]);
    xor (mid[37], mid[31], mid[32]);
    xor (mid[38], mid[22], mid[29]);
    xor (mid[39], mid[34], mid[35]);
    xor (mid[40], mid[37], mid[39]);
    xor (mid[41], mid[36], mid[38]);
    xor (mid[42], mid[36], mid[37]);
    xor (mid[43], mid[38], mid[39]);
    xor (mid[44], mid[41], mid[40]);
    and (mid[45], mid[43], top[ 5]);
    and (mid[46], mid[39], top[ 7]);
    and (mid[47], mid[38], in [ 0]);
    and (mid[48], mid[42], top[15]);
    and (mid[49], mid[37], top[ 8]);
    and (mid[50], mid[36], top[16]);
    and (mid[51], mid[41], top[14]);
    and (mid[52], mid[44], top[26]);
    and (mid[53], mid[40], top[ 9]);
    and (mid[54], mid[43], top[12]);
    and (mid[55], mid[39], top[22]);
    and (mid[56], mid[38], top[18]);
    and (mid[57], mid[42], top[ 2]);
    and (mid[58], mid[37], top[21]);
    and (mid[59], mid[36], top[19]);
    and (mid[60], mid[41], top[ 0]);
    and (mid[61], mid[44], top[ 3]);
    and (mid[62], mid[40], top[ 1]);

    /* Bottom linear transformation. */
    xor  (bot[ 0], mid[60], mid[61]);
    xor  (bot[ 1], mid[49], mid[55]);
    xor  (bot[ 2], mid[45], mid[47]);
    xor  (bot[ 3], mid[46], mid[54]);
    xor  (bot[ 4], mid[53], mid[57]);
    xor  (bot[ 5], mid[48], mid[60]);
    xor  (bot[ 6], mid[61], bot[ 5]);
    xor  (bot[ 7], mid[45], bot[ 3]);
    xor  (bot[ 8], mid[50], mid[58]);
    xor  (bot[ 9], mid[51], mid[52]);
    xor  (bot[10], mid[52], bot[ 4]);
    xor  (bot[11], mid[59], bot[ 2]);
    xor  (bot[12], mid[47], mid[50]);
    xor  (bot[13], mid[49], bot[ 0]);
    xor  (bot[14], mid[51], mid[60]);
    xor  (bot[15], mid[54], bot[ 1]);
    xor  (bot[16], mid[55], bot[ 0]);
    xor  (bot[17], mid[56], bot[ 1]);
    xor  (bot[18], mid[57], bot[ 8]);
    xor  (bot[19], mid[62], bot[ 4]);
    xor  (bot[20], bot[ 0], bot[ 1]);
    xor  (bot[21], bot[ 1], bot[ 7]);
    xor  (bot[22], bot[ 3], bot[12]);
    xor  (bot[23], bot[18], bot[ 2]);
    xor  (bot[24], bot[15], bot[ 9]);
    xor  (bot[25], bot[ 6], bot[10]);
    xor  (bot[26], bot[ 7], bot[ 9]);
    xor  (bot[27], bot[ 8], bot[10]);
    xor  (bot[28], bot[11], bot[14]);
    xor  (bot[29], bot[11], bot[17]);
    xor  (out[ 7], bot[ 6], bot[24]);
    xnor (out[ 6], bot[16], bot[26]);
    xnor (out[ 5], bot[19], bot[28]);
    xor  (out[ 4], bot[ 6], bot[21]);
    xor  (out[ 3], bot[20], bot[22]);
    xor  (out[ 2], bot[25], bot[29]);
    xnor (out[ 1], bot[13], bot[27]);
    xnor (out[ 0], bot[ 6], bot[23]);
endmodule
