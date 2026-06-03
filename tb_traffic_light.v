`timescale 1ns / 1ps

module tb_Traffic_Light_Time;

    // Testbench Variables
    reg clk;
    reg clr;
    wire [5:0] lights;

    // Instantiate Unit Under Test (UUT) 
    Traffic_Light_Time #(
        .SEC5(4'b0101), // Scaled down to 5 clock cycles for simulation
        .SEC1(4'b0010)  // Scaled down to 2 clock cycles for simulation
    ) uut (
        .clk(clk),
        .clr(clr),
        .lights(lights)
    );

    // Clock Generation Block (Toggles every 10ns)
    always begin
        #10 clk = ~clk;
    end

    // Stimulus Initialization Block
    initial begin
        // VCD Dump commands for Google Colab/Icarus Verilog simulation
        $dumpfile("simulation_dump.vcd"); 
        $dumpvars(0, tb_Traffic_Light_Time);

        // Initialize signals
        clk = 0;
        clr = 1; // Assert reset
        #20;     // Hold reset for 20ns
        
        clr = 0; // Release reset to start FSM
        
        #800;    // Run simulation for 800ns
        $finish; // End simulation
    end

    // Console Monitor
    initial begin
        $monitor("Time = %0dns | Reset = %b | State = %b | Lights [5:0] = %b", 
                 $time, clr, uut.state, lights);
    end

endmodule
