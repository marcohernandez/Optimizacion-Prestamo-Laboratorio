module selector_filas_key
	(
	 input [1:0] sel,
	 output reg [3:0] valfilas
	);
	
	always @(*)
	case (sel)
		2'b000: valfilas = 4'b0001;
		2'b001: valfilas = 4'b0010;
		2'b010: valfilas = 4'b0100;
		default: valfilas = 4'b1000;
	endcase
endmodule
