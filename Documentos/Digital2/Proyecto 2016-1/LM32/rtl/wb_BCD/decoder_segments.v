module decoder_segments 
	(
	 input [3:0] dec,
	 output reg [6:0] sseg 
	);
	
	always @(dec)
	case(dec)
	
	4'b0000: sseg = 7'b0000001; // 0
	4'b0001: sseg = 7'b1001111; // 1
	4'b0010: sseg = 7'b0010010; // 2
	4'b0011: sseg = 7'b0000110; // 3
	4'b0100: sseg = 7'b1001100; // 4
	4'b0101: sseg = 7'b0100100; // 5
	4'b0110: sseg = 7'b0100000; // 6
	4'b0111: sseg = 7'b0001111; // 7
	4'b1000: sseg = 7'b0000000; // 8
	4'b1001: sseg = 7'b0000100; // 9
	4'b1010: sseg = 7'b0001000; // A	
	4'b1011: sseg = 7'b1100000; // B
	4'b1100: sseg = 7'b0110001; // C
	4'b1101: sseg = 7'b1000010; // D
	4'b1110: sseg = 7'b0110000; // E
	4'b1111: sseg = 7'b0111000; // F
	default: sseg = 7'b1111111; // NULL
	endcase
endmodule
