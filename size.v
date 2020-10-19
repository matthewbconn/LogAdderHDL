`define WBITS 8
`define FRACBITS 4
`define ONE (1 << `FRACBITS)
`define ONE_PT_FIVE ((1 << `FRACBITS) + (1 << (`FRACBITS - 1)))
`define MIN `WBITS'b1000_0000		//`WBITS'(1 << (`WBITS -1 ))  // These will be 
`define MAX (~`MIN)			// sign extended to 32b, hence why we take only the lower bits in absValueComparator
`timescale 1 ns / 100 ps
