`timescale 1ns / 1ps

module Traffic_Light_Time #(
    // Parameterized delays for simulation scaling
    parameter SEC5 = 4'b1111,  // 15 clock cycles for Green
    parameter SEC1 = 4'b0011   // 3 clock cycles for Yellow
)(
    input wire clk,
    input wire clr,
    output reg [5:0] lights
);

    // Internal Registers for FSM State and Timer Counter
    reg [2:0] state;
    reg [3:0] count;

    // FSM State Encoding parameters using standard single-tick notation
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010,
              S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;

    // Sequential Logic: State Transitions and Timer Control
    always @(posedge clk or posedge clr) begin
        if (clr == 1'b1) begin
            state <= S0;
            count <= 4'b0000;
        end else begin
            case (state)
                S0: begin 
                    if (count < SEC5) begin
                        state <= S0;
                        count <= count + 1'b1;
                    end else begin
                        state <= S1;
                        count <= 4'b0000;
                    end
                end
                S1: begin 
                    if (count < SEC1) begin
                        state <= S1;
                        count <= count + 1'b1;
                    end else begin
                        state <= S2;
                        count <= 4'b0000;
                    end
                end
                S2: begin 
                    if (count < SEC1) begin
                        state <= S2;
                        count <= count + 1'b1;
                    end else begin
                        state <= S3;
                        count <= 4'b0000;
                    end
                end
                S3: begin 
                    if (count < SEC5) begin
                        state <= S3;
                        count <= count + 1'b1;
                    end else begin
                        state <= S4;
                        count <= 4'b0000;
                    end
                end
                S4: begin 
                    if (count < SEC1) begin
                        state <= S4;
                        count <= count + 1'b1;
                    end else begin
                        state <= S5;
                        count <= 4'b0000;
                    end
                end
                S5: begin 
                    if (count < SEC1) begin
                        state <= S5;
                        count <= count + 1'b1;
                    end else begin
                        state <= S0;
                        count <= 4'b0000;
                    end
                end
                default: begin
                    state <= S0;
                    count <= 4'b0000;
                end
            endcase
        end
    end

    // Combinational Logic: Output Signal Generation
    always @(*) begin
        case (state)
            S0:      lights = 6'b100001; 
            S1:      lights = 6'b100010; 
            S2:      lights = 6'b100100; 
            S3:      lights = 6'b001100; 
            S4:      lights = 6'b010100; 
            S5:      lights = 6'b100100; 
            default: lights = 6'b100001;
        endcase
    end

endmodule
