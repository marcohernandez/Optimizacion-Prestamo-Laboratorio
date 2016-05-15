module decoder_key
	(
	 input clk,
	 input [3:0] columnas,
	 output reg [4:0] outcode = 5'b00000,
	 output [3:0] filas
	);

reg [1:0] cont = 2'b0;

selector_filas_key
	(
	.sel(cont),
	.valfilas(filas)
	);

always @(posedge clk) begin
		if (cont == 2'b11) begin cont <= 0; end
		else begin cont <= cont + 2'b01; end
	end

always @(negedge clk) begin
		
		case (cont)
		2'b00:	begin
				case (columnas)
				4'b0001: outcode <= 5'd1;
				4'b0010: outcode <= 5'd2;
				4'b0100: outcode <= 5'd3;
				4'b1000: outcode <= 5'd10;
				endcase
			end
		2'b01:	begin
				case(columnas)
				4'b0001: outcode <= 5'd4;
				4'b0010: outcode <= 5'd5;
				4'b0100: outcode <= 5'd6;
				4'b1000: outcode <= 5'd11;
				endcase
			end
		2'b10:	begin
				case(columnas)
				4'b0001: outcode <= 5'd7;
				4'b0010: outcode <= 5'd8;
				4'b0100: outcode <= 5'd9;
				4'b1000: outcode <= 5'd12;
				endcase
			end
		2'b11:	begin
				case(columnas)
				4'b0001: outcode <= 5'd14;
				4'b0010: outcode <= 5'd0;
				4'b0100: outcode <= 5'd15;
				4'b1000: outcode <= 5'd13;
				endcase
			end
		endcase
		end 

endmodule
