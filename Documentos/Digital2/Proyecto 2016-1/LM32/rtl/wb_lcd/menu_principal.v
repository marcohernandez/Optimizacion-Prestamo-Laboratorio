module menu_principal( 
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
	parameter o12 = 9;
	parameter l11 = 10;
	parameter espace11 = 11;
	parameter d11 = 12;
	parameter e11 = 13;
	parameter espace12 = 14;
	parameter i11 = 15;
	parameter n12 = 16;
	parameter g11 = 17;
	parameter r12 = 18;
	parameter e12 = 19;
	parameter s11 = 20;
	parameter o13 = 21;

	parameter dr3 = 22;	

	parameter uno11 = 23;	
	parameter punto11 = 24;

	parameter E21 = 25;
	parameter n21 = 26;
	parameter t21 = 27;
	parameter r21 = 28;
	parameter a21 = 29;
	parameter d21 = 30;
	parameter a22 = 31;

	parameter dr4 = 32;
	
	parameter dos21 = 33;
	parameter punto21 = 34;

	parameter S31 = 35;
	parameter a31 = 36;
	parameter l31 = 37;
	parameter i31 = 38;
	parameter d31 = 39;
	parameter a32 = 40;

	parameter erase = 41;
			
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

	else if( estado == a32) nestado = stay;

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
	    direc = 8'b10000001;
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

	C11:			begin	dbi = 8'd67;	wr = 1;	dr = 0;	end
	o11, o12, o13:		begin	dbi = 8'd111;	wr = 1;	dr = 0;	end
	n11, n12, n21:		begin	dbi = 8'd110;	wr = 1;	dr = 0;	end
	t11, t21:		begin	dbi = 8'd116;	wr = 1;	dr = 0;	end
	r11, r12, r21:		begin	dbi = 8'd114;	wr = 1;	dr = 0;	end
	l11, l31:		begin	dbi = 8'd108;	wr = 1;	dr = 0;	end
	espace11, espace12:	begin	dbi = 8'd32;	wr = 1;	dr = 0;	end
	d11, d21, d31:		begin	dbi = 8'd100;	wr = 1;	dr = 0;	end
	e11, e12:		begin	dbi = 8'd101;	wr = 1;	dr = 0;	end
	i11, i31:		begin	dbi = 8'd105;	wr = 1;	dr = 0;	end
	g11:			begin	dbi = 8'd103;	wr = 1;	dr = 0;	end
	s11:			begin	dbi = 8'd115;	wr = 1;	dr = 0;	end
	uno11:			begin	dbi = 8'd49;	wr = 1;	dr = 0;	end
	punto11, punto21:	begin	dbi = 8'd46;	wr = 1;	dr = 0;	end
	E21:			begin	dbi = 8'd69;	wr = 1;	dr = 0;	end
	a21, a22, a31, a32:	begin	dbi = 8'd97;	wr = 1;	dr = 0;	end
	dos21:			begin	dbi = 8'd50;	wr = 1;	dr = 0;	end
	S31:			begin	dbi = 8'd83;	wr = 1;	dr = 0;	end

	erase:
	begin
	    direc = 8'b00000001;
	    wr = 0;
	    dr = 1;
	end	

	endcase
	end

endmodule









	

	
	
