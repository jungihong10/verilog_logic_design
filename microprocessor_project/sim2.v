`timescale 1ns / 1ps

module sim2(
        input Reset,
        input oscillator,
        // output reg [7:0] pc_sampled, // REAL_FINAL
        // input [7:0] instruction, // REAL_FINAL
        output [6:0] LED1,
        output [6:0] LED2,
        output [6:0] LED3,
        output [6:0] LED4,
        output [6:0] LED5,
        output [6:0] LED6
    );
    // Make Clock
    wire CLK;
    // Freq_divider f1(oscillator, CLK); // REAL_ISE // CLK = x Hz / 50M
    Sim_Freq_divider f1(oscillator, CLK); // SIM_ISE // CLK = x Hz / 50
    
    reg [7:0] pc_sampled; // SIM_FINAL
    wire [7:0] instruction; // SIM_FINAL
    Sim_Instruction_Memory Instruction_Memory(pc_sampled, instruction); // SIM_FINAL
	
	// Control Unit
	wire [7:0]Control;
	// 2-bit Instruction -> 8-bit Control. Slide 8
	Control_Unit Control_(instruction[7:6], Control);
	assign RegDst = Control[7];
	assign RegWrite = Control[6];
	assign ALUSrc = Control[5];
	assign Branch = Control[4];
	assign MemRead = Control[3];
	assign MemWrite = Control[2];
	assign MemtoReg = Control[1];
	assign ALUOp = Control[0];
	
	// MUX LEFT
	wire [1:0] WriteRegister;
	assign WriteRegister = RegDst ? instruction[1:0] : instruction[3:2];	
	
	wire [7:0]ReadRegisterResult1;
	wire [7:0]ReadRegisterResult2;
	wire [7:0]RegWriteData;
	Register_Unit Registers(
	   .CLK(CLK),
	   .ReadAddress1(instruction[5:4]),
	   .ReadValue1(ReadRegisterResult1),
	   .ReadAddress2(instruction[3:2]),
	   .ReadValue2(ReadRegisterResult2),
	   .WriteControl(RegWrite),
	   .WriteAddress(WriteRegister),
	   .WriteValue(RegWriteData)
   );
   
    // Sign Extend
    wire [7:0]ExtendedValue;
    Extender Sign_Extend(.bit_2(instruction[1:0]), .bit_8(ExtendedValue));

    // ALU
	wire [7:0]ALUOutput;
	wire [7:0]ALU_B;
	// MUX CENTER (between Register and ALU)
    assign ALU_B = ALUSrc ? ExtendedValue : ReadRegisterResult2;
    adder8 ALU(ReadRegisterResult1, ALU_B, ALUOutput);
	
	// Program Counter
	wire [7:0]pc_1;
	wire [7:0]pc_jump;
	wire [7:0]nextPC;
	// pc_1 = pc_sampled + 1
	adder8 Add_Left(8'b00000001, pc_sampled, pc_1);
	// pc_jump = pc_1 + ExtendedValue
	adder8 Add_Right(pc_1, ExtendedValue, pc_jump);
	// MUX UP
    assign nextPC = Branch ? pc_jump : pc_1;
	
    wire [7:0]ReadDataResult;
    // Data Memory
    Data_Unit Data_Memory(
       .Reset(Reset),
       .CLK(CLK),
       .Address(ALUOutput),
       .ReadData(ReadDataResult),
       .MemWrite(MemWrite),
       .WriteData(ReadRegisterResult2)
    );
    
    // MUX RIGHT
    assign RegWriteData = MemtoReg ? ReadDataResult : ALUOutput;
	
	// Flip-Flop
	initial begin
        pc_sampled = 8'b0;	
	end
	always@(posedge CLK) begin
        // Wait for other rising edge triggered (Register, Data)
		#200 pc_sampled = nextPC;
	end
	
	
	// LED
    hexa_to_7 L1(RegWriteData[7:4], LED1);
    hexa_to_7 L2(RegWriteData[3:0], LED2);
    
    wire [6:0] LED3_sw;
    wire [6:0] LED4_sw;
    hexa_to_7 L3(ReadRegisterResult2[7:4], LED3_sw);
    hexa_to_7 L4(ReadRegisterResult2[3:0], LED4_sw);
    assign LED3 = (instruction[7:6] == 2'b00) ? 7'b0:
                  (instruction[7:6] == 2'b01) ? 7'b0:
                  (instruction[7:6] == 2'b10) ? LED3_sw:
                  (instruction[7:6] == 2'b11) ? 7'b0:
                  7'b00000000;
    assign LED4 = (instruction[7:6] == 2'b00) ? 7'b0000101: // 'r'
                  (instruction[7:6] == 2'b01) ? 7'b0000101: // 'r'
                  (instruction[7:6] == 2'b10) ? LED4_sw:    // DataWriteValue
                  (instruction[7:6] == 2'b11) ? 7'b1011000: // 'j'
                  7'b00000000;
    
    wire [7:0] LEDValue_Third;
    assign LEDValue_Third = (instruction[7:6] == 2'b00) ? WriteRegister: // RegisterWriteAddress
                            (instruction[7:6] == 2'b01) ? WriteRegister: // RegisterWriteAddress
                            (instruction[7:6] == 2'b10) ? ALUOutput: // DataWriteAddress
                            (instruction[7:6] == 2'b11) ? nextPC:  // Program Counter
                            8'b00000000;
    hexa_to_7 L5(LEDValue_Third[7:4], LED5);
    hexa_to_7 L6(LEDValue_Third[3:0], LED6); 
    
endmodule
