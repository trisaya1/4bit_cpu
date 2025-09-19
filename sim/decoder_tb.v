`timescale 1ns/1ps
module decoder_tb;

    reg [3:0] opcode;
    wire reg_write, reg_sel, mem_read, mem_write, pc_inc, halt;
    wire [2:0] alu_op;

    // Instantiate decoder
    decoder uut (
        .opcode(opcode),
        .reg_write(reg_write),
        .reg_sel(reg_sel),
        .alu_op(alu_op),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .pc_inc(pc_inc),
        .halt(halt)
    );

    initial begin
        $monitor("time=%0t | opcode=%b | reg_write=%b reg_sel=%b alu_op=%b mem_read=%b mem_write=%b pc_inc=%b halt=%b",
                  $time, opcode, reg_write, reg_sel, alu_op, mem_read, mem_write, pc_inc, halt);

        // Test NOP
        opcode = 4'b0000; #10;
        // Test LOAD R0
        opcode = 4'b0001; #10;
        // Test LOAD R1
        opcode = 4'b1001; #10;
        // Test STORE R0
        opcode = 4'b0010; #10;
        // Test ADD
        opcode = 4'b0011; #10;
        // Test SUB
        opcode = 4'b0100; #10;
        // Test HALT
        opcode = 4'b1111; #10;

        $finish;
    end

endmodule