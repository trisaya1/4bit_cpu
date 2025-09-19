`timescale 1ns/1ps
module cpu_tb;

    reg clk, reset;
    wire [3:0] pc_debug, R0_debug, R1_debug, ram3_debug;
    wire [7:0] instr_debug;

    // Instantiate CPU
    cpu uut (
        .clk(clk),
        .reset(reset),
        .pc_debug(pc_debug),
        .instr_debug(instr_debug),
        .R0_debug(R0_debug),
        .R1_debug(R1_debug),
        .ram3_debug(ram3_debug)
    );

    // Clock (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Init
        clk = 0;
        reset = 1; #10;
        reset = 0;

        // Run simulation for a while
        #200;

        $finish;
    end

    // Monitor debug signals
    initial begin
        $monitor("time=%0t | PC=%d | Instr=%b | R0=%d | R1=%d | RAM[3]=%d",
                  $time, pc_debug, instr_debug, R0_debug, R1_debug, ram3_debug);
    end

endmodule