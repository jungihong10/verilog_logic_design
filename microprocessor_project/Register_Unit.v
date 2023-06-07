`timescale 1ns / 1ps

module Register_Unit(
	input CLK,
	input [1:0] ReadAddress1,
	output [7:0] ReadValue1,
	input [1:0] ReadAddress2,
	output [7:0] ReadValue2,
	input WriteControl,
	input [1:0] WriteAddress,
	input [7:0] WriteValue
    );
	
	reg [7:0] Register[0:3]; // Register¿« Dimension: Register[4] = 8'b;
	
	initial begin
		Register[0] <= 8'b0;
		Register[1] <= 8'b0;
		Register[2] <= 8'b0;
		Register[3] <= 8'b0;
	end
	
	// Read
	assign ReadValue1 = Register[ReadAddress1];	
	assign ReadValue2 = Register[ReadAddress2];
	// Write
	always@(posedge CLK) begin
		begin 
			if(WriteControl) begin
				Register[WriteAddress] <= WriteValue;
			end
		end
	end
	
	
endmodule
