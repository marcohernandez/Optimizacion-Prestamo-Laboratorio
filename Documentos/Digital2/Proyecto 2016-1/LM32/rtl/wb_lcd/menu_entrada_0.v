module menu_entrada_0( 
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

	parameter E11 = 4;
	parameter n11 = 5;
	parameter t11 = 6;
	parameter r11 = 7;
	parameter a11 = 8;
	parameter d11 = 9;
	parameter a12 = 10;

	parameter dr3 = 11;

	parameter I21 = 12;
	parameter n21 = 13;
	parameter g21 = 14;
	parameter r21 = 15;
	parameter e21 = 16;
	parameter s21 = 17;
	parameter e22 = 18;
	parameter espace21 = 19;
	parameter u21 = 20;
	parameter s22 = 21;
	parameter u22 = 22;
	parameter a21 = 23;
	parameter r22 = 24;
	parameter i21 = 25;
	parameter o21 = 26;

	parameter dr4 = 27;

	parameter U31 = 28;
	parameter s31 = 29;
	parameter u31 = 30;
	parameter a31 = 31;
	parameter r31 = 32;
	parameter i31 = 33;
	parameter o31 = 34;
	parameter dospuntos31 = 35;

	parameter erase = 36;
			
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

	else if( estado == dospuntos31) nestado = stay;

	else nestado = estado + 1;	

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
	    direc = 8'b10000110;
	    wr = 0;
	    dr = 1;
	end

	dr3:
	begin
	    direc = 8'b10010101;
	    wr = 0;
	    dr = 1;
	end

	dr4:
	begin
	    direc = 8'b11010101;
	    wr = 0;
	    dr = 1;
	end

	dospuntos31:		begin	dbi = 8'd58;	wr = 1;	dr = 0;	end
	o21, o31:		begin	dbi = 8'd111;	wr = 1;	dr = 0;	end
	n11, n21:		begin	dbi = 8'd110;	wr = 1;	dr = 0;	end
	t11:			begin	dbi = 8'd116;	wr = 1;	dr = 0;	end
	r11, r21, r22, r31:	begin	dbi = 8'd114;	wr = 1;	dr = 0;	end
	espace21:		begin	dbi = 8'd32;	wr = 1;	dr = 0;	end
	d11:			begin	dbi = 8'd100;	wr = 1;	dr = 0;	end
	e21, e22:		begin	dbi = 8'd101;	wr = 1;	dr = 0;	end
	i21, i31:		begin	dbi = 8'd105;	wr = 1;	dr = 0;	end
	g21:			begin	dbi = 8'd103;	wr = 1;	dr = 0;	end
	s21, s22, s31:		begin	dbi = 8'd115;	wr = 1;	dr = 0;	end
	u21, u22, u31:		begin	dbi = 8'd117;	wr = 1;	dr = 0;	end
	E11:			begin	dbi = 8'd69;	wr = 1;	dr = 0;	end
	a11, a12, a21, a31:	begin	dbi = 8'd97;	wr = 1;	dr = 0;	end
	U31:			begin	dbi = 8'd85;	wr = 1;	dr = 0;	end
	I21:			begin	dbi = 8'd73;	wr = 1;	dr = 0;	end

	erase:
	begin
	    direc = 8'b00000001;
	    wr = 0;
	    dr = 1;
	end	

	endcase
	end

endmodule









	

	
	
