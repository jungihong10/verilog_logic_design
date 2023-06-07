`timescale 1ns / 1ps

// signed 2-bit -> signed 8-bit
module Extender(
	input [1:0]bit_2,
	output [7:0]bit_8
    );

	assign bit_8[1:0] = bit_2;
	assign bit_8[7:2] = (bit_2[1] == 1'b1) ? 6'b111111 : 6'b000000;

endmodule
