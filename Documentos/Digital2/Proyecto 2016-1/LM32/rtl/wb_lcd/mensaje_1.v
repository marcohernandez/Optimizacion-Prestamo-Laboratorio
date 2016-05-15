module mensaje_1( 
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

	parameter C11 = 4;
	parameter o11 = 5;
	parameter n11 = 6;
	parameter t11 = 7;
	parameter r11 = 8;
	parameter a11 = 9;
	parameter s11 = 10;
	parameter e11 = 11;
	parameter n12 = 12;
	parameter a12 = 13;
	parameter espace11 = 14;
	parameter i11 = 15;
	parameter n13 = 16;
	parameter v11 = 17;
	parameter a13 = 18;
	parameter l11 = 19;
	parameter i12 = 20;
	parameter d11 = 21;
	parameter a14 = 22;

	parameter dr3 = 23;

	parameter I21 = 24;
	parameter n21 = 25;
	parameter t21 = 26;
	parameter e21 = 27;
	parameter n22 = 28;
	parameter t22 = 29;
	parameter e22 = 30;
	parameter espace21 = 31;
	parameter d21 = 32;
	parameter e23 = 33;
	parameter espace22 = 34;
	parameter n23 = 35;
	parameter u21 = 36;
	parameter e24 = 37;
	parameter v21 = 38;
	parameter o21 = 39;

	parameter dr4 = 40;

	parameter P31 = 41;
	parameter r31 = 42;
	parameter e31 = 43;
	parameter s31 = 44;
	parameter i31 = 45;
	parameter o31 = 46;
	parameter n31 = 47;
	parameter e32 = 48;
	parameter espace31 = 49;
	parameter par_abierto31 = 50;
	parameter cero31 = 51;
	parameter par_cerrado31 = 52;

	parameter erase = 53;
			
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

	o11, o21, o31:						begin	dbi = 8'd111;	wr = 1;	dr = 0;	end
	n11, n12, n13, n21, n22, n23, n31:			begin	dbi = 8'd110;	wr = 1;	dr = 0;	end
	t11, t21, t22:						begin	dbi = 8'd116;	wr = 1;	dr = 0;	end
	r11, r31:						begin	dbi = 8'd114;	wr = 1;	dr = 0;	end
	espace11, espace21, espace22, espace31:			begin	dbi = 8'd32;	wr = 1;	dr = 0;	end
	d11, d21:						begin	dbi = 8'd100;	wr = 1;	dr = 0;	end
	e11, e21, e22, e23, e24, e31, e32:			begin	dbi = 8'd101;	wr = 1;	dr = 0;	end
	i11, i12, i31:						begin	dbi = 8'd105;	wr = 1;	dr = 0;	end
	s11, s31:						begin	dbi = 8'd115;	wr = 1;	dr = 0;	end
	u21:							begin	dbi = 8'd117;	wr = 1;	dr = 0;	end
	a11, a12, a13, a14:					begin	dbi = 8'd97;	wr = 1;	dr = 0;	end
	C11:							begin	dbi = 8'd67;	wr = 1;	dr = 0;	end
	I21:							begin	dbi = 8'd73;	wr = 1;	dr = 0;	end
	l11:							begin	dbi = 8'd108;	wr = 1;	dr = 0;	end
	v11, v21:						begin	dbi = 8'd118;	wr = 1;	dr = 0;	end
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









	

	
	
