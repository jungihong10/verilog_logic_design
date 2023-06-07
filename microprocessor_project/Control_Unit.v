`timescale 1ns / 1ps

module Control_Unit(
	input [1:0]ins, // instruction[7:6]
	output [7:0]out // control signal
    );
	
	// Slide 8. RegDst ~ ALUOP
	assign out = (ins == 2'b00) ? 8'b11000001:
                 (ins == 2'b01) ? 8'b01101010:
                 (ins == 2'b10) ? 8'b00100100:
                 (ins == 2'b11) ? 8'b00010000:
                 8'b00000000;

endmodule
