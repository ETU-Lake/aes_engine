`timescale 1ns / 1ps

module aes_engine(
    input clk,
    input rst,
    input anahtar[127:0],
    input blok[127:0],
    input g_gecerli,
    output hazir,
    output reg sifre[127:0],
    output c_gecerli
);

    reg [1407:0] key;
    reg [127:0] step;
    reg [3:0] roundnumber;
    reg [1:0] ctr;
    reg start_keyexpand, end_keyexpand;
    reg run;

    keyexpansion do_keyexpansion (
        .key(anahtar),
        .start(start_keyexpand),
        .rst(rst),
        .clk(clk),
        .out(key),
        .finish(end_keyexpand)
    );

    addroundkey do_addroundkey (
        .state(step),
        .key(key),
        .roundnumber(roundnumber),
        .out(sifre),
    );

    subbytes do_subbytes (
        .state(step),
        .out(sifre),
    );

    shiftrows do_shiftrows (
        .state(step),
        .out(sifre)
    );

    mixcolumns do_mixcolumns (
        .clk(clk),
        .state(step),
        .out(sifre)
    );

    initial begin
        run <= 1'b0;
        round <= 4'd0;
        ctr <= 2'd0;
        c_gecerli <= 1'b0;
        sifre <= 128'd0;
        step <= 128'd0;
        start_keyexpand <= 1'b0;
        end_keyexpand <= 1'b0;
    end

    always @ (posedge clk) begin
        if (rst) begin
           run <= 1'b0;
           round <= 4'd0;
           c_gecerli <= 1'b0;
           sifre <= 128'd0;
           hazir <= 1'b0;
        end else if (g_gecerli && ~run) begin
            run = ~run;
        end

        if (run) begin
            if (roundnumber == 4'd0) begin
                // Start keyexpansion.
                if (~start_keyexpand) begin
                    start_keyexpand = 1'b1;
                // Check if keyexpansion is over.
                end else if (end_keyexpand) begin
                    roundnumber = roundnumber + 4'd1;
                    start_keyexpand = 1'b0;
                end
            end else if (roundnumber < 4'd10) begin
                case (ctr)
                2'b00: #1;
                2'b01: #1;
                2'b10: #1;
                2'b11:
                    begin
                        roundnumber = roundnumber + 4'd1;
                    end
                endcase
            end
        end
    end

endmodule
