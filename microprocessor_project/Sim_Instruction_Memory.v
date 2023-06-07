`timescale 1ns / 1ps

module Sim_Instruction_Memory(input [7:0] Read_Address, output [7:0] instruction);

	wire [7:0] MemByte[31:0]; // Memory Dimension: Memory[32] = 8'b;
	// Read_Address ִ instruction ȯ
	assign instruction = MemByte[Read_Address];
	
	// Basic Operation Test Set //
	// lw $s2, 1($s0)
	assign MemByte[0] = {2'b01, 2'b00, 2'b10, 2'b01};	
	// j + 1
	assign MemByte[1] = {2'b11, 2'b00, 2'b00, 2'b01};
	// add $s0, $s1, $s2
	assign MemByte[2] = {2'b00, 2'b01, 2'b10, 2'b00};	
	// sw $s2, 1($s2)
	assign MemByte[3] = {2'b10, 2'b10, 2'b10, 2'b01};	
	// lw $s3, 1($s0) r[3] = mem[r[0] + 1]
	assign MemByte[4] = {2'b01, 2'b00, 2'b11, 2'b01};
	
	// TEST - j + 0
	assign MemByte[5] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[6] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[7] = {2'b11, 2'b00, 2'b00, 2'b00};
	// r[3] = mem[r[2] + 1]
	assign MemByte[8] = {2'b01, 2'b10, 2'b11, 2'b01};
	assign MemByte[9] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[10] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[11] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[12] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[13] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[14] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[15] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[16] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[17] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[18] = {2'b11, 2'b00, 2'b00, 2'b00};
	assign MemByte[19] = {2'b11, 2'b00, 2'b00, 2'b00};
	
endmodule
