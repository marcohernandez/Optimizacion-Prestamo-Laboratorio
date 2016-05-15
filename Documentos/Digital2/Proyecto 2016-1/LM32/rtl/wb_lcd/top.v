module top(
	input clk,
	input pul1,
	input pul2,
	input wrmenu,
	input init,
	input rst,
	input [3:0] select,
	input [1:0] carga,
	output [7:0] db,
	output led,
	output led2,
	output led3,
	output rs,
	output e
	);

//----------------------------
//----- buffer ---------------



//----------------------------
//----- prescaler ------------

	wire clk2;
	wire clk_10m;
	wire clk_20m;

//----------------------------
//----- antirrebote ----------

	wire down;
	wire up;

//----------------------------
//----- dmux -----------------

	wire init_menu;
	wire init_down;
	wire init_up;
	wire entrada0_menu;
	wire entrada0_down;
	wire entrada0_up;
	wire entrada1_menu;
	wire entrada1_down;
	wire entrada1_up;
	wire salida0_menu;
	wire salida0_down;
	wire salida0_up;
	wire mensaje0_menu;
	wire mensaje0_down;
	wire mensaje0_up;
	wire mensaje1_menu;
	wire mensaje1_down;
	wire mensaje1_up;
	wire mensaje2_menu;
	wire mensaje2_down;
	wire mensaje2_up;
	wire modul_menu;
	wire modul_down;
	wire modul_up;
	wire wram;
	wire produc_menu;
	wire lista_menu;
	wire lista_down;
	wire lista_up;
	wire compras_down;
	wire compras_up;
	wire compras_menu;

//----------------------------
//----- mux ------------------

	wire [7:0] dbi;
	wire [7:0] direc;
	wire wr;
	wire dr;
	wire [7:0] addr;
	wire [7:0] num;
	wire rd;

//----------------------------
//----- menu -----------------

	wire [7:0] db_i;
	wire wr_i;
	wire dr_i;
	wire [7:0] direc_i;

//----------------------------
//----- menu entrada 0 -------

	wire [7:0] db_entrada0;
	wire wr_entrada0;
	wire dr_entrada0;
	wire [7:0] direc_entrada0;

//----------------------------
//----- menu entrada 1 -------

	wire [7:0] db_entrada1;
	wire wr_entrada1;
	wire dr_entrada1;
	wire [7:0] direc_entrada1;

//----------------------------
//----- menu salida 0 --------

	wire [7:0] db_salida0;
	wire wr_salida0;
	wire dr_salida0;
	wire [7:0] direc_salida0;

//----------------------------
//----- mensaje 0 ------------

	wire [7:0] db_mensaje0;
	wire wr_mensaje0;
	wire dr_mensaje0;
	wire [7:0] direc_mensaje0;

//----------------------------
//----- mensaje 1 ------------

	wire [7:0] db_mensaje1;
	wire wr_mensaje1;
	wire dr_mensaje1;
	wire [7:0] direc_mensaje1;

//----------------------------
//----- mensaje 1 ------------

	wire [7:0] db_mensaje2;
	wire wr_mensaje2;
	wire dr_mensaje2;
	wire [7:0] direc_mensaje2;




	wire wr_m;
	wire dr_m;
	wire wr_b;
	wire dr_b;

	wire wr1;
	wire rd1;
	wire rd2;
	wire rd3;
	wire wr_p;
	wire dr_p;

	wire wr_l;
	wire dr_l;

	wire wr_c;
	wire dr_c;


	wire [7:0] db_m;

	wire [7:0] db_b;
	wire [7:0] db_l;

	wire [7:0] addr1;
	wire [7:0] addr2;
	wire [7:0] addr3;
	wire [7:0] addr4;
	wire [7:0] addr5;
	wire [7:0] dbout1;
	wire [7:0] db_p;
	wire [7:0] db_c;


	wire [7:0] direc_m;

	wire [7:0] direc_b;
	wire [7:0] direc_p;
	wire [7:0] direc_l;
	wire [7:0] direc_c;

	wire [7:0] dbin1;

	wire [7:0] enco1;
	wire [7:0] enco2;
	wire [7:0] enco3;
	wire [7:0] num1;
	wire [7:0] num2;
	wire [7:0] num3;

	wire [3:0] out_BCD1;
	wire [3:0] out_BCD2;
	wire [3:0] out_BCD3;

//------------------------------------------------------------
//----- buffer -----------------------------------------------
/*
	IBUFG buff(
		.O(clk),
		.I(clk_pad)
	);
*/
//------------------------------------------------------------
//----- prescaler --------------------------------------------

	prescaler prescaler0(
		.clk(clk),
		.clk2(clk2)
	);

	prescaler_10m prescaler0_10m(
		.clk(clk),
		.clk_10m(clk_10m)
	);

	prescaler_20m prescaler0_20m(
		.clk(clk),
		.clk_20m(clk_20m)
	);

