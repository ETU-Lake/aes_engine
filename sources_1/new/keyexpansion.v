`timescale 1ns / 1ps

/* Quirk: Reset signal overrides start. */

module keyexpansion (
    input [127:0] key,
    input start,
    input clk,
    input rst,
    output reg [1407:0] out,
    output finish
);
    reg [10:0] i, j, k;
    reg [7:0] tmp[3:0], sboxin[3:0], rcon;
    reg run, done;

    wire [7:0] sboxout[3:0];

    sbox tmp1 (.in(sboxin[0]), .out(sboxout[0]));
    sbox tmp2 (.in(sboxin[1]), .out(sboxout[1]));
    sbox tmp3 (.in(sboxin[2]), .out(sboxout[2]));
    sbox tmp4 (.in(sboxin[3]), .out(sboxout[3]));

    assign finish = done;

    initial begin
        run <= 1'b0;
        done <= 1'b0;
        i <= 10'd4;
        rcon <= 8'd0;
        out = 1048'd0;
    end

    /*
     * This can run in both posedge and negedge. Heavy sbox operations are
     * seperated across 2 cycles.
     */
    always @ (clk) begin
        if (rst) begin
            run <= 1'b0;
            i <= 10'd4;
            done <= 1'b0;
            rcon <= 8'd0;
        end else if (start && ~run) begin
            out = 1048'd0;
            out[1407-:128] = key;
            run = ~run;
        end

        if (run) begin
            if (i < 44) begin
                k = (i-1)*4;

                tmp[0] = out[1407-(8*(k+0))-:8];
                tmp[1] = out[1407-(8*(k+1))-:8];
                tmp[2] = out[1407-(8*(k+2))-:8];
                tmp[3] = out[1407-(8*(k+3))-:8];

                if (i%4 == 0) begin
                    if (rcon == 0) begin
                        sboxin[0] = tmp[1];
                        sboxin[1] = tmp[2];
                        sboxin[2] = tmp[3];
                        sboxin[3] = tmp[0];
                        case (i/4)
                            8'd0: rcon  = 8'h8D;
                            8'd1: rcon  = 8'h01;
                            8'd2: rcon  = 8'h02;
                            8'd3: rcon  = 8'h04;
                            8'd4: rcon  = 8'h08;
                            8'd5: rcon  = 8'h10;
                            8'd6: rcon  = 8'h20;
                            8'd7: rcon  = 8'h40;
                            8'd8: rcon  = 8'h80;
                            8'd9: rcon  = 8'h1B;
                            8'd10: rcon = 8'h36;
                        endcase
                    end else begin
                        tmp[0] = sboxout[0];
                        tmp[1] = sboxout[1];
                        tmp[2] = sboxout[2];
                        tmp[3] = sboxout[3];
                        tmp[0] = tmp[0] ^ rcon;

                        rcon = 0;
                    end
                end

                if (rcon == 0) begin
                    j = i*4;
                    k = (i-4)*4;
                    out[1407-8*j-:8]       = out[1407-8*k-:8] ^ tmp[0];
                    out[1407-(8*(j+1))-:8] = out[1407-(8*(k+1))-:8] ^ tmp[1];
                    out[1407-(8*(j+2))-:8] = out[1407-(8*(k+2))-:8] ^ tmp[2];
                    out[1407-(8*(j+3))-:8] = out[1407-(8*(k+3))-:8] ^ tmp[3];
                    i = i+1;
                end

            end else begin
                done = 1'b1;
            end
        end
    end
endmodule
