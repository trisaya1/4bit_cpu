// 16x8 Instruction ROM: holds program code
module instruction_memory (
    input  [3:0] addr,     // Address from Program Counter
    output [7:0] instr     // Fetched instruction at that address
);

    // 16 locations, each 8 bits wide
    reg [7:0] rom [0:15];

    // Initialize program (fixed: LOAD R1 uses opcode 1001)
    initial begin
        // Program:
        // 0: LOAD R0, [1]
        // 1: LOAD R1, [2]   <-- FIXED to use 1001
        // 2: ADD R0, R1
        // 3: STORE R0, [3]
        // 4: HALT
        rom[0] = 8'b0001_0001; // 0x11 : LOAD R0, [1]
        rom[1] = 8'b1001_0010; // 0x92 : LOAD R1, [2]  <-- FIXED
        rom[2] = 8'b0011_0000; // 0x30 : ADD R0, R1
        rom[3] = 8'b0010_0011; // 0x23 : STORE R0, [3]
        rom[4] = 8'b1111_0000; // 0xF0 : HALT

        // Fill unused locations with NOP
        rom[5]  = 8'b0000_0000;
        rom[6]  = 8'b0000_0000;
        rom[7]  = 8'b0000_0000;
        rom[8]  = 8'b0000_0000;
        rom[9]  = 8'b0000_0000;
        rom[10] = 8'b0000_0000;
        rom[11] = 8'b0000_0000;
        rom[12] = 8'b0000_0000;
        rom[13] = 8'b0000_0000;
        rom[14] = 8'b0000_0000;
        rom[15] = 8'b0000_0000;
    end

    // Combinational read (no clock): output follows address
    assign instr = rom[addr];

endmodule