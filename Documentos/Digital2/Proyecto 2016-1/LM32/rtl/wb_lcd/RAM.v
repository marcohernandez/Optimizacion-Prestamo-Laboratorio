module RAM(
	input rst,
	input clk2,
	input rd,
	input wr1,
	input [7:0] dbin1,
	input [7:0] addr1,
	input [7:0] addr2,
	output reg [7:0] dbout1,
	output reg led2,
	output reg led3
	);
	
	initial led2 = 0;
	initial led3 = 0;
	reg [15:0] ram [255:0]; // memoria 255-bit x 16-bit
	integer i;

	initial begin			
            $readmemb("lista.txt", ram);
	end	

	always@( posedge clk2 )
	begin

	if( rst ) 
	begin
	    $readmemb("lista.txt", ram);
	    led3 = 1;
	end

	if( rd  ) 
	begin	
	    dbout1 <= ram[addr2];
	    led2 = 1;
	end	
	else if( wr1 ) ram[addr1] <= dbin1;
	
	end

	/*always@( posedge clk2 )
	begin
	if( rd2 ) dbout2 <= ram[addr2];
	else if( wr2 ) ram[addr2] <= dbin2;
	if( rd2 ) dbout2 <= ram[addr2];
	end*/

endmodule
