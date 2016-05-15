module ps2_controller
	(
	 input clk,
	 input reset,        
	 input PS2_DAT,
	 input PS2_CLK,
	 output [7:0] scan_code
);

	wire read;
	wire scan_ready;
	wire [7:0] code;

	ps22ascii ps22ascii0(
		.ps2_code(code),
		.ascii_code(scan_code)
	);

	oneshot pulser(
		.clk_100(clk),
		.trigger_in(scan_ready),
		.pulse_out(read)
	);

	ps2 kbd(
		.ps2_clk(PS2_CLK),
		.ps2_data(PS2_DAT),
		.clk_100(clk),
		.reset(reset),
		.read(read),
		.scan_ready(scan_ready),
		.scan_code(code)
	);

endmodule
