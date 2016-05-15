module bat(
	input rst,
	input clk2,
	input clk_20m,
	input [1:0] carga,
	output reg wr,
	output reg dr,
	output reg [7:0] direc,
	output reg [7:0] dbi
	);

	reg [3:0] estado = 0;
	reg [3:0] nestado = 0;
	initial wr = 0;
	initial dr = 0;
	parameter stay = 0;
	parameter dr1 = 1;
	parameter line = 2;
	parameter dr2 = 3;
	parameter dr3 = 4;
	parameter dr4 = 5;
	parameter line2 = 6;
	parameter line3 = 7;
	parameter line4 = 8;
	
	
	always@( negedge clk_20m )
	begin
	if( carga == 0 )
	begin
	case( estado )
	    stay: nestado = dr1;
	    dr1: nestado = line;
	    line: nestado = stay;
	endcase
	end
	if( carga == 1 )
	begin
	case( estado )
	    stay: nestado = dr1;
	    dr1: nestado = line;
	    line: nestado = dr2;
	    dr2: nestado = line2;
	    line2: nestado = stay;
	endcase
	end
	if( carga == 2 )
	begin
	case( estado )
	    stay: nestado = dr1;
	    dr1: nestado = line;
	    line: nestado = dr2;
	    dr2: nestado = line2;
	    line2: nestado = dr3;
	    dr3: nestado = line3;
	    line3: nestado = stay;
	endcase
	end
	if( carga == 3 )
	begin
	case( estado )
	    stay: nestado = dr1;
	    dr1: nestado = line;
	    line: nestado = dr2;
	    dr2: nestado = line2;
	    line2: nestado = dr3;
	    dr3: nestado = line3;
	    line3: nestado = dr4;
	    dr4: nestado = line4;
	    line4: nestado = stay;
	endcase
	end
	
	end

	always@( posedge clk2 ) //Reset opcional, Actualizacion de estados
	begin

	if( rst ) estado = stay;
	else estado = nestado;	

	end

	always@( estado ) //Memoria de estados
	begin
	
	case( estado )

	stay:
	begin 
	    wr = 0;
	    dr = 0;
	end
	
	dr1:
	begin
	    direc = 8'b10010000;
	    wr = 0;
	    dr = 1;
	end

	dr2:
	begin
	    direc = 8'b10010001;
	    wr = 0;
	    dr = 1;
	end

	dr3:
	begin
	    direc = 8'b10010010;
	    wr = 0;
	    dr = 1;
	end

	dr4:
	begin
	    direc = 8'b10010011;
	    wr = 0;
	    dr = 1;
	end

	line, line2, line3, line4:
	begin
	    dbi = 8'b11111111;
	    wr = 1;
	    dr = 0;
	end

	endcase

	end
endmodule
		
