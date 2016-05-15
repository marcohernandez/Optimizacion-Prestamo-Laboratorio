module mensaje_0( 
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

	parameter U11 = 4;
	parameter s11 = 5;
	parameter u11 = 6;
	parameter a11 = 7;
	parameter r11 = 8;
	parameter i11 = 9;
	parameter o11 = 10;
	parameter espace11 = 11;
	parameter n11 = 12;
	parameter o12 = 13;
	parameter espace12 = 14;
	parameter e11 = 15;
	parameter x11 = 16;
	parameter i12 = 17;
	parameter s12 = 18;
	parameter t11 = 19;
	parameter e12 = 20;

	parameter dr3 = 21;

	parameter I21 = 22;
	parameter n21 = 23;
	parameter t21 = 24;
	parameter e21 = 25;
	parameter n22 = 26;
	parameter t22 = 27;
	parameter e22 = 28;
	parameter espace21 = 29;
	parameter d21 = 30;
	parameter e23 = 31;
	parameter espace22 = 32;
	parameter n23 = 33;
	parameter u21 = 34;
	parameter e24 = 35;
	parameter v21 = 36;
	parameter o21 = 37;

	parameter dr4 = 38;

	parameter P31 = 39;
	parameter r31 = 40;
	parameter e31 = 41;
	parameter s31 = 42;
	parameter i31 = 43;
	parameter o31 = 44;
	parameter n31 = 45;
	parameter e32 = 46;
	parameter espace31 = 47;
	parameter par_abierto31 = 48;
	parameter cero31 = 49;
	parameter par_cerrado31 = 50;

	parameter erase = 51;
			
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
	    direc = 8'b10000001;
	    wr = 0;
	    dr = 1;
	end

	dr3:
	begin
	    direc = 8'b10010110;
	    wr = 0;
	    dr = 1;
	end

	dr4:
	begin
	    direc = 8'b11011000;
	    wr = 0;
	    dr = 1;
	end

	o11, o12, o21, o31:					begin	dbi = 8'd111;	wr = 1;	dr = 0;	end
	n11, n21, n22, n23, n31:				begin	dbi = 8'd110;	wr = 1;	dr = 0;	end
	t11, t21, t22:						begin	dbi = 8'd116;	wr = 1;	dr = 0;	end
	r11, r31:						begin	dbi = 8'd114;	wr = 1;	dr = 0;	end
	espace11, espace12, espace21, espace22, espace31:	begin	dbi = 8'd32;	wr = 1;	dr = 0;	end
	d21:							begin	dbi = 8'd100;	wr = 1;	dr = 0;	end
	e11, e12, e21, e22, e23, e24, e31, e32:			begin	dbi = 8'd101;	wr = 1;	dr = 0;	end
	i11, i12, i31:						begin	dbi = 8'd105;	wr = 1;	dr = 0;	end
	s11, s12, s31:						begin	dbi = 8'd115;	wr = 1;	dr = 0;	end
	u11, u21:						begin	dbi = 8'd117;	wr = 1;	dr = 0;	end
	a11:							begin	dbi = 8'd97;	wr = 1;	dr = 0;	end
	U11:							begin	dbi = 8'd85;	wr = 1;	dr = 0;	end
	I21:							begin	dbi = 8'd73;	wr = 1;	dr = 0;	end
	x11:							begin	dbi = 8'd120;	wr = 1;	dr = 0;	end
	v21:							begin	dbi = 8'd118;	wr = 1;	dr = 0;	end
	P31:							begin	dbi = 8'd80;	wr = 1;	dr = 0;	end
	par_abierto31:						begin	dbi = 8'd40;	wr = 1;	dr = 0;	end
	par_cerrado31:						begin	dbi = 8'd41;	wr = 1;	dr = 0;	end
	cero31:							begin	dbi = 8'd48;	wr = 1;	dr = 0;	end

	erase:
	begin
	    direc = 8'b00000001;
	    wr = 0;
	    dr = 1;
	end	

	endcase
	end

endmodule









	

	
	
