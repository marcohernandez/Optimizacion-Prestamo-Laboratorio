`timescale 1ns / 1ps

module BCD(
		input clk,		
		input [3:0] dato,
		output [6:0] seg,
		output [7:0] an
);

wire [3:0] dato_wire;
wire [3:0] dato_in;

decoder_segments decoder_segments
	(
	.sseg(seg),
	.dec(dato_wire)
	);

selector_anodes selector_anodes
	(
	.clk(clk),
	.valor(dato_in),
	.valanode(an),
	.outvalsseg(dato_wire)
	);

assign dato_in = dato;

endmodule
