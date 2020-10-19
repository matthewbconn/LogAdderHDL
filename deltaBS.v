`include "size.v"
`include "absValueComparator.v"

module deltaBS
(
	diff, sign, res
);

	input signed[`WBITS:1] diff;
	input sign;
	output reg signed[`WBITS:1] res;

	wire [`WBITS:`FRACBITS + 1] diffInt = diff[`WBITS:`FRACBITS + 1];
	wire [`WBITS - 1:1] zeroes = 0;
	wire [`WBITS:1] MSB_MASK = {"1",zeroes};

	always @(*)
		begin: myAlways
		  if(diffInt <= `FRACBITS)
		  begin
			if (sign) // delta_PLUS
				begin
					res <= `ONE >> diffInt;
				end // if - if
			else	  // delta_MINUS
				begin
					res <= (`ONE_PT_FIVE >> diffInt) | MSB_MASK;
				end // if - else
		  end

		  else // if
		  begin
			res <= 0;
		  end // else
		end

endmodule 