module dmux(
	input [3:0] select,
	input wrmenu,
	input down,
	input up,
	output reg init_menu,
	output reg init_down,
	output reg init_up,
	output reg entrada0_menu,
	output reg entrada0_down,
	output reg entrada0_up,
	output reg entrada1_menu,
	output reg entrada1_down,
	output reg entrada1_up,
	output reg salida0_menu,
	output reg salida0_down,
	output reg salida0_up,
	output reg mensaje0_menu,
	output reg mensaje0_down,
	output reg mensaje0_up,
	output reg mensaje1_menu,
	output reg mensaje1_down,
	output reg mensaje1_up,
	output reg mensaje2_menu,
	output reg mensaje2_down,
	output reg mensaje2_up,
	output reg modul_menu,
	output reg modul_down,
	output reg modul_up,
	output reg wram,
	output reg produc_menu,
	output reg lista_menu,
	output reg lista_down,
	output reg lista_up,
	output reg compras_menu,
	output reg compras_down,
	output reg compras_up
	);
	
	always@( * )
	begin
	
	case( select )

	    default:
	    begin
		init_menu = wrmenu;
		init_down = down;
	        init_up = up;
	    end
	    1:
	    begin
		entrada0_menu = wrmenu;
		entrada0_down = down;
	        entrada0_up = up;
	    end
	    2:
	    begin
		entrada1_menu = wrmenu;
		entrada1_down = down;
	        entrada1_up = up;
	    end
	    3:
	    begin
		salida0_menu = wrmenu;
		salida0_down = down;
	        salida0_up = up;
	    end
	    4:
	    begin
		mensaje0_menu = wrmenu;
		mensaje0_down = down;
	        mensaje0_up = up;
	    end
	    5:
	    begin
		mensaje1_menu = wrmenu;
		mensaje1_down = down;
	        mensaje1_up = up;
	    end
	    6:
	    begin
		mensaje2_menu = wrmenu;
		mensaje2_down = down;
	        mensaje2_up = up;
	    end
	    7:
	    begin
		modul_menu = wrmenu;
		modul_down = down;
	        modul_up = up;
	    end
	    8:
	    begin
		wram = wrmenu;
		produc_menu = up;
	    end
	    9:
	    begin
		lista_menu = wrmenu;
		lista_down = down;
	        lista_up = up;
	    end
	    10:
	    begin
		compras_menu = wrmenu;
		compras_down = down;
	        compras_up = up;
	    end
	endcase
	end

endmodule
