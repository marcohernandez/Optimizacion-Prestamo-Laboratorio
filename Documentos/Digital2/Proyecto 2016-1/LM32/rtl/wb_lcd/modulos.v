module modulos( 
	input rst,
	input clk2,
	input clk_20m,
	input wrmenu,
	input down,
	input up,
	output reg[7:0] dbi_m,
	output reg wr_m,
	output reg dr_m,
	output reg [7:0] direc_m
	);

	initial wr_m = 0;
	reg [1:0] pag = 0;
	reg [6:0] estado = 0;
	reg [6:0] nestado = 0;
	parameter stay = 0;
	parameter dr1 = 1;
	parameter dr10 = 2;
	parameter dr11 = 3;
	parameter h = 4;
	parameter o = 5;
	parameter r = 6;
	parameter a = 7;
	parameter r2 = 8;
	parameter i = 9;
	parameter o2 = 10;	
	parameter dr2 = 11;// Aseo
	parameter dr5 = 12;
	parameter uno = 13;	
	parameter punto = 14;
	parameter l = 15;
	parameter u = 16;
	parameter n = 17;
	parameter e = 18;
	parameter s = 19;	
	parameter espace = 20;
	parameter espace2 = 21;
	parameter espace3 = 22;
	parameter dr3 = 23; //Ropa
	parameter dr7 = 24;
	parameter dos = 25;
	parameter punto2 = 26;
	parameter m = 27;
	parameter a2 = 28;
	parameter r3 = 29;
	parameter t = 30;
	parameter e2 = 31;
	parameter s2 = 32;
	parameter espace4 = 33;
	parameter espace5 = 34;	
	parameter dr4 = 35;//salud
	parameter dr8 = 36;
	parameter tres = 37;
	parameter punto3 = 38;
	parameter m2 = 39;
	parameter i2 = 40;
	parameter e3 = 41;
	parameter r4 = 42;
	parameter c = 43;
	parameter o3 = 44;
	parameter l2 = 45;
	parameter e4 = 46;
	parameter s3 = 47;
	parameter dr6 = 48;
	parameter cuatro = 49; //Hogar
	parameter punto4 = 50;
	parameter j = 51;
	parameter u2 = 52;
	parameter e5 = 53;
	parameter v = 54;
	parameter e6 = 55;
	parameter s4 = 56;
	parameter espace6 = 57;
	parameter espace7 = 58;
	parameter espace8 = 59;
	parameter espace9 = 60;
	parameter erase = 61;
	parameter erase2 = 62;
	
	always@( negedge clk_20m ) //Logica de estado siguiente
	begin
	
	if( estado == stay)
	begin
	    if( wrmenu || up)
	    begin
	        nestado = erase;
		pag = 1;
	    end
	    else if( down ) 
	    begin		
		nestado = erase2;
		pag = 2;
	    end
	    else
	    begin
		nestado = stay;
	    end
	end 

	else if( estado == erase ) nestado = dr1;

	else if( estado == erase2 ) nestado = s;	

	else if( estado == s3 && pag == 1 ) nestado = stay;

	else if( estado == espace9 && pag == 2 ) nestado = stay;

	else
	begin
	    if( pag == 1 && (estado == dr2 || estado == dr3 || estado == dr4) )
	    begin
                nestado = nestado + 2;
	    end
	    else
	    begin
		nestado = nestado + 1;
	    end 	
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
	    wr_m = 0;
	    dr_m = 0;
	end

	dr1, dr10, dr11:
	begin
	    direc_m = 8'b10000110;
	    wr_m = 0;
	    dr_m = 1;
	end

	dr2, dr7:
	begin
	    direc_m = 8'b11000100;
	    wr_m = 0;
	    dr_m = 1;
	end

	dr3, dr8:
	begin
	    direc_m = 8'b10011000;
	    wr_m = 0;
	    dr_m = 1;
	end	

	dr4, dr6:
	begin
	    direc_m = 8'b11011000;
	    wr_m = 0;
	    dr_m = 1;
	end	
		
	dr5:
	begin
	    direc_m = 8'b10000100;
	    wr_m = 0;
	    dr_m = 1;
	    
	end

	h :
	begin
	    dbi_m = 8'b01001000;
	    wr_m = 1;
	    dr_m = 0;
	end

	o, o2, o3:
	begin
	    dbi_m = 8'b01101111;
	    dr_m = 0;
	    wr_m = 1;
	end

	r, r2, r3, r4:
	begin
	    dbi_m = 8'b01110010;
	    dr_m = 0;
	    wr_m = 1;
	end

	a, a2:
	begin
	    dbi_m = 8'b01100001;
	    dr_m = 0;
	    wr_m = 1;
	end

	i, i2:
	begin
	    dbi_m = 8'b01101001;
	    dr_m = 0;
	    wr_m = 1;
	end

	l:
	begin
	    dbi_m = 8'b01001100;
	    dr_m = 0;
	    wr_m = 1;
	end

	u, u2:
	begin
	    dbi_m = 8'b01110101;
	    dr_m = 0;
	    wr_m = 1;
	end

	n:
	begin
	    dbi_m = 8'b01101110;
	    dr_m = 0;
	    wr_m = 1;
	end

	e, e2, e3, e4, e5, e6:
	begin
	    dbi_m = 8'b01100101;
	    dr_m = 0;
	    wr_m = 1;
	end

	s, s2, s3, s4:
	begin
	    dbi_m = 8'b01110011;
	    dr_m = 0;
	    wr_m = 1;
	end

	m, m2:
	begin
	    dbi_m = 8'b01001101;
	    dr_m = 0;
	    wr_m = 1;
	end

	t:
	begin
	    dbi_m = 8'b01110100;
	    dr_m = 0;
	    wr_m = 1;
	end

	c:
	begin
	    dbi_m = 8'b01100011;
	    dr_m = 0;
	    wr_m = 1;
	end

	l2:
	begin
	    dbi_m = 8'b01101100;
	    dr_m = 0;
	    wr_m = 1;
	end

	j:
	begin
	    dbi_m = 8'b01001010;
	    dr_m = 0;
	    wr_m = 1;
	end

	v:
	begin
	    dbi_m = 8'b01110110;
	    dr_m = 0;
	    wr_m = 1;
	end

	uno:
	begin
	    dbi_m = 8'b00110001;
	    dr_m = 0;
	    wr_m = 1;
	end

	dos:
	begin
	    dbi_m = 8'b00110010;
	    dr_m = 0;
	    wr_m = 1;
	end

	punto, punto2, punto3, punto4:
	begin
	    dbi_m = 8'b00101110;
	    dr_m = 0;
	    wr_m = 1;
	end

	espace, espace2, espace3, espace4, espace5, espace6, espace7, espace8, espace9:
	begin
	    dbi_m = 8'b00100000;
	    dr_m = 0;
	    wr_m = 1;
	end

	tres:
	begin
	    dbi_m = 8'b00110011;
	    dr_m = 0;
	    wr_m = 1;
	end

	erase, erase2:
	begin
	    direc_m = 8'b00000001;
	    wr_m = 0;
	    dr_m = 1;
	end	

	cuatro:
	begin
	    dbi_m = 8'b00110100;
	    dr_m = 0;
	    wr_m = 1;
	end

	endcase
	end

endmodule
