module lista(
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

	reg [7:0] pos = 14;
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
	parameter p = 11;
	parameter r = 12;
	parameter e = 13;
	parameter v = 14;
	parameter i2 = 15;
	parameter a2 = 16;
	parameter dr2 = 17; //producto 1
	parameter read = 18;
	parameter l1 = 19;
	parameter read2 = 20; 
	parameter l2 = 21;
	parameter read3 = 22;
	parameter l3 = 23;
	parameter read4 = 24;
	parameter l4 = 25;
	parameter read5 = 26;
	parameter l5 = 27;
	parameter read6 = 28;
	parameter l6 = 29;
	parameter dr3 = 30;
	parameter p2 = 31;
	parameter read7 = 32;
	parameter pasillo1 = 33;
	parameter pasillo2 = 34;
	parameter pasillo3 = 35;
	parameter dr4 = 36; //producto 2
	parameter read8 = 37;
	parameter l12 = 38;
	parameter read9 = 39; 
	parameter l22 = 40;
	parameter read10 = 41;
	parameter l32 = 42;
	parameter read11 = 43;
	parameter l42 = 44;
	parameter read12 = 45;
	parameter l52 = 46;
	parameter read13 = 47;
	parameter l62 = 48;
	parameter dr5 = 49;
	parameter p22 = 50;
	parameter read14 = 51;
	parameter pasillo12 = 52;
	parameter pasillo22 = 53;
	parameter pasillo32 = 54;
	parameter dr6 = 55; //producto 3
	parameter read15 = 56;
	parameter l13 = 57;
	parameter read16 = 58; 
	parameter l23 = 59;
	parameter read17 = 60;
	parameter l33 = 61;
	parameter read18 = 62;
	parameter l43 = 63;
	parameter read19 = 64;
	parameter l53 = 65;
	parameter read20 = 66;
	parameter l63 = 67;
	parameter dr7 = 68;
	parameter p23 = 69;
	parameter read21 = 70;
	parameter pasillo13 = 71;
	parameter pasillo23 = 72;
	parameter pasillo33 = 73;
	parameter aumentar = 74;
	parameter disminuir = 75;

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
	else if( estado == pasillo33 ) nestado = stay;
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
	    if( pos == 14 ) pos = 24;
	    else if( pos == 24 ) pos = 34;
	    else if( pos == 34 ) pos = 44;
	end

	disminuir:
	begin 
	    
	    if( pos == 44 ) pos = 34;
	    else if( pos == 34 ) pos = 24;
	    else if( pos == 24 ) pos = 14;
	end

	stay:
	begin 
	    wr = 0;
	    dr = 0;
	    rd2 = 0;
	end

	dr1:
	begin
	    direc = 8'b10000100;
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

	s:
	begin
	    db = 8'b01110011;
	    dr = 0;
	    wr = 1;
	end

	i, i2:
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

	v:
	begin
	    db = 8'b01110110;
	    dr = 0;
	    wr = 1;
	end

	espace:
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

