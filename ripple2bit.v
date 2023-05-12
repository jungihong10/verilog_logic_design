`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
module ripple2bit(
    input [1:0]A, B,
    input Cin,
    output [1:0]Z,
    output Cout
    );

	wire c0;
	
	Fulladder1bit FA1 (
		.A(A[0]),
		.B(B[0]),
		.Cin(Cin),
		.Z(Z[0]),
		.Cout(c0)
	);
	Fulladder1bit FA2(
		.A(A[1]),
		.B(B[1]),
		.Cin(c0),
		.Z(Z[1]),
		.Cout(Cout)
	);


endmodule
