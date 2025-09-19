// 4-bit Program Counter: points to next instruction in ROM
module program_counter (
    input        clk,       // clock
    input        reset,     // active-high reset -> PC=0
    input        pc_inc,    // when 1, increment PC by 1 on this clock
    input        pc_load,   // when 1, load pc_in on this clock
    input  [3:0] pc_in,     // value to load (for jumps in the future)
    output reg [3:0] pc_out // current PC value
);

    // Synchronous logic for PC
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 4'b0000;         // start at 0 after reset
        end else if (pc_load) begin
            pc_out <= pc_in;           // jump/branch (not used yet)
        end else if (pc_inc) begin
            pc_out <= pc_out + 1'b1;   // normal execution
        end
        // otherwise hold value (used for HALT)
    end

endmodule