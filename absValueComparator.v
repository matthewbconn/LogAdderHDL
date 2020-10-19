`include "size.v"

module absValueComparator
	(x,  y, d, xGreater);
	input signed [`WBITS: 1] x, y;
	output reg signed[`WBITS: 1] d;
	output reg xGreater;

	reg signed [`WBITS:1] dtemp;
	reg signed [`WBITS:1] yneg;
	reg signed [`WBITS:1] temp1;
	reg overflowPossible;
	reg overflowOccurred;
	reg condition;
	reg signed [`WBITS+1:1] signExtended;

	always @(*)
	begin
		yneg <= ~y + 1;
		temp1 <= x + yneg;
		dtemp <= x - y;
		overflowPossible <= ~(x[`WBITS] ^ yneg[`WBITS]); // if they are the opposite sign, no overflow
		d <= dtemp[`WBITS] ? ~dtemp + 1 : dtemp;
		xGreater <= (x > y) ? 1 : 0;
		condition <= temp1[`WBITS] & ~x[`WBITS];
		overflowOccurred <= overflowPossible & (condition); //(signExtended != dtemp );
		if (overflowOccurred)
			begin
			d <= x [`WBITS] ? `MIN: ` MAX;
			end
		else
			begin
			// do nothing
			end

	end // always
	
endmodule
