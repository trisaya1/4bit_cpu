`timescale 1ns/1ps
module register_file_tb;

    reg clk, reset, we;
    reg write_sel, read_sel;
    reg [3:0] write_data;
    wire [3:0] read_data, R0, R1;

    // Instantiate Register File
    register_file uut (
        .clk(clk),
        .reset(reset),
        .we(we),
        .write_sel(write_sel),
        .read_sel(read_sel),
        .write_data(write_data),
        .read_data(read_data),
        .R0(R0),
        .R1(R1)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0; reset = 1; we = 0; write_sel = 0; read_sel = 0; write_data = 4'b0000;
        #10;
        reset = 0;

        // Write 5 into R0
        we = 1; write_sel = 0; write_data = 4'd5; #10;
        we = 0;

        // Write 9 into R1
        we = 1; write_sel = 1; write_data = 4'd9; #10;
        we = 0;

        // Read R0
        read_sel = 0; #10;

        // Read R1
        read_sel = 1; #10;

        // Overwrite R0 with 12
        we = 1; write_sel = 0; write_data = 4'd12; #10;
        we = 0;

        // Read R0 again
        read_sel = 0; #10;

        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("time=%0t | we=%b write_sel=%b write_data=%d | read_sel=%b read_data=%d | R0=%d | R1=%d",
                  $time, we, write_sel, write_data, read_sel, read_data, R0, R1);
    end

endmodule