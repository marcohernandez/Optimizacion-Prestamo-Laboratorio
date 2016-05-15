module prescaler_20m(
	input clk,
	output reg clk_20m
	);

	reg [28:0] re;
	initial re <= 0;
	initial clk_20m = 0;

	always@( posedge clk )
	begin
		
	    if( re == 30000 ) 
	    begin
	        re <= 0;
	        clk_20m <= ~ clk_20m;
	    end
	    else re <= re + 29'd1;
	end 
endmodule
