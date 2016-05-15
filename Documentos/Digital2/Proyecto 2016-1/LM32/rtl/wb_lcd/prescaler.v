module prescaler(
	input clk,
	output reg clk2
	);

	reg [26:0] re;
	initial re <= 0;

	always@( posedge clk )
	begin
		
	    if( re == 100 ) 
	    begin
	        re <= 0;
	        clk2 <= ~ clk2;
	    end
	    else re <= re + 27'd1;
	end 
endmodule
