// Top-level CPU testbench: runs the whole mini program
`timescale 1ns/1ps
module cpu_tb;

    reg clk, reset;                   // drive clock/reset
    wire [3:0] pc_debug, R0_debug, R1_debug, ram3_debug; // observe internals
    wire [7:0] instr_debug;

    // Instantiate CPU
    cpu uut (
        .clk(clk), .reset(reset),
        .pc_debug(pc_debug),
        .instr_debug(instr_debug),
        .R0_debug(R0_debug),
        .R1_debug(R1_debug),
        .ram3_debug(ram3_debug)
    );

    // 10 ns clock
    always #5 clk = ~clk;

    initial begin
        // Reset for one cycle
        clk=0; reset=1; #10; reset=0;

        // Let program run
        #200;

        $finish;
    end

    // Live log of key state each time something changes
    initial begin
        $monitor("t=%0t PC=%0d INSTR=0x%02h | R0=%0d R1=%0d | RAM[3]=%0d",
                 $time, pc_debug, instr_debug, R0_debug, R1_debug, ram3_debug);
    end

    // Simple self-check so CI/graders can see PASS/FAIL
    initial begin
        #120; // enough time to reach HALT in this program
        if (ram3_debug !== 4'd5) begin
            $display("ERROR: Expected RAM[3]=5, got %0d", ram3_debug);
            $fatal;
        end else begin
            $display("PASS: Program result OK (RAM[3]=5).");
        end
    end

endmodule