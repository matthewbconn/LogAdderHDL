`include "size.v"
`include "absValueComparator.v"
`include "deltaBS.v"

// Matt's best shot
module adder 
(
	a, Sa, b, Sb, result, resultSign
);

	input signed [`WBITS: 1] a, b;
	input Sa, Sb;
	output reg signed[`WBITS: 1] result;
	output reg resultSign;
	wire [`WBITS: 1] d;
	reg [`WBITS: 1] larger;
	wire [`WBITS: 1] deltaPart;
	reg DP;
	wire A_larger;

	absValueComparator myComp (.x(a),.y(b),.d(d),.xGreater(A_larger));
	deltaBS mydelta (.diff(d), .sign(DP), .res(deltaPart));

	always @(*)
		begin
		
		// 1. Find larger of |a|,|b|
		larger <= A_larger ? a : b;
		resultSign <= A_larger ? Sa : Sb;

		// 2. Find |d| = |a-b|
		  // done in absComparator

		// 3. Delta Call
		DP <= a[`WBITS] == b[`WBITS] ? 1 : 0;

		// 4. Combine (1) and (3) for result
		result = larger + deltaPart;

	end // always


endmodule
