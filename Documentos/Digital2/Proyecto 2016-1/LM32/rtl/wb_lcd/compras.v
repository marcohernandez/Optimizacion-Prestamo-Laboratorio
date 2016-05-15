module compras(
	input lista_down,
	input lista_up,
	input rst,
	input clk2,
	input clk_20m,
	input wr_l,
	input [7:0] enco1,
	input [7:0] enco2,
	input [7:0] enco3,
	input [7:0] dbout1,
	output reg [7:0] db,
	output reg [7:0] addr2,
	output reg [7:0] direc,
	output reg wr,
	output reg dr,
	output reg rd2,
	output reg [7:0] num
	);

	reg [7:0] pos = 76;
	reg [6:0] estado = 0;
	reg [6:0] nestado = 0;
	reg [7:0] dbout = 0;
	parameter stay = 0;
	parameter erase = 1;
	parameter dr1 = 4;
	parameter ll = 5;
	parameter i = 6;
	parameter s = 7;
	parameter t = 8;
	parameter a = 9;	
	parameter espace = 10;
	parameter d = 11;
	parameter e = 12;
	parameter espace2 = 13;
	parameter c = 14;
	parameter o = 15;
	parameter m = 16;
	parameter p = 17;
	parameter r = 18;
	parameter a2 = 19;
	parameter s2 = 20;
	parameter dr2 = 21; //producto 1
	parameter read = 22;
	parameter l1 = 23;
	parameter read2 = 24; 
	parameter l2 = 25;
	parameter read3 = 26;
	parameter l3 = 27;
	parameter read4 = 28;
	parameter l4 = 29;
	parameter read5 = 30;
	parameter l5 = 31;
	parameter read6 = 32;
	parameter l6 = 33;
	parameter dr3 = 34;
	parameter p2 = 35;
	parameter read7 = 36;
	parameter pasillo1 = 37;
	parameter pasillo2 = 38;
	parameter pasillo3 = 39;
	parameter dr4 = 40; //producto 2
	parameter read8 = 41;
	parameter l12 = 42;
	parameter read9 = 43; 
	parameter l22 = 44;
	parameter read10 = 45;
	parameter l32 = 46;
	parameter read11 = 47;
	parameter l42 = 48;
	parameter read12 = 49;
	parameter l52 = 50;
	parameter read13 = 51;
	parameter l62 = 52;
	parameter dr5 = 53;
	parameter p22 = 54;
	parameter read14 = 55;
	parameter pasillo12 = 56;
	parameter pasillo22 = 57;
	parameter pasillo32 = 58;
	parameter dr6 = 59; //producto 3
	parameter read15 = 60;
	parameter l13 = 61;
	parameter read16 = 62; 
	parameter l23 = 63;
	parameter read17 = 64;
	parameter l33 = 65;
	parameter read18 = 66;
	parameter l43 = 67;
	parameter read19 = 68;
	parameter l53 = 69;
	parameter read20 = 70;
	parameter l63 = 71;
	parameter dr7 = 72;
	parameter p23 = 73;
	parameter read21 = 74;
	parameter pasillo13 = 75;
	parameter pasillo23 = 76;
	parameter pasillo33 = 77;
	parameter aumentar = 78;
	parameter disminuir = 79;

	always@( negedge clk_20m ) //Logica de estado siguiente
	begin
	
	if( estado == stay)
	begin
	    if( wr_l )
	    begin
	        nestado = erase;
	    end
	    else if( lista_down ) nestado = aumentar;
	    else if( lista_up ) nestado = disminuir;
	    else
	    begin
		nestado = stay;
	    end
	end
	else if( estado == aumentar || estado == disminuir) nestado = erase;
	else if( estado == l63 ) nestado = stay;
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
	
	aumentar:
	begin 
	    if( pos == 76 ) pos = 86;
	    else if( pos == 86 ) pos = 96;
	    else if( pos == 96 ) pos = 106;
	end

	disminuir:
	begin 
	    
	    if( pos == 106 ) pos = 96;
	    else if( pos == 96 ) pos = 86;
	    else if( pos == 86 ) pos = 76;
	end

	stay:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 0;
	end

	dr1:
	begin
	    direc = 8'b10000010;
	    wr = 0;
	    dr = 1;
	end

	dr2:
	begin
	    direc = 8'b11000011;
	    wr = 0;
	    dr = 1;
	end

	dr3:
	begin
	    direc = 8'b11001110;
	    wr = 0;
	    dr = 1;
	end

	dr4:
	begin
	    direc = 8'b10010111;
	    wr = 0;
	    dr = 1;
	end

	dr5:
	begin
	    direc = 8'b10100010;
	    wr = 0;
	    dr = 1;
	end

	dr6:
	begin
	    direc = 8'b11010111;
	    wr = 0;
	    dr = 1;
	end

	dr7:
	begin
	    direc = 8'b11100010;
	    wr = 0;
	    dr = 1;
	end

	read:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos;
	    dbout = dbout1;
	end

	read2:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 1;
	    dbout = dbout1;
	end

	read3:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 2;
	    dbout = dbout1;
	end

	read4:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 3;
	    dbout = dbout1;
	end

	read5:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 4;
	    dbout = dbout1;
	end

	read6:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 5;
	    dbout = dbout1;
	end

	read7:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 7;
	    num = dbout1;
	end

	read8:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 10;
	    dbout = dbout1;
	end

	read9:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 11;
	    dbout = dbout1;
	end

	read10:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 12;
	    dbout = dbout1;
	end

	read11:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 13;
	    dbout = dbout1;
	end

	read12:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 14;
	    dbout = dbout1;
	end

	read13:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 15;
	    dbout = dbout1;
	end

	read14:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 17;
	    num = dbout1;
	end

	read15:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 20;
	    dbout = dbout1;
	end

	read16:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 21;
	    dbout = dbout1;
	end

	read17:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 22;
	    dbout = dbout1;
	end

	read18:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 23;
	    dbout = dbout1;
	end

	read19:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 24;
	    dbout = dbout1;
	end

	read20:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 25;
	    dbout = dbout1;
	end

	read21:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 1;
	    addr2 = pos + 27;
	    num = dbout1;
	end

	l1, l2, l3, l4, l5, l6, l12, l22, l32, l42, l52, l62, l13, l23, l33, l43, l53, l63:
	begin
	    
	    db = dbout;
	    wr = 1;
	    dr = 0;
	end
	
	ll:
	begin
	    db = 8'b01001100;
	    dr = 0;
	    wr = 1;
	end

	s, s2:
	begin
	    db = 8'b01110011;
	    dr = 0;
	    wr = 1;
	end

	i:
	begin
	    db = 8'b01101001;
	    dr = 0;
	    wr = 1;
	end

	t:
	begin
	    db = 8'b01110100;
	    dr = 0;
	    wr = 1;
	end

	a, a2:
	begin
	    db = 8'b01100001;
	    dr = 0;
	    wr = 1;
	end	

	p:
	begin
	    db = 8'b01110000;
	    dr = 0;
	    wr = 1;
	end

	d:
	begin
	    db = 8'b01100100;
	    dr = 0;
	    wr = 1;
	end

	c:
	begin
	    db = 8'b01100011;
	    dr = 0;
	    wr = 1;
	end

	m:
	begin
	    db = 8'b01101101;
	    dr = 0;
	    wr = 1;
	end

	p2, p22, p23:
	begin
	    db = 8'b01010000;
	    dr = 0;
	    wr = 1;
	end

	r:
	begin
	    db = 8'b01110010;
	    dr = 0;
	    wr = 1;
	end

	espace, espace2:
	begin
	    db = 8'b00100000;
	    dr = 0;
	    wr = 1;
	end

	e:
	begin
	    db = 8'b01100101;
	    wr = 1;
	end

	o:
	begin
	    db = 8'b01101111;
	    wr = 1;
	end

	erase:
	begin
	    direc = 8'b00000001;
	    wr = 0;
	    dr = 1;
	end

	pasillo1, pasillo12, pasillo13:
	begin
	    if( enco1 == 48 ) wr = 0;
	    else
	    begin
		db = enco1;
		wr = 1;
		dr = 0;
	    end
	    
	end

	pasillo2, pasillo22, pasillo23:
	begin
	    if( enco1 == 48 && enco2 == 48 ) wr = 0;
	    else
	    begin 
	        db = enco2;
	        wr = 1;
	        dr = 0;
	    end	
	end

	pasillo3, pasillo32, pasillo33:
	begin
	    db = enco3;
	    wr = 1;
	    dr = 0;
	end

	endcase
	end
endmodule
 
