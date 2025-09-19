// Top-level Mini 4-bit CPU with debug outputs
module cpu (
    input  clk,
    input  reset,
    output [3:0] pc_debug,     // Program counter value
    output [7:0] instr_debug,  // Current instruction word
    output [3:0] R0_debug,     // Register R0
    output [3:0] R1_debug,     // Register R1
    output [3:0] ram3_debug    // Data memory location 3 (for demo)
);

    // === Instruction fields ===
    wire [3:0] pc_out;
    wire [7:0] instr;
    wire [3:0] opcode  = instr[7:4];
    wire [3:0] operand = instr[3:0];

    // === Control signals from decoder ===
    wire       reg_write;
    wire       reg_sel;        // 0=R0, 1=R1 (used by LOAD/STORE)
    wire [2:0] alu_op;
    wire       mem_read;
    wire       mem_write;
    wire       pc_inc;
    wire       halt;           // (not used further yet, but exposed)

    // === Register file signals ===
    wire [3:0] reg_write_data;
    wire [3:0] reg_read_data;  // (not strictly used in this minimal core)
    wire [3:0] R0, R1;

    // === ALU signals ===
    wire [3:0] alu_result;
    wire       alu_carry, alu_zero;

    // === Data memory ===
    wire [3:0] ram_out;

    // === Program Counter ===
    program_counter pc (
        .clk(clk),
        .reset(reset),
        .pc_inc(pc_inc),
        .pc_load(1'b0),   // No jumps in this minimal version
        .pc_in(4'b0000),
        .pc_out(pc_out)
    );

    // === Instruction Memory (ROM) ===
    instruction_memory rom (
        .addr(pc_out),
        .instr(instr)
    );

    // === Decoder ===
    decoder dec (
        .opcode(opcode),
        .reg_write(reg_write),
        .reg_sel(reg_sel),
        .alu_op(alu_op),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .pc_inc(pc_inc),
        .halt(halt)
    );

    // === Register File ===
    register_file rf (
        .clk(clk),
        .reset(reset),
        .we(reg_write),
        .write_sel(reg_sel),       // selects R0 or R1 as destination for LOAD/ALU
        .read_sel(reg_sel),        // simple design: read same reg we target
        .write_data(reg_write_data),
        .read_data(reg_read_data),
        .R0(R0),
        .R1(R1)
    );

    // === ALU ===
    alu myalu (
        .a(R0),                    // ALU ops use R0 (dest) and R1 (src)
        .b(R1),
        .alu_sel(alu_op),
        .result(alu_result),
        .carry(alu_carry),
        .zero(alu_zero)
    );

    // === STORE data source selection ===
    // For STORE R0, write R0; for STORE R1, write R1 (future-proof).
    wire [3:0] store_data = (reg_sel == 1'b0) ? R0 : R1;

    // === Data Memory (RAM) ===
    data_memory ram (
        .clk(clk),
        .we(mem_write),
        .addr(operand),
        .data_in(store_data),      // <-- FIXED: was R0; now selected by reg_sel
        .data_out(ram_out)
    );

    // === Register writeback MUX ===
    // If instruction is a LOAD, write RAM data to selected reg.
    // Otherwise (ALU ops), write ALU result (to R0 per decoder).
    assign reg_write_data = (mem_read) ? ram_out : alu_result;

    // === Debug outputs ===
    assign pc_debug     = pc_out;
    assign instr_debug  = instr;
    assign R0_debug     = R0;
    assign R1_debug     = R1;
    assign ram3_debug   = ram.ram[3];   // peek RAM[3] for the demo

endmodule