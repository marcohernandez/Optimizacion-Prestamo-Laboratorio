module prescaler_10m(
	input clk,
	output reg clk_10m
	);

	reg [28:0] re;
	initial re <= 0;
	initial clk_10m = 0;

	always@( posedge clk )
	begin
		
	    if( re == 10000 ) 
	    begin
	        re <= 0;
	        clk_10m <= ~ clk_10m;
	    end
	    else re <= re + 29'd1;
	end 
endmodule
