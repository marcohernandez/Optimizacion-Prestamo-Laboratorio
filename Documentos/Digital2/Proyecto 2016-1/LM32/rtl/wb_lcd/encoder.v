module encoder(
	input [3:0] out_BCD1,
	input [3:0] out_BCD2,
	input [3:0] out_BCD3,
	output reg [7:0] enco1,
	output reg [7:0] enco2,
	output reg [7:0] enco3
	);

	always@( out_BCD1, out_BCD2, out_BCD3 )
	begin
	case( out_BCD1 )
	4'b0001: enco1 = 8'b00110001; //1
	4'b0010: enco1 = 8'b00110010; //2
	4'b0011: enco1 = 8'b00110011; //3 
	4'b0100: enco1 = 8'b00110100; //4
	4'b0101: enco1 = 8'b00110101; //5
	4'b0110: enco1 = 8'b00110110; //6
	4'b0111: enco1 = 8'b00110111; //7
	4'b1000: enco1 = 8'b00111000; //8
	4'b1001: enco1 = 8'b00111001; //9
	default: enco1 = 8'b00110000; //0
	endcase
		
	case( out_BCD2 )
	4'b0001: enco2 = 8'b00110001; //1
	4'b0010: enco2 = 8'b00110010; //2
	4'b0011: enco2 = 8'b00110011; //3 
	4'b0100: enco2 = 8'b00110100; //4
	4'b0101: enco2 = 8'b00110101; //5
	4'b0110: enco2 = 8'b00110110; //6
	4'b0111: enco2 = 8'b00110111; //7
	4'b1000: enco2 = 8'b00111000; //8
	4'b1001: enco2 = 8'b00111001; //9
	default: enco2 = 8'b00110000; //0
		
	endcase

	case( out_BCD3 )
	4'b0001: enco3 = 8'b00110001; //1
	4'b0010: enco3 = 8'b00110010; //2
	4'b0011: enco3 = 8'b00110011; //3 
	4'b0100: enco3 = 8'b00110100; //4
	4'b0101: enco3 = 8'b00110101; //5
	4'b0110: enco3 = 8'b00110110; //6
	4'b0111: enco3 = 8'b00110111; //7
	4'b1000: enco3 = 8'b00111000; //8
	4'b1001: enco3 = 8'b00111001; //9
	default: enco3 = 8'b00110000; //0
		
	endcase

	end
	
endmodule
