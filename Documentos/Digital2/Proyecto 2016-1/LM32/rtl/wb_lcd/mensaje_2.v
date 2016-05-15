module mensaje_2( 
	input rst,
	input clk2,
	input clk_20m,
	input wrmenu,
	input down,
	input up,
	output reg[7:0] dbi,
	output reg wr,
	output reg dr,
	output reg [7:0] direc
	);
	
	initial wr = 0;
	reg [1:0] pag = 0;
	reg [6:0] estado = 0;
	reg [6:0] nestado = 0;

	parameter stay = 0;

	parameter dr1 = 1;
	parameter dr10 = 2;
	parameter dr11 = 3;

	parameter R11 = 4;
	parameter e11 = 5;
	parameter g11 = 6;
	parameter i11 = 7;
	parameter s11 = 8;
	parameter t11 = 9;
	parameter r11 = 10;
	parameter o11 = 11;
	parameter espace11 = 12;
	parameter e12 = 13;
	parameter x11 = 14;
	parameter i12 = 15;
	parameter t12 = 16;
	parameter o12 = 17;
	parameter s12 = 18;
	parameter o13 = 19;

	parameter dr4 = 20;

	parameter P31 = 21;
	parameter r31 = 22;
	parameter e31 = 23;
	parameter s31 = 24;
	parameter i31 = 25;
	parameter o31 = 26;
	parameter n31 = 27;
	parameter e32 = 28;
	parameter espace31 = 29;
	parameter par_abierto31 = 30;
	parameter cero31 = 31;
	parameter par_cerrado31 = 32;

	parameter erase = 33;
			
	always@( negedge clk_20m ) //Logica de estado siguiente
	begin
	
	if( estado == stay)
	begin
	    if( wrmenu)
	    begin
	        nestado = erase;
	    end
	    else
	    begin
		nestado = stay;
	    end
	end 

	else if( estado == erase ) nestado = dr1;	

	else if( estado == par_cerrado31) nestado = stay;

	else nestado = estado + 7'd1;	

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
	
	dr1, dr10, dr11:
	begin
	    direc = 8'b10000010;
	    wr = 0;
	    dr = 1;
	end

	dr4:
	begin
	    direc = 8'b11011000;
	    wr = 0;
	    dr = 1;
	end

	o11, o12, o13, o31:	begin	dbi = 8'd111;	wr = 1;	dr = 0;	end
	n31:			begin	dbi = 8'd110;	wr = 1;	dr = 0;	end
	t11, t12:		begin	dbi = 8'd116;	wr = 1;	dr = 0;	end
	r11, r31:		begin	dbi = 8'd114;	wr = 1;	dr = 0;	end
	espace11, espace31:	begin	dbi = 8'd32;	wr = 1;	dr = 0;	end
	e11, e12, e31, e32:	begin	dbi = 8'd101;	wr = 1;	dr = 0;	end
	i11, i12, i31:		begin	dbi = 8'd105;	wr = 1;	dr = 0;	end
	s11, s12, s31:		begin	dbi = 8'd115;	wr = 1;	dr = 0;	end
	R11:			begin	dbi = 8'd82;	wr = 1;	dr = 0;	end
	x11:			begin	dbi = 8'd120;	wr = 1;	dr = 0;	end
	P31:			begin	dbi = 8'd80;	wr = 1;	dr = 0;	end
	par_abierto31:		begin	dbi = 8'd40;	wr = 1;	dr = 0;	end
	par_cerrado31:		begin	dbi = 8'd41;	wr = 1;	dr = 0;	end
	cero31:			begin	dbi = 8'd48;	wr = 1;	dr = 0;	end
	g11:			begin	dbi = 8'd103;	wr = 1;	dr = 0;	end

	erase:
	begin
	    direc = 8'b00000001;
	    wr = 0;
	    dr = 1;
	end	

	endcase
	end

endmodule









	

	
	
