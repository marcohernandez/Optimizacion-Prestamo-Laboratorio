module divisor_clk
	(
	 input clk,
	 output reg clk_out1 = 1'b1,
	 output reg clk_out2 = 1'b1
	);

reg [18:0] cont_1 = 19'b0;
reg [18:0] cont_2 = 19'b0;

parameter valor_divisor2 = 19'd50000;		//50000; //1KHz fecuencia de muestreo
//parameter valor_divisor1 = 26'd5000000;		//500000; //100Hz fecuencia de muestreo
parameter valor_divisor1 = valor_divisor2/2;	//25000; //2KHz


always @(posedge clk) begin
	if (cont_1 == (valor_divisor1-1)) begin
		clk_out1 <= ~clk_out1;
		cont_1 <= 0;		
		end
	else begin cont_1 <= cont_1 + 1'b1; end
	end

always @(posedge clk) begin
	if (cont_2 == (valor_divisor2-1)) begin
		clk_out2 <= ~clk_out2;
		cont_2 <= 0;
		end
	else begin cont_2 <= cont_2 + 1'b1; end
	end

endmodule
