module counter_8bit_tb;

    reg clk;
    reg reset;
    wire [7:0] count;

    // Instantiate the Unit Under Test (UUT)
    counter8bit uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Clock generation: 10 ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Monitor output changes in the console
        $monitor("Time = %0t ns | reset = %b | count = %d (8'b%b)", $time, reset, count, count);

        // Initialize signals
        clk = 0;
        reset = 1;

        // Hold reset for 10 ns
        #10;
        reset = 0;

        // Run the simulation for 200 ns
        #200;

        // Optional: Apply reset again mid-run to test reset behavior
        reset = 1;
        #10;
        reset = 0;
        #50;

        // End simulation
        $display("Simulation finished successfully.");
        $finish;
    end

endmodule
