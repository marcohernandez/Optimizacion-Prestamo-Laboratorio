module rdram(
	input rst,
	input clk2,
	input clk_20m,
	input wr_p,
	input [7:0] enco1,
	input [7:0] enco2,
	input [7:0] enco3,
	input [7:0] dbout1,
	output reg [7:0] db,
	output reg [7:0] addr2,
	output reg [7:0] direc,
	output reg wr,
	output reg dr,
	output reg rd1,
	output reg [7:0] num
	);

	reg [6:0] estado = 0;
	reg [6:0] nestado = 0;
	reg [7:0] dbout = 0;
	//reg [9:0] addr = 0;
	parameter stay = 0;
	parameter erase = 1;
	parameter dr1 = 4;
	parameter peso = 5;
	parameter read = 6;	
	parameter precio1 = 7;
	parameter precio2 = 8;
	parameter precio3 = 9;
	parameter mil = 10;
	parameter mil2 = 11;
	parameter mil3 = 12;
	parameter dr2 = 13;
	parameter read2 = 14;
	parameter l1 = 15;
	parameter read3 = 16; 
	parameter l2 = 17;
	parameter read4 = 18;
	parameter l3 = 19;
	parameter read5 = 20;
	parameter l4 = 21;
	parameter read6 = 22;
	parameter l5 = 23;
	parameter read7 = 24;
	parameter l6 = 25;
	parameter dr3 = 26; //pasillo
	parameter p = 27;
	parameter a = 28;
	parameter s = 29;
	parameter i = 30;
	parameter l = 31;
	parameter ll2 = 32;
	parameter o = 33;
	parameter dospuntos = 34;
	parameter read8 = 35;
	parameter pasillo1 = 36;
	parameter pasillo2 = 37;
	parameter pasillo3 = 38;
	parameter dr4 = 39; //Oferta
	parameter o2 = 40;
	parameter f = 41;
	parameter e = 42;
	parameter r = 43;
	parameter t = 44;
	parameter a2 = 45;
	parameter dospuntos2 = 46;
	parameter read9 = 47;
	parameter oferta1 = 48;
	parameter oferta2 = 49;
	parameter oferta3 = 50;
	parameter por = 51;
	parameter dr5 = 52; // opcion
	parameter A = 53;
	parameter sep = 54;
	parameter uno = 55;
	parameter espace = 56;
	parameter D = 57;
	parameter sep2 = 58;
	parameter dos = 59;
	parameter dr6 = 60; //suma
	parameter s2 = 61;
	parameter u = 62;
	parameter m = 63;
	parameter dospuntos3 = 64;
	parameter peso2 = 65;
	parameter read10 = 66;
	parameter suma1 = 67;
	parameter suma2 = 68;
	parameter suma3 = 69;
	parameter mil4 = 70;
	parameter mil5 = 71;
	parameter mil6 = 72;
	/*parameter a = 33;
	parameter g = 34;
	parameter r = 35;
	parameter e = 36;
	parameter g = 37;*/
	 
	
	/*parameter l1 = 4;
	parameter dr3 = 5;
	parameter l2 = 6;
	parameter dr4 = 7;
	parameter l3 = 8;
	parameter dr5 = 9;
	parameter l4 = 10;
	parameter dr6 = 11;
	parameter l5 = 12;
	parameter dr7 = 13;
	parameter l6 = 14;
	parameter dr8 = 15;
	parameter oferta = 16;
	parameter dr9 = 17;
	parameter pasillo = 18;
	parameter stay = 0;
	parameter write = 1;
	parameter dr1 = 2;*/

	always@( negedge clk_20m ) //Logica de estado siguiente
	begin

	if( estado == stay)
	begin
	    if( wr_p )
	    begin
	        nestado = erase;
	    end
	    else
	    begin
		nestado = stay;
	    end
	end
	else if( estado == mil6 ) nestado = stay;
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
	    rd1 = 0;
	end

	erase:
	begin
	    direc = 8'b00000001;
	    wr = 0;
	    dr = 1;
	end

	dr1:
	begin
	    direc = 8'b11000001;
	    wr = 0;
	    dr = 1;
	end

	dr2:
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

	dr5:
	begin
	    direc = 8'b11100001;
	    wr = 0;
	    dr = 1;
	end
	
	dr6:
	begin
	    direc = 8'b11001001;
	    wr = 0;
	    dr = 1;
	end

	read:
	begin 
	    wr = 0;
	    dr = 0;
	    rd1 = 1;
	    addr2 = 8'h00;
	    num = dbout1;
	end

	read2:
	begin 
	    wr = 0;
	    dr = 0;
	    rd1 = 1;
	    addr2 = 8'h02;
	    dbout = dbout1;
	end

	read3:
	begin 
	    wr = 0;
	    dr = 0;
	    rd1 = 1;
	    addr2 = 8'h03;
	    dbout = dbout1;
	end

	read4:
	begin 
	    wr = 0;
	    dr = 0;
	    rd1 = 1;
	    addr2 = 8'h04;
	    dbout = dbout1;
	end

	read5:
	begin 
	    wr = 0;
	    dr = 0;
	    rd1 = 1;
	    addr2 = 8'h05;
	    dbout = dbout1;
	end

	read6:
	begin 
	    wr = 0;
	    dr = 0;
	    rd1 = 1;
	    addr2 = 8'h06;
	    dbout = dbout1;
	end

	read7:
	begin 
	    wr = 0;
	    dr = 0;
	    rd1 = 1;
	    addr2 = 8'h07;
	    dbout = dbout1;
	end

	read8:
	begin 
	    wr = 0;
	    dr = 0;
	    rd1 = 1;
	    addr2 = 8'h09;
	    num = dbout1;
	end

	read9:
	begin 
	    wr = 0;
	    dr = 0;
	    rd1 = 1;
	    addr2 = 8'h08;
	    num = dbout1;
	end

	read10:
	begin 
	    wr = 0;
	    dr = 0;
	    rd1 = 1;
	    addr2 = 8'h88;
	    num = dbout1;
	end

	peso, peso2:
	begin
	    db = 8'b00100100;
	    wr = 1;
	    dr = 0;
	end

	precio1, pasillo1, oferta1, suma1:
	begin
	    if( enco1 == 48 ) wr = 0;
	    else
	    begin
		db = enco1;
		wr = 1;
		dr = 0;
	    end
	    
	end

	precio2, pasillo2, oferta2, suma2:
	begin
	    if( enco1 == 48 && enco2 == 48 ) wr = 0;
	    else
	    begin 
	        db = enco2;
	        wr = 1;
	        dr = 0;
	    end	
	end

	precio3, pasillo3, oferta3, suma3:
	begin
	    db = enco3;
	    wr = 1;
	    dr = 0;
	end

	mil, mil2, mil3, mil4, mil5, mil6:
	begin
	    db = 8'b00110000;
	    wr = 1;
	    dr = 0;
	end

	l1, l2, l3, l4, l5, l6:
	begin
	    
	    db = dbout;
	    wr = 1;
	    dr = 0;
	end

	p:
	begin
	    db = 8'b01110000;
	    dr = 0;
	    wr = 1;
	end

	a, a2:
	begin
	    db = 8'b01100001;
	    dr = 0;
	    wr = 1;
	end

	i:
	begin
	    db = 8'b01101001;
	    dr = 0;
	    wr = 1;
	end

	l, ll2:
	begin
	    db = 8'b01101100;
	    dr = 0;
	    wr = 1;
	end

	o, o2:
	begin
	    db = 8'b01101111;
	    dr = 0;
	    wr = 1;
	end

	s:
	begin
	    db = 8'b01110011;
	    dr = 0;
	    wr = 1;
	end

	s2:
	begin
	    db = 8'b01010011;
	    dr = 0;
	    wr = 1;
	end


	dospuntos, dospuntos2, dospuntos3:
	begin
	    db = 8'b00111010;
	    dr = 0;
	    wr = 1;
	end

	f:
	begin
	    db = 8'b01100110;
	    dr = 0;
	    wr = 1;
	end

	uno:
	begin
	    db = 8'b00110001;
	    dr = 0;
	    wr = 1;
	end

	dos:
	begin
	    db = 8'b00110010;
	    dr = 0;
	    wr = 1;
	end

	e:
	begin
	    db = 8'b01100101;
	    wr = 1;
	end

	r:
	begin
	    db = 8'b01110010;
	    dr = 0;
	    wr = 1;
	end

	t:
	begin
	    db = 8'b01110100;
	    dr = 0;
	    wr = 1;
	end

	espace:
	begin
	    db = 8'b00100000;
	    dr = 0;
	    wr = 1;
	end

	sep, sep2:
	begin
	    db = 8'b00101101;
	    dr = 0;
	    wr = 1;
	end

	A:
	begin
	    db = 8'b01000001;
	    dr = 0;
	    wr = 1;
	end

	D:
	begin
	    db = 8'b01000100;
	    dr = 0;
	    wr = 1;
	end

	por:
	begin
	    db = 8'b00100101;
	    dr = 0;
	    wr = 1;
	end	

	m:
	begin
	    db = 8'b01101101;
	    wr = 1;
	    dr = 0;
	end
	
	u:
	begin
	    db = 8'b01110101;
	    wr = 1;
	end	
	
	endcase

	end

endmodule
	

	
	
