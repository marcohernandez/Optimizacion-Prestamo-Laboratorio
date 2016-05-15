module fsm(
	input wr,
	input dr,
	input init,
	input clk2,
	input clk_10m,
	input rst,
	input [7:0] dbi,
	input [7:0] direc,
	output reg [7:0] db,
	output reg rs,
	output reg e
	);

	reg[4:0] estado = 0;
	reg[4:0] nestado = 0;
	parameter base = 4'b0000; //0
	parameter activation = 4'b0001; //1
	parameter enable1 = 4'b0010; //2
	parameter mode = 4'b0011; //3
	parameter enable2 = 4'b0100; //4
	parameter erase = 4'b0101; //5
	parameter enable3 = 4'b0110; //6
	parameter initfinish = 4'b0111; //7
	parameter write = 4'b1000; //8
	parameter enable4 = 4'b1001; //9
	parameter direction = 4'b1010; //10
	parameter enabledirec = 4'b1011; //11
	
	always@( posedge clk_10m ) //Logica de estado siguiente
	begin	
	case( estado )
	
	base:
	begin
	if( init ) nestado = activation;
	else if( wr ) 
	begin	
   		nestado = write;
	end
	else if( dr ) nestado = direction;
	else nestado = base;
	end

	activation: nestado = enable1;

	enable1: nestado = mode;

	mode: nestado = enable2;

	enable2: nestado = erase;

	erase: nestado = enable3;

	enable3: nestado = base;

	write: nestado = enable4;

	enable4: nestado = base;

	direction: nestado = enabledirec;

	enabledirec: nestado = base;

	endcase	
	end 

	always@( posedge clk2 ) //Reset opcional, Actualizacion de estados
	begin
	
	if( rst ) estado = base;
	else estado = nestado;

	end

	always@( estado ) //Memoria de estados
	begin
	
	case( estado )
	
	base: 
	begin
	    db = 8'b00000000;
	    rs = 0;
	    e = 0;
	end	

	activation: 
	begin
	    db = 8'b00111000;
	    rs = 0;
	    e = 1;
	end	

	enable1: 
	begin
	    rs = 0;
	    e = 0;
	end	  

	mode: 
	begin
	    db = 8'b00001100;
	    rs = 0;
	    e = 1;
	end	 

	enable2: 
	begin
	    rs = 0;
	    e = 0;
	end	

	erase: 
	begin
	    db = 8'b00000001;
	    rs = 0;
	    e = 1;
	end	

	enable3: 
	begin
	    rs = 0;
	    e = 0;
	end

	write:
	begin
	    e = 1;
	    rs = 1;
	    db = dbi;
	end
	
	enable4:
	begin
	    e = 0;
	    rs = 1;
	end

	direction:
	begin
	    e = 1;
	    rs = 0;
	    db = direc;
	end

	enabledirec:
	begin
	    e = 0;
	    rs = 0;
	end	    

	endcase
	end	

endmodule

