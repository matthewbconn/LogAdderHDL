`include "adder.v"
`include "size.v"
`timescale 10ns/1ns
module adder_testbench;
// adder.v ports: 	a, Sa, b, Sb, result, resultSign

reg signed [`WBITS:1] A_tb, B_tb;
reg SignA,SignB;
wire signed [`WBITS:1] res_tb;
wire signed [`WBITS:1] diff;
wire resSgn;
wire first_greater;

adder myAdder (.a(A_tb), .Sa(signA), .b(B_tb), .Sb(SignB), .result(res_tb), .resultSign(resSgn));
absValueComparator myComp (.x(A_tb),.y(B_tb),.d(diff),.xGreater(first_greater));

task testAdd;
input signed [`WBITS:1] A_val, B_val;
input A_sign,B_sign;

  begin
    A_tb = A_val;
    B_tb = B_val;
    SignA = A_sign;
    SignB = B_sign;
    #50 // arbitrary guess at correct delay time
    $display("\n\n Test inputs: %0d and %0d \n",A_tb,B_tb);
    $display("\t Test inputs: %b _ %b and %b _ %b \n",A_tb[`WBITS:`FRACBITS + 1],A_tb[`FRACBITS:1],B_tb[`WBITS:`FRACBITS + 1],B_tb[`FRACBITS:1]);
    $display("\t Test |diff|: %b _ %b \n",  diff[`WBITS: `FRACBITS + 1],diff[`FRACBITS:1]);
    $display("\t Test output a+b = %b _ %b and resSign %b", res_tb[`WBITS:`FRACBITS + 1], res_tb[`FRACBITS:1], resSgn);
  end

endtask

initial
 begin: STIMULUS
    testAdd(86,87,1,1);
    testAdd(62,108,0,0);
    testAdd(40,96,0,0);
    testAdd(106,109,0,1);
 end // STIMULUS

endmodule // abs_tbb