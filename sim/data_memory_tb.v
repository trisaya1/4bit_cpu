`timescale 1ns/1ps
module data_memory_tb;

    reg clk, we;
    reg [3:0] addr;
    reg [3:0] data_in;
    wire [3:0] data_out;

    // Instantiate RAM
    data_memory uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0; we = 0; addr = 0; data_in = 0;

        // Read initial value at addr=1
        addr = 4'd1; #10;

        // Write 7 into addr=5
        we = 1; addr = 4'd5; data_in = 4'd7; #10;
        we = 0;

        // Read back from addr=5
        addr = 4'd5; #10;

        // Overwrite addr=5 with 12
        we = 1; addr = 4'd5; data_in = 4'd12; #10;
        we = 0;

        // Read again from addr=5
        addr = 4'd5; #10;

        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("time=%0t | we=%b addr=%d data_in=%d | data_out=%d",
                  $time, we, addr, data_in, data_out);
    end

endmodule