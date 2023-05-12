`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:28 04/25/2023 
// Design Name: 
// Module Name:    bcds 
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
module bcds(
    input A,
    input B,
    input C,
    input D,
    output [6:0] Z
    );
	 
wire N_A, N_B, N_C, N_D;
wire B_nC_D, C_D, nB_nD, B_C_nD, nB_D, nC_nD, nB_C, B_nC, C_nD, B_nD,  B_D, nA_B_C_D;

not T1(N_A, A);
not T2(N_B, B);
not T3(N_C, C);
not T4(N_D, D);

and X1(B_nC_D, B, N_C, D);
and X2(C_D, C, D);
and X3(nB_nD, N_B, N_D);
and X4(B_C_nD, B, C, N_D);
and X5(nB_D, N_B, D);
and X6(nC_nD, N_C, N_D);
and X7(nB_C, N_B, C);
and X8(B_nC, B, N_C);
and X9(C_nD, C, N_D);
and X10(B_nD, B, N_D);
and X11(B_D, B, D);
and X12(nA_B_C_D, N_A, B, C, D);

or Y1(Z[0], A, B_nC, nB_C, C_nD);
or Y2(Z[1], A, B_nC, B_nD, nC_nD, nA_B_C_D);
or Y3(Z[2], nB_nD, C_nD);
or Y4(Z[3], B_nC_D, C_nD, nB_nD, nB_C, A);
or Y5(Z[4], B, N_C, D);
or Y6(Z[5], N_B, nC_nD, C_D);
or Y7(Z[6], A, C, B_D, nB_nD);



endmodule
