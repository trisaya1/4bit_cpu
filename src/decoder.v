// Instruction Decoder for Mini CPU
module decoder (
    input  [3:0] opcode,     // From instr[7:4]
    output reg   reg_write,  // Enable register write
    output reg   reg_sel,    // Which register (0=R0, 1=R1)
    output reg [2:0] alu_op, // ALU operation select
    output reg   mem_read,   // Enable data memory read
    output reg   mem_write,  // Enable data memory write
    output reg   pc_inc,     // Increment PC
    output reg   halt        // Halt execution
);

    always @(*) begin
        // Default values (NOP)
        reg_write = 0;
        reg_sel   = 0;
        alu_op    = 3'b000;
        mem_read  = 0;
        mem_write = 0;
        pc_inc    = 1;   // PC normally increments
        halt      = 0;

        case (opcode)
            4'b0000: begin // NOP
                // Do nothing
            end
            4'b0001: begin // LOAD R0, [addr]
                reg_write = 1;
                reg_sel   = 0;
                mem_read  = 1;
            end
            4'b1001: begin // LOAD R1, [addr]
                reg_write = 1;
                reg_sel   = 1;
                mem_read  = 1;
            end
            4'b0010: begin // STORE R0, [addr]
                mem_write = 1;
                reg_sel   = 0;
            end
            4'b1010: begin // STORE R1, [addr]
                mem_write = 1;
                reg_sel   = 1;
            end
            4'b0011: begin // ADD R0, R1
                alu_op    = 3'b000; // ADD
                reg_write = 1;
                reg_sel   = 0;     // R0 is destination
            end
            4'b0100: begin // SUB R0, R1
                alu_op    = 3'b001; // SUB
                reg_write = 1;
                reg_sel   = 0;
            end
            4'b0101: begin // AND R0, R1
                alu_op    = 3'b010; // AND
                reg_write = 1;
                reg_sel   = 0;
            end
            4'b0110: begin // OR R0, R1
                alu_op    = 3'b011; // OR
                reg_write = 1;
                reg_sel   = 0;
            end
            4'b0111: begin // XOR R0, R1
                alu_op    = 3'b100; // XOR
                reg_write = 1;
                reg_sel   = 0;
            end
            4'b1111: begin // HALT
                pc_inc = 0;
                halt   = 1;
            end
            default: begin
                // Unknown opcode = treat as NOP
            end
        endcase
    end

endmodule