//------------------------------------------------------------
//----- antirrebote ------------------------------------------

	antirrebote antirrebote0(
		.u(pul1),
		.mon1(down)
	);

	antirrebote2 antirrebote02(
		.u(pul2),
		.mon1(up)
	);

//------------------------------------------------------------
//----- dmux -------------------------------------------------

	dmux dmux0(
		.select(select),
		.wrmenu(wrmenu),
		.down(down),
		.up(up),
		.init_menu(init_menu),
		.init_down(init_down),
		.init_up(init_up),
		.entrada0_menu(entrada0_menu),
		.entrada0_down(entrada0_down),
		.entrada0_up(entrada0_up),
		.entrada1_menu(entrada1_menu),
		.entrada1_down(entrada1_down),
		.entrada1_up(entrada1_up),
		.salida0_menu(salida0_menu),
		.salida0_down(salida0_down),
		.salida0_up(salida0_up),
		.mensaje0_menu(mensaje0_menu),
		.mensaje0_down(mensaje0_down),
		.mensaje0_up(mensaje0_up),
		.mensaje1_menu(mensaje1_menu),
		.mensaje1_down(mensaje1_down),
		.mensaje1_up(mensaje1_up),
		.mensaje2_menu(mensaje2_menu),
		.mensaje2_down(mensaje2_down),
		.mensaje2_up(mensaje2_up),
		.modul_menu(modul_menu),
		.modul_down(modul_down),
		.modul_up(modul_up),
		.wram(wram),
		.produc_menu(produc_menu),
		.lista_menu(lista_menu),
		.lista_down(lista_down),
		.lista_up(lista_up),
		.compras_menu(compras_menu),
		.compras_down(compras_down),
		.compras_up(compras_up)
	);

//------------------------------------------------------------
//----- mux --------------------------------------------------

	mux mux0(
		.select(select),
		.num1(num1),
		.num2(num2),
		.num3(num3),
		.addr3(addr3),
		.addr4(addr4),
		.addr5(addr5),
		.rd1(rd1),
		.rd2(rd2),
		.rd3(rd3),
		.wr_b(wr_b),
		.dr_b(dr_b),
		.wr_l(wr_l),
		.dr_l(dr_l),
		.wr_c(wr_c),
		.dr_c(dr_c),
		.direc_l(direc_l),
		.db_l(db_l),
		.direc_b(direc_b),
		.db_b(db_b),
		.db_p(db_p),
		.direc_p(direc_p),
		.db_c(db_c),
		.direc_c(direc_c),
		.db_i(db_i),
		.direc_i(direc_i),
		.db_entrada0(db_entrada0),
		.direc_entrada0(direc_entrada0),
		.db_entrada1(db_entrada1),
		.direc_entrada1(direc_entrada1),
		.db_salida0(db_salida0),
		.direc_salida0(direc_salida0),
		.db_mensaje0(db_mensaje0),
		.direc_mensaje0(direc_mensaje0),
		.db_mensaje1(db_mensaje1),
		.direc_mensaje1(direc_mensaje1),
		.db_mensaje2(db_mensaje2),
		.direc_mensaje2(direc_mensaje2),
		.db_m(db_m),
		.direc_m(direc_m),
		.wr_i(wr_i),
		.dr_i(dr_i),
		.wr_entrada0(wr_entrada0),
		.dr_entrada0(dr_entrada0),
		.wr_entrada1(wr_entrada1),
		.dr_entrada1(dr_entrada1),
		.wr_salida0(wr_salida0),
		.dr_salida0(dr_salida0),
		.wr_mensaje0(wr_mensaje0),
		.dr_mensaje0(dr_mensaje0),
		.wr_mensaje1(wr_mensaje1),
		.dr_mensaje1(dr_mensaje1),
		.wr_mensaje2(wr_mensaje2),
		.dr_mensaje2(dr_mensaje2),
		.wr_m(wr_m),
		.dr_m(dr_m),
		.wr_p(wr_p),
		.dr_p(dr_p),
		.db(dbi),
		.direc(direc),
		.wr(wr),
		.dr(dr),
		.addr(addr2),
		.num(num),
		.rd(rd)
	);

//------------------------------------------------------------
//----- menu principal ---------------------------------------

	menu_principal menu_principal0(
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.wrmenu(init_menu),
		.down(init_down),
		.up(init_up),
		.dbi(db_i),
		.wr(wr_i),
		.dr(dr_i),
		.direc(direc_i)
	);

//------------------------------------------------------------
//----- menu entrada 0 ---------------------------------------

	menu_entrada_0 menu_entrada_0_0(
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.wrmenu(entrada0_menu),
		.down(entrada0_down),
		.up(entrada0_up),
		.dbi(db_entrada0),
		.wr(wr_entrada0),
		.dr(dr_entrada0),
		.direc(direc_entrada0)
	);

