module mux(
	input [3:0] select,
	input [7:0] num1,
	input [7:0] num2,
	input [7:0] num3,
	input [7:0] addr3,
	input [7:0] addr4,
	input [7:0] addr5,
	input rd1,
	input rd2,
	input rd3,
	input wr_b,
	input dr_b,
	input wr_l,
	input dr_l,
	input wr_c,
	input dr_c,
	input [7:0] direc_l,
	input [7:0] db_l,
	input [7:0] direc_b,
	input [7:0] db_b,
	input [7:0] db_p,
	input [7:0] direc_p,
	input [7:0] db_c,
	input [7:0] direc_c,
	input [7:0] db_i,
	input [7:0] direc_i,
	input [7:0] db_entrada0,
	input [7:0] direc_entrada0,
	input [7:0] db_entrada1,
	input [7:0] direc_entrada1,
	input [7:0] db_salida0,
	input [7:0] direc_salida0,
	input [7:0] db_mensaje0,
	input [7:0] direc_mensaje0,
	input [7:0] db_mensaje1,
	input [7:0] direc_mensaje1,
	input [7:0] db_mensaje2,
	input [7:0] direc_mensaje2,
	input [7:0] db_m,
	input [7:0] direc_m,
	input wr_i,
	input dr_i,
	input wr_entrada0,
	input dr_entrada0,
	input wr_entrada1,
	input dr_entrada1,
	input wr_salida0,
	input dr_salida0,
	input wr_mensaje0,
	input dr_mensaje0,
	input wr_mensaje1,
	input dr_mensaje1,
	input wr_mensaje2,
	input dr_mensaje2,
	input wr_m,
	input dr_m,
	input wr_p,
	input dr_p,
	output reg [7:0] db,
	output reg [7:0] direc,
	output reg wr,
	output reg dr,
	output reg [7:0] addr,
	output reg [7:0] num,
	output reg rd
	);
	
	always@( * )
	begin
	
	case( select )

	    default:
	    begin
	        wr = wr_i;
		dr = dr_i;
		db = db_i;
		direc = direc_i;   
	    end
	    1:
	    begin
	        wr = wr_entrada0;
		dr = dr_entrada0;
		db = db_entrada0;
		direc = direc_entrada0;   
	    end
	    2:
	    begin
	        wr = wr_entrada1;
		dr = dr_entrada1;
		db = db_entrada1;
		direc = direc_entrada1;   
	    end
	    3:
	    begin
	        wr = wr_salida0;
		dr = dr_salida0;
		db = db_salida0;
		direc = direc_salida0;   
	    end
	    4:
	    begin
	        wr = wr_mensaje0;
		dr = dr_mensaje0;
		db = db_mensaje0;
		direc = direc_mensaje0;   
	    end
	    5:
	    begin
	        wr = wr_mensaje1;
		dr = dr_mensaje1;
		db = db_mensaje1;
		direc = direc_mensaje1;   
	    end
	    6:
	    begin
	        wr = wr_mensaje2;
		dr = dr_mensaje2;
		db = db_mensaje2;
		direc = direc_mensaje2;   
	    end
	    7:
	    begin
		wr = wr_m;
		dr = dr_m;
		db = db_m;
		direc = direc_m; 
	    end
	    8:
	    begin
		wr = wr_p;
		dr = dr_p;
		db = db_p;
		direc = direc_p; 
	    	rd = rd1;
		addr = addr3;
	        num = num1;
	    end	
	    9:
	    begin
		wr = wr_b;
		dr = dr_b;
		db = db_b;
		direc = direc_b; 
	    end
	    10:
	    begin
		wr = wr_l;
		dr = dr_l;
		db = db_l;
		direc = direc_l; 
		rd = rd2;
		addr = addr4;
		num = num2;
	    end
	    11:
	    begin
		wr = wr_c;
		dr = dr_c;
		db = db_c;
		direc = direc_c; 
		rd = rd3;
		addr = addr5;
		num = num3;
	    end
	
	endcase
	end

endmodule
