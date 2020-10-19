`include "absValueComparator.v"
`include "size.v"
module absTester;
// absValueComparator ports: x, y, d, xGreater

reg signed [`WBITS:1] A_tb, B_tb;
wire signed [`WBITS:1] res_tb;
wire first_greater;

absValueComparator myComp (.x(A_tb),.y(B_tb),.d(res_tb),.xGreater(first_greater));

task testComp;
input signed [`WBITS:1] A_val, B_val;

  begin
    A_tb = A_val;
    B_tb = B_val;
    #10 // arbitrary guess at correct delay time
    $display("\n\n Test inputs: %0d and %0d \n",A_tb,B_tb);
    $display("\n\t Test inputs: %b and %b \n",A_tb,B_tb);
    $display("\t Test output |x-y| = %0d and Agreater %b", res_tb, first_greater);
  end

endtask

initial
 begin: STIMULUS
    testComp(4,-4);
    testComp(-4,4);
    testComp(-3,2);
    testComp(-2,3);
    testComp(2,-3);
    testComp(3,-2);
    testComp(100,-50);
    testComp(-50,100);
    $display("\n min: %0d = %b",`MIN,`MIN);//[`WBITS:1]);
    $display("\n max: %0d = %b",`MAX,`MAX);//[`WBITS:1]);
 end // STIMULUS

endmodule // abs_tbb