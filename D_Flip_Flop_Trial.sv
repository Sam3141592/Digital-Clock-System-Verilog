
module D_Flip_Flop_Trial (
	input clk,    // Clock
	input D,
	output Q
);

D_Flip_Flop d0(clk,D,0,0,1,Q);

endmodule