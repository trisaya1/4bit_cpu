// 4-bit ALU for the Mini CPU
module alu (
    input  [3:0] a,        // first operand (usually R0)
    input  [3:0] b,        // second operand (usually R1)
    input  [2:0] alu_sel,  // selects which ALU operation to perform
    output reg [3:0] result, // 4-bit result of the operation
    output reg carry,        // carry-out for ADD (useful flag to showcase)
    output reg zero          // 1 when result == 0
);

    // Combinational ALU: output changes immediately with inputs
    always @(*) begin
        // Default outputs so we don't infer latches
        result = 4'b0000;
        carry  = 1'b0;
        zero   = 1'b0;

        // Choose operation based on alu_sel
        case (alu_sel)
            3'b000: begin // ADD
                {carry, result} = a + b; // 5-bit addition; top bit is carry
            end
            3'b001: begin // SUB
                result = a - b;         // wraps naturally in 4 bits
            end
            3'b010: begin // AND
                result = a & b;
            end
            3'b011: begin // OR
                result = a | b;
            end
            3'b100: begin // XOR
                result = a ^ b;
            end
            default: begin // NOP / unknown
                result = 4'b0000;
            end
        endcase

        // Set zero flag if result is 0
        if (result == 4'b0000)
            zero = 1'b1;
    end

endmodule