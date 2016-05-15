module oneshot
	(
	 input clk_100,
	 input trigger_in,
	 output reg pulse_out
	);
	
	reg delay;
	reg clk; // 50 Mhz internal clock

	// divide-by-two 100MHz to 50MHz
	always @(posedge clk_100)
	    clk <= ~clk;

	always @ (posedge clk)
	begin
	    if (trigger_in && !delay) pulse_out <= 1'b1;
	    else pulse_out <= 1'b0;
	    delay <= trigger_in;
	end 
endmodule
