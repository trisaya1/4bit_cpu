`timescale 1ns/1ps
module instruction_memory_tb;

    reg  [3:0] addr;
    wire [7:0] instr;

    // Instantiate ROM
    instruction_memory uut (
        .addr(addr),
        .instr(instr)
    );

    initial begin
        // Monitor signals
        $monitor("time=%0t | addr=%d | instr=%b", $time, addr, instr);

        // Step through addresses
        addr = 4'd0; #10;
        addr = 4'd1; #10;
        addr = 4'd2; #10;
        addr = 4'd3; #10;
        addr = 4'd4; #10;
        addr = 4'd5; #10;

        $finish;
    end

endmodule