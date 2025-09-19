// 2x4-bit Register File: holds R0 and R1
module register_file (
    input        clk,         // clock for synchronous writes
    input        reset,       // active-high reset clears registers
    input        we,          // write enable: 1=write selected register
    input        write_sel,   // 0=write R0, 1=write R1
    input        read_sel,    // 0=read R0, 1=read R1
    input  [3:0] write_data,  // data to write into selected register
    output [3:0] read_data,   // data read from selected register
    output [3:0] R0,          // expose R0 for debug/waveforms
    output [3:0] R1           // expose R1 for debug/waveforms
);

    // Actual storage for the two registers
    reg [3:0] reg0;
    reg [3:0] reg1;

    // Synchronous write + synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg0 <= 4'b0000;   // clear both registers on reset
            reg1 <= 4'b0000;
        end else if (we) begin
            // Write selected register with write_data
            if (write_sel == 1'b0)
                reg0 <= write_data;
            else
                reg1 <= write_data;
        end
    end

    // Combinational read: output updates immediately with read_sel
    assign read_data = (read_sel == 1'b0) ? reg0 : reg1;

    // Connect internal regs to debug outputs
    assign R0 = reg0;
    assign R1 = reg1;

endmodule