// Simple testbench for the ALU
`timescale 1ns/1ps
module alu_tb;

    // Testbench drives regs; observes wires
    reg  [3:0] a, b;
    reg  [2:0] alu_sel;
    wire [3:0] result;
    wire carry, zero;

    // Instantiate the ALU (Unit Under Test = uut)
    alu uut (
        .a(a),
        .b(b),
        .alu_sel(alu_sel),
        .result(result),
        .carry(carry),
        .zero(zero)
    );

    initial begin
        // Print values each time any monitored signal changes
        $monitor("t=%0t a=%0d b=%0d sel=%b -> res=%0d carry=%b zero=%b",
                 $time, a, b, alu_sel, result, carry, zero);

        // Try each operation with simple numbers
        a=3; b=2; alu_sel=3'b000; #10; // ADD 3+2=5
        a=7; b=4; alu_sel=3'b001; #10; // SUB 7-4=3
        a=12; b=10; alu_sel=3'b010; #10; // AND
        a=12; b=10; alu_sel=3'b011; #10; // OR
        a=12; b=10; alu_sel=3'b100; #10; // XOR
        a=5; b=5; alu_sel=3'b001; #10; // SUB -> 0 (zero flag)
        a=15; b=1; alu_sel=3'b000; #10; // ADD with carry

        $finish; // end simulation
    end

endmodule