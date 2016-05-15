module key_top
	(
	 input clk,
	 input [3:0] JAin,
	 output [3:0] JAout,
	 output [3:0] outcode
	);

wire [4:0] outcode;
wire clk_1; 
wire clk_2;

divisor_clk divisor_clk
	(
	.clk(clk),
	.clk_out1(clk_1),
	.clk_out2(clk_2)
	);

decoder_key decoder_key
	(
	.clk(clk_2),
	.columnas(JAin),
	.outcode(outcode),
	.filas(JAout)
	);
endmodule
