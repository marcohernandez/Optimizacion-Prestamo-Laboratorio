module antirrebote(
	input u,
	output mon1
	);

	wire reset, set, b;

	assign reset = u ? 0 : 1'bz;
	assign set = u ? 1'bz : 0;

	assign b = ~( set & mon1 );	
	assign mon1 = ~( reset & b );


endmodule