//------------------------------------------------------------
//----- menu entrada 1 ---------------------------------------

	menu_entrada_1 menu_entrada_1_0(
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.wrmenu(entrada1_menu),
		.down(entrada1_down),
		.up(entrada1_up),
		.dbi(db_entrada1),
		.wr(wr_entrada1),
		.dr(dr_entrada1),
		.direc(direc_entrada1)
	);

//------------------------------------------------------------
//----- menu salida 0 ----------------------------------------

	menu_salida_0 menu_salida_0_0(
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.wrmenu(salida0_menu),
		.down(salida0_down),
		.up(salida0_up),
		.dbi(db_salida0),
		.wr(wr_salida0),
		.dr(dr_salida0),
		.direc(direc_salida0)
	);

//------------------------------------------------------------
//----- mensaje 0 --------------------------------------------

	mensaje_0 mensaje_0_0(
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.wrmenu(mensaje0_menu),
		.down(mensaje0_down),
		.up(mensaje0_up),
		.dbi(db_mensaje0),
		.wr(wr_mensaje0),
		.dr(dr_mensaje0),
		.direc(direc_mensaje0)
	);

//------------------------------------------------------------
//----- mensaje 1 --------------------------------------------

	mensaje_1 mensaje_1_0(
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.wrmenu(mensaje1_menu),
		.down(mensaje1_down),
		.up(mensaje1_up),
		.dbi(db_mensaje1),
		.wr(wr_mensaje1),
		.dr(dr_mensaje1),
		.direc(direc_mensaje1)
	);

//------------------------------------------------------------
//----- mensaje 2 --------------------------------------------

	mensaje_2 mensaje_2_0(
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.wrmenu(mensaje2_menu),
		.down(mensaje2_down),
		.up(mensaje2_up),
		.dbi(db_mensaje2),
		.wr(wr_mensaje2),
		.dr(dr_mensaje2),
		.direc(direc_mensaje2)
	);

//------------------------------------------------------------


	fsm fsm0(
		.wr(wr),
		.dr(dr),
		.init(init),
		.clk2(clk2),
		.clk_10m(clk_10m),
		.rst(rst),
		.dbi(dbi),
		.direc(direc),
		.db(db),
		.rs(rs),
		.e(e)
	);



	modulos modulos0(
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.wrmenu(modul_menu),
		.down(modul_down),
		.up(modul_up),
		.dbi_m(db_m),
		.wr_m(wr_m),
		.dr_m(dr_m),
		.direc_m(direc_m)
	);


	bat bat0(
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.carga(carga),
		.wr(wr_b),
		.dr(dr_b),
		.direc(direc_b),
		.dbi(db_b)
	); 

	wrram wrram0(
		.rst(rst),
		.clk2(clk2),
		.wr(wram),
		.wr1(wr1),
		.dbi1(dbin1),
		.addr1(addr1),
		.led(led)
	);

	RAM RAM0(
		.rst(rst),
		.clk2(clk2),
		.rd(rd),
		.wr1(wr1),
		.dbin1(dbin1),
		.addr1(addr1),
		.addr2(addr2),
		.dbout1(dbout1),
		.led2(led2),
		.led3(led3)
	); 

	rdram rdram0(
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.wr_p(produc_menu),
		.enco1(enco1),
		.enco2(enco2),
		.enco3(enco3),
		.dbout1(dbout1),
		.db(db_p),
		.addr2(addr3),
		.direc(direc_p),
		.wr(wr_p),
		.dr(dr_p),
		.rd1(rd1),
		.num(num1)
	);

	encoder encoder0(
		.out_BCD1(out_BCD1),
		.out_BCD2(out_BCD2),
		.out_BCD3(out_BCD3),
		.enco1(enco1),
		.enco2(enco2),
		.enco3(enco3)
	);

	BCD BCD0(
		.num(num),
		.out_BCD1(out_BCD1),
		.out_BCD2(out_BCD2),
		.out_BCD3(out_BCD3)
	);

	lista lista0(
		.lista_down(lista_down),
		.lista_up(lista_up),
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.wr_l(lista_menu),
		.enco1(enco1),
		.enco2(enco2),
		.enco3(enco3),
		.dbout1(dbout1),
		.db(db_l),
		.addr2(addr4),
		.direc(direc_l),
		.wr(wr_l),
		.dr(dr_l),
		.rd2(rd2),
		.num(num2)
	);

	compras compras0(
		.lista_down(compras_down),
		.lista_up(compras_up),
		.rst(rst),
		.clk2(clk2),
		.clk_20m(clk_20m),
		.wr_l(compras_menu),
		.enco1(enco1),
		.enco2(enco2),
		.enco3(enco3),
		.dbout1(dbout1),
		.db(db_c),
		.addr2(addr5),
		.direc(direc_c),
		.wr(wr_c),
		.dr(dr_c),
		.rd2(rd3),
		.num(num3)
	);
	
endmodule
