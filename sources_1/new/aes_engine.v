`timescale 1ns / 1ps

module aes_engine (
    input          clk,
    input          rst,
    input [127:0]  anahtar,
    input [127:0]  blok,
    input          g_gecerli,
    output         hazir,
    output [127:0] sifre,
    output         c_gecerli
);

    wire [1407:0] expanded;
    wire [127:0] states [10:0];
    wire key_expanded;
    reg [127:0] first;
    /* 11 counters to check which rounds have valid input */
    reg [3:0] ctr [10:0];
    reg run, valid;

    /* The first state is the first reg which has the first round of keys applied. */
    assign states[0] = first;
    /* The module is ready for input if the key is expanded and any of the counters are available. */
    assign hazir = key_expanded && ((ctr[0] == 4'd0) || (ctr[1] == 4'd0) || (ctr[2] == 4'd0) || (ctr[3] == 4'd0) || (ctr[4] == 4'd0) ||
                                    (ctr[5] == 4'd0) || (ctr[6] == 4'd0) || (ctr[7] == 4'd0) || (ctr[8] == 4'd0) || (ctr[9] == 4'd0) ||
                                    (ctr[10] == 4'd0));
    /* The ciphertext is the last state */
    assign sifre = states[10];
    assign c_gecerli = valid;

    genvar i;

    keyexpansion do_keyexpansion(.key(anahtar), .start(~run), .clk(clk), .rst(rst), .out(expanded), .finish(key_expanded));
    /*
     * Generate each round seperately for pipelining. The clock stops if it is not ready yet.
     * The rounds always run when their clock is ticking however the counters
     * track which rounds have a block that is wanted as an output.
     */
    generate
        for (i = 1; i < 10; i = i + 1) begin
            round do_round(.clk(clk & run), .rst(rst), .key(expanded[(1407-128*i)-:128]), .state(states[i-1]), .out(states[i]));
        end
    endgenerate

    /* The last round requires a special module. */
    lastround do_lastround(.clk(clk & run), .rst(rst), .key(expanded[127:0]), .state(states[9]), .out(states[10]));

    /* Increment if the function is running. */
    function [3:0] increment_ctr (input [3:0] counter);
        if (counter == 4'd0) begin
            increment_ctr = counter;
        end else begin
            increment_ctr = counter + 4'd1;
        end
    endfunction

    initial begin
        run     <= 1'b0;
        valid   <= 1'b0;
        ctr[ 0] <= 4'd0;
        ctr[ 1] <= 4'd0;
        ctr[ 2] <= 4'd0;
        ctr[ 3] <= 4'd0;
        ctr[ 4] <= 4'd0;
        ctr[ 5] <= 4'd0;
        ctr[ 6] <= 4'd0;
        ctr[ 7] <= 4'd0;
        ctr[ 8] <= 4'd0;
        ctr[ 9] <= 4'd0;
        ctr[10] <= 4'd0;
    end

    always @ (posedge clk) begin
        if (rst) begin
            first   <= 128'd0;
            run     <= 1'b0;
            ctr[ 0] <= 4'd0;
            ctr[ 1] <= 4'd0;
            ctr[ 2] <= 4'd0;
            ctr[ 3] <= 4'd0;
            ctr[ 4] <= 4'd0;
            ctr[ 5] <= 4'd0;
            ctr[ 6] <= 4'd0;
            ctr[ 7] <= 4'd0;
            ctr[ 8] <= 4'd0;
            ctr[ 9] <= 4'd0;
            ctr[10] <= 4'd0;

        /* Start the modules if the key is expanded and the first input is given. */
        end else if (key_expanded && g_gecerli) begin
            run <= 1'b1;
        end

        if (valid) begin
            /* Turn off valid cipher signal if there are none left. */
            if (~(ctr[0] == 4'd10 || ctr[1] == 4'd10 || ctr[2] == 4'd10 || ctr[3] == 4'd10 || ctr[4] == 4'd10 ||
                  ctr[5] == 4'd10 || ctr[6] == 4'd10 || ctr[7] == 4'd10 || ctr[8] == 4'd10 || ctr[9] == 4'd10 ||
                  ctr[10] == 4'd10)) begin
                valid = ~valid;
            end
        end

        /* If the module is ready and there is valid input, start the smallest available counter. */
        if (g_gecerli && hazir) begin
            if (ctr[0] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[0] <= 4'd1;
            end else if (ctr[1] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[1] <= 4'd1;
            end else if (ctr[2] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[2] <= 4'd1;
            end else if (ctr[3] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[3] <= 4'd1;
            end else if (ctr[3] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[3] <= 4'd1;
            end else if (ctr[4] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[4] <= 4'd1;
            end else if (ctr[5] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[5] <= 4'd1;
            end else if (ctr[6] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[6] <= 4'd1;
            end else if (ctr[7] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[7] <= 4'd1;
            end else if (ctr[8] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[8] <= 4'd1;
            end else if (ctr[9] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[9] <= 4'd1;
            end else if (ctr[10] == 4'd0) begin
                first <= blok ^ expanded[1407-:128];
                ctr[10] <= 4'd1;
            end
        end

        if (run) begin
            /* Check if any of the counters have finished. */
            if (ctr[0] == 4'd10) begin
                valid <= 1'b1;
                ctr[0] <= 1'b0;
            end else if (ctr[1] == 4'd10) begin
                valid <= 1'b1;
                ctr[1] <= 4'd0;
            end else if (ctr[2] == 4'd10) begin
                valid <= 1'b1;
                ctr[2] <= 4'd0;
            end else if (ctr[3] == 4'd10) begin
                valid <= 1'b1;
                ctr[3] <= 4'd0;
            end else if (ctr[4] == 4'd10) begin
                valid <= 1'b1;
                ctr[4] <= 4'd0;
            end else if (ctr[5] == 4'd10) begin
                valid <= 1'b1;
                ctr[5] <= 4'd0;
            end else if (ctr[6] == 4'd10) begin
                valid <= 1'b1;
                ctr[6] <= 4'd0;
            end else if (ctr[7] == 4'd10) begin
                valid <= 1'b1;
                ctr[7] <= 4'd0;
            end else if (ctr[8] == 4'd10) begin
                valid <= 1'b1;
                ctr[8] <= 4'd0;
            end else if (ctr[9] == 4'd10) begin
                valid <= 1'b1;
                ctr[9] <= 4'd0;
            end else if (ctr[10] == 4'd10) begin
                valid <= 1'b1;
                ctr[10] <= 4'd0;
            end

            /* Increment counters that are running. */
            ctr[ 0] = increment_ctr(ctr[ 0]);
            ctr[ 1] = increment_ctr(ctr[ 1]);
            ctr[ 2] = increment_ctr(ctr[ 2]);
            ctr[ 3] = increment_ctr(ctr[ 3]);
            ctr[ 4] = increment_ctr(ctr[ 4]);
            ctr[ 5] = increment_ctr(ctr[ 5]);
            ctr[ 6] = increment_ctr(ctr[ 6]);
            ctr[ 7] = increment_ctr(ctr[ 7]);
            ctr[ 8] = increment_ctr(ctr[ 8]);
            ctr[ 9] = increment_ctr(ctr[ 9]);
            ctr[10] = increment_ctr(ctr[10]);
        end
    end
endmodule
