`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:33:27 05/02/2023 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU(
    input M, S1, S0,
    input Ai, Bi,
    output[5:0] Fi
    );
	 
	 wire[2:0] sel = {M, S1, S0};
	 reg[5:0] out;
	 assign Fi = out;
	 
	 always@(sel or Ai or Bi)
	 begin
		out = 6'b000000;
		case(sel)
		3'b000: out[0] = Ai; 
		3'b001: out[1] = ~Ai;
		3'b010: out[2] = Ai ^ Bi;
		3'b011: out[3] = ~(Ai ^ Bi);
		3'b100: out[0] = Ai;
		3'b101: out[1] = ~Ai;
		3'b110: out[4] = Ai | Bi;
		default: out[5] = ~Ai | Bi;
		endcase
	 end
	 

endmodule
