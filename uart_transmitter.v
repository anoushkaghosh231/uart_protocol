`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2026 07:42:42
// Design Name: 
// Module Name: uart_transmitter
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


module uart_transmitter(
    input clk,wr_en,enb,rst,input [7:0] data_in, output reg tx, output busy
    );
  parameter idle_state=2'b00;
  parameter start_state=2'b01;
  parameter data_state=2'b10;
  parameter stop_state=2'b11;
  
  reg [7:0] data=8'h00;
  reg [1:0] state=idle_state;
  reg [2:0] index=3'h0;
  
  always@(posedge clk)
    begin
      if(rst)
        tx=1'b1;
        state<=idle_state;
        data<=8'h00;
        index<= 3'h0;
    end
  
  always@(posedge clk)
    begin
      case(state)
        idle_state:
          begin
            if(wr_en)
              begin
                state<=start_state;
                data<=data_in;
                index<=3'h0;
              end
            else
              state<=idle_state;
          end
        
        start_state:
          begin
            if(enb)
              begin
                tx<=1'b0;
                state<=data_state;
              end
            else
              state=start_state;
          end
        
        data_state:
          begin
            if(enb)
              begin
                if(index==3'h7)
                  state<=stop_state;
                else
                  index=index+ 3'h1;
                tx<=data[index];
              end
          end
        
        stop_state:
          begin
            if(enb)
              begin
                tx<=1'b1;
                state<= idle_state;
              end
          end
        
        default: 
          begin
            tx<=1'b1;
            state<=idle_state;
          end
      endcase
    end
  
  assign busy= (state!=idle_state);
endmodule
