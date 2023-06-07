`timescale 1ns / 1ps

module Data_Unit(
	   input Reset,
	   input CLK,
	   input [7:0]Address,
	   output [7:0]ReadData,
	   input MemWrite,
	   input [7:0]WriteData
    );
    
    reg [7:0] memory[0:31];
	
	// READ
	assign ReadData = memory[Address];
	// WRITE
	always@(posedge CLK or posedge Reset) begin
        if (Reset) begin
            memory[0] = 8'b0;
            memory[1] = 8'b1;
            memory[2] = 8'b10;
            memory[3] = 8'b11;
            memory[4] = 8'b100;
            memory[5] = 8'b101;
            memory[6] = 8'b110;
            memory[7] = 8'b111;
            memory[8] = 8'b1000;
            memory[9] = 8'b1001;
            memory[10] = 8'b1010;
            memory[11] = 8'b1011;
            memory[12] = 8'b1100;
            memory[13] = 8'b1101;
            memory[14] = 8'b1110;
            memory[15] = 8'b1111;
            memory[16] = 8'b0;
            // 2's complement notation
            memory[17] = 8'b11111111;
            memory[18] = 8'b11111110;
            memory[19] = 8'b11111101;
            memory[20] = 8'b11111100;
            memory[21] = 8'b11111011;
            memory[22] = 8'b11111010;
            memory[23] = 8'b11111001;
            memory[24] = 8'b11111000;
            memory[25] = 8'b11110111;
            memory[26] = 8'b11110110;
            memory[27] = 8'b11110101;
            memory[28] = 8'b11110100;
            memory[29] = 8'b11110011;
            memory[30] = 8'b11110010;
            memory[31] = 8'b11110001;
        end
		  else if(MemWrite) begin
            memory[Address] = WriteData;
        end
        
	end

    initial begin
        memory[0] = 8'b0;
        memory[1] = 8'b1;
        memory[2] = 8'b10;
        memory[3] = 8'b11;
        memory[4] = 8'b100;
        memory[5] = 8'b101;
        memory[6] = 8'b110;
        memory[7] = 8'b111;
        memory[8] = 8'b1000;
        memory[9] = 8'b1001;
        memory[10] = 8'b1010;
        memory[11] = 8'b1011;
        memory[12] = 8'b1100;
        memory[13] = 8'b1101;
        memory[14] = 8'b1110;
        memory[15] = 8'b1111;
        memory[16] = 8'b0;
        // 2's complement notation
        memory[17] = 8'b11111111;
        memory[18] = 8'b11111110;
        memory[19] = 8'b11111101;
        memory[20] = 8'b11111100;
        memory[21] = 8'b11111011;
        memory[22] = 8'b11111010;
        memory[23] = 8'b11111001;
        memory[24] = 8'b11111000;
        memory[25] = 8'b11110111;
        memory[26] = 8'b11110110;
        memory[27] = 8'b11110101;
        memory[28] = 8'b11110100;
        memory[29] = 8'b11110011;
        memory[30] = 8'b11110010;
        memory[31] = 8'b11110001;
	end
endmodule
