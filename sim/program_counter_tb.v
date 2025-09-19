`timescale 1ns/1ps
module program_counter_tb;

    reg clk, reset, pc_inc, pc_load;
    reg [3:0] pc_in;
    wire [3:0] pc_out;

    // Instantiate Program Counter
    program_counter uut (
        .clk(clk),
        .reset(reset),
        .pc_inc(pc_inc),
        .pc_load(pc_load),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0; reset = 1; pc_inc = 0; pc_load = 0; pc_in = 4'b0000;
        #10;
        reset = 0;

        // Increment PC for 5 cycles
        pc_inc = 1;
        repeat(5) #10;
        pc_inc = 0;

        // Load new value (e.g., 9)
        pc_load = 1; pc_in = 4'd9; #10;
        pc_load = 0;

        // Increment a few more times
        pc_inc = 1;
        repeat(3) #10;
        pc_inc = 0;

        // Halt (no inc/load)
        #20;

        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("time=%0t | reset=%b pc_inc=%b pc_load=%b pc_in=%d | pc_out=%d",
                  $time, reset, pc_inc, pc_load, pc_in, pc_out);
    end

endmodule