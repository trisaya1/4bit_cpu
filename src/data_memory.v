// 16x4 Data RAM: used by LOAD/STORE
module data_memory (
    input        clk,         // Clock
    input        we,          // Write enable (1=write, 0=read)
    input  [3:0] addr,        // 4-bit address
    input  [3:0] data_in,     // Data to write
    output [3:0] data_out     // Data read
);

    // 16 locations, each 4 bits wide
    reg [3:0] ram [0:15];

    // Initialize with some test values
    initial begin
        ram[0] = 4'd0;
        ram[1] = 4'd3;   // test value for program
        ram[2] = 4'd2;   // test value for program
        ram[3] = 4'd0;
        ram[4] = 4'd0;
        ram[5] = 4'd0;
        ram[6] = 4'd0;
        ram[7] = 4'd0;
        ram[8] = 4'd0;
        ram[9] = 4'd0;
        ram[10] = 4'd0;
        ram[11] = 4'd0;
        ram[12] = 4'd0;
        ram[13] = 4'd0;
        ram[14] = 4'd0;
        ram[15] = 4'd0;
    end

    // Write logic (synchronous) - updates selected location on clock edge
    always @(posedge clk) begin
        if (we) begin
            ram[addr] <= data_in;
        end
    end

    // Read logic (combinational) - output shows current address contents
    assign data_out = ram[addr];

endmodule