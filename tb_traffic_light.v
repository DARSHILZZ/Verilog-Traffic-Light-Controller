`timescale 1ns / 1ps

module tb_Traffic_Light_Time;

    // Testbench Variables (Inputs declared as reg, outputs as wire)
    reg clk;
    reg clr;
    wire [5:0] lights;

    // Instantiate Unit Under Test (UUT) 
    // Timings scaled down in parameters for readable waveform evaluation
    Traffic_Light_Time #(
        .SEC5(4'b0101), // Scaled down to 5 clock cycles for Green simulation
        .SEC1(4'b0010)  // Scaled down to 2 clock cycles for Yellow simulation
    ) uut (
        .clk(clk),
        .clr(clr),
        .lights(lights)
    );

    // Clock Generation Block (50MHz frequency -> 20ns period, toggles every 10ns)
    always begin
        #10 clk = ~clk;
    end

    // Stimulus Initialization Block
    initial begin
        // Initialize signals at Time = 0
        clk = 0;
        clr = 1; // Assert reset asynchronously
        #20;     // Hold reset state for 20ns
        
        clr = 0; // Release reset to kickstart FSM
        
        // Allow FSM to loop through multiple complete lighting sequences
        #800;
        
        // Terminate simulation gracefully
        $finish;
    end

    // Real-time Console Monitor for Text Verification
    initial begin
        $monitor("Time = %0dns | Reset = %b | State Register = %b | Output Lights [5:0] = %b", 
                 $time, clr, uut.state, lights);
    end

endmodule
