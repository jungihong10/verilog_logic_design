`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/26 20:15:28
// Design Name: 
// Module Name: Sim_Freq_divider
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


module Sim_Freq_divider(
    input clkin,
    output reg clkout = 0
    );
	
	reg [31:0] cnt = 32'd0;
	
	always @(posedge clkin) begin
	   if(cnt == 32'd25) begin // clk for testbench: x Hz / 50
			cnt <= 32'd0;
			clkout <= ~clkout;
		end else begin
			cnt <= cnt + 1;
		end
	end

endmodule
