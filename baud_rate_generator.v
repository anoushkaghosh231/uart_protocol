`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2026 07:42:42
// Design Name: 
// Module Name: baud_rate_generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module baud_rate_generator(
    input  clock,
    input  reset,
    output reg enb_tx,
    output reg enb_rx
);

    parameter clk_freq  = 500000000; // 100 MHz
    parameter baud_rate = 9600;

    reg [13:0] counter_tx; 
    reg [9:0]  counter_rx;

    parameter divisor_tx = clk_freq / baud_rate;       // ~10417
    parameter divisor_rx = clk_freq / (16 * baud_rate); // ~651

    // TX clock enable
    always @(posedge clock) begin
        if (reset) begin
            counter_tx <= 0;
            enb_tx     <= 0;
        end else if (counter_tx == divisor_tx - 1) begin
            enb_tx     <= 1;
            counter_tx <= 0;
        end else begin
            counter_tx <= counter_tx + 1'b1;
            enb_tx     <= 0;
        end
    end

    // RX clock enable
    always @(posedge clock) begin
        if (reset) begin
            counter_rx <= 0;
            enb_rx     <= 0;
        end else if (counter_rx == divisor_rx - 1) begin
            counter_rx <= 0;
            enb_rx     <= 1;
        end else begin
            counter_rx <= counter_rx + 1'b1;
            enb_rx     <= 0;
        end
    end

endmodule
