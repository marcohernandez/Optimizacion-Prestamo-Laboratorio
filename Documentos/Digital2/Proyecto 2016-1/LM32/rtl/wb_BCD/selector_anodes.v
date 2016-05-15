module selector_anodes
	(
	 input clk,
	 input [3:0] valor,	
	 output reg [7:0] valanode,
	 output reg [3:0] outvalsseg
	);
	
	reg [25:0] counter;
	reg [2:0] sel;
	reg clk1;
	initial begin counter=0; sel=0; clk1=0; end

	always @(posedge clk)
	if (counter==50000) begin counter=0; clk1=~clk1; end
	else begin counter=counter+1; end

	always @(posedge clk1)
	begin
	if (sel==7) begin sel=0; outvalsseg = valor; end
	else begin sel=sel+1; outvalsseg = 4'b0000; end
	end

	always @(sel)
	case (sel)
		3'b000: valanode = 8'b11111110;
		3'b001: valanode = 8'b11111101;
		3'b010: valanode = 8'b11111011;
		3'b011: valanode = 8'b11110111;
		3'b100: valanode = 8'b11101111;
		3'b101: valanode = 8'b11011111;
		3'b110: valanode = 8'b10111111;
		default: valanode = 8'b01111111;
	endcase
endmodule
