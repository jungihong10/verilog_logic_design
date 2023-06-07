`timescale 1ns / 1ps

module Freq_divider(
    input clkin,
    output reg clkout = 0
    );
	
	reg [31:0] cnt = 32'd0;
	
	always @(posedge clkin) begin
	   if(cnt == 32'd25000000) begin // x Hz / 50M
			cnt <= 32'd0;
			clkout <= ~clkout;
		end else begin
			cnt <= cnt + 1;
		end
	end

endmodule