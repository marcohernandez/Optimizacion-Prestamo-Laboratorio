module wrram(
	input rst,
	input clk2,
	input wr,
	output reg wr1,
	output reg [7:0] dbi1,
	output reg [7:0] addr1,
	output reg led
	);

	initial led = 0;
	reg [3:0] estado = 0;
	reg [3:0] nestado = 0;
	parameter stay = 0;
	parameter precio = 1;
	parameter cod = 2;
	parameter l1 = 3;
	parameter l2 = 4;
	parameter l3 = 5;
	parameter l4 = 6;
	parameter l5 = 7;
	parameter l6 = 8;
	parameter oferta = 9;
	parameter pasillo = 10;

	always@( negedge clk2 )
	begin
	if( estado == stay )
	begin
	    if( wr ) nestado = nestado + 4'd1;
	    else nestado = stay;
	end
	else if( estado == pasillo ) nestado = stay;
	else nestado = nestado + 4'd1;
	end

	always@( posedge clk2 ) //Reset opcional, Actualizacion de estados
	begin

	if( rst ) estado = stay;
	else estado = nestado;

	end

	always@( estado )
	begin
	case( estado )
	stay: wr1 = 0;
	precio:
	begin
	    wr1 = 1;
	    addr1 = 8'h00;
	    dbi1 = 8'b00001000;
	end
	cod:
	begin
	    wr1 = 1;
	    addr1 = 8'h01;
	    dbi1 = 8'b00000000;
	end
	l1:
	begin
	    wr1 = 1;
	    addr1 = 8'h02;
	    dbi1 = 8'b01001010;
	end
	l2:
	begin
	    wr1 = 1;
	    addr1 = 8'h03;
	    dbi1 = 8'b01100001;
	    led = 1;
	end
	l3:
	begin
	    wr1 = 1;
	    addr1 = 8'h04;
	    dbi1 = 8'b01100010;
	end
	l4:
	begin
	    wr1 = 1;
	    addr1 = 8'h05;
	    dbi1 = 8'b01101111;
	end
	l5:
	begin
	    wr1 = 1;
	    addr1 = 8'h06;
	    dbi1 = 8'b01101110;
	end
	l6:
	begin
	    wr1 = 1;
	    addr1 = 8'h07;
	    dbi1 = 8'b00100000;
	end
	oferta:
	begin
	    wr1 = 1;
	    addr1 = 8'h08;
	    dbi1 = 8'b00100100;
	end
	pasillo:
	begin
	    wr1 = 1;
	    addr1 = 8'h09;
	    dbi1 = 8'b00000100;
	end
	endcase
	end

endmodule
	   
  
	
	    
