`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2026 07:42:42
// Design Name: 
// Module Name: uart_top
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


module uart_top(
    input rst,input [7:0] data_in,input wr_en,clk,input rdy_clr,output rdy,busy,output [7:0] data_out
    );
    
    wire rx_clk_en; 
    wire tx_clk_en; 
    wire tx_temp; 
    
    baud_rate_generator bg(clk,rst,tx_clk_en,rx_clk_en);
    
    uart_transmitter us(clk,wr_en,tx_clk_en,rst,data_in,tx_temp,busy);
    
    uart_receiver ur(clk,rst,tx_temp,rdy_clr,rx_clk_en,rdy,data_out);
endmodule
