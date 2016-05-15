module vista_vga(
	 input wire clk,
	 input wire [11:0] pixel_x, 
	 input wire [11:0] pixel_y,
	 input [3:0] sw,
	 output reg [11:0] grafico,
	 output wire [18:0] text_on
	);
	
	wire [11:0] rom_addr;
	reg [7:0] char_addr;
	reg [3:0] row_addr;
	reg [2:0] bit_addr;
	wire [7:0] font_word;
	wire font_bit, text_bit_on;

	font_rom font_unit(
		.clk(clk),
		.addr(rom_addr),
		.data(font_word)
	);

//-----------------------------------------------------------------------------------------------
// Bordes
//-----------------------------------------------------------------------------------------------

	localparam borde_1_l = 0;
	localparam borde_1_r = 7;
	localparam borde_1_t = 0;
	localparam borde_1_b = 479;
	wire borde_1;

	assign borde_1 = (borde_1_l <= pixel_x) && (pixel_x <= borde_1_r) && (borde_1_t <= pixel_y) && (pixel_y <= borde_1_b);

	localparam borde_2_l = 632;
	localparam borde_2_r = 639;
	localparam borde_2_t = 0;
	localparam borde_2_b = 479;
	wire borde_2;

	assign borde_2 = (borde_2_l <= pixel_x) && (pixel_x <= borde_2_r) && (borde_2_t <= pixel_y) && (pixel_y <= borde_2_b);

	localparam borde_3_l = 8;
	localparam borde_3_r = 631;
	localparam borde_3_t = 0;
	localparam borde_3_b = 7;
	wire borde_3;

	assign borde_3 = (borde_3_l <= pixel_x) && (pixel_x <= borde_3_r) && (borde_3_t <= pixel_y) && (pixel_y <= borde_3_b);

	localparam borde_4_l = 8;
	localparam borde_4_r = 631;
	localparam borde_4_t = 472;
	localparam borde_4_b = 479;
	wire borde_4;

	assign borde_4 = (borde_4_l <= pixel_x) && (pixel_x <= borde_4_r) && (borde_4_t <= pixel_y) && (pixel_y <= borde_4_b);

//-----------------------------------------------------------------------------------------------
// PANTALLA 01
//-----------------------------------------------------------------------------------------------

	reg [7:0] char_addr_pag_1_1;
	wire pag_1_1;
	wire [3:0] row_addr_pag_1_1;
	wire [2:0] bit_addr_pag_1_1;

	assign pag_1_1 = (pixel_y [11:6] == 1) && (4 <= pixel_x [11:5]) && (pixel_x [11:5] < 16);
	assign row_addr_pag_1_1 = pixel_y [5:2];
	assign bit_addr_pag_1_1 = pixel_x [4:2];

	always @(*)
		case (pixel_x [9:5])
		5'h04: char_addr_pag_1_1 = 8'h42;	// B
		5'h05: char_addr_pag_1_1 = 8'h69;	// i
		5'h06: char_addr_pag_1_1 = 8'h65;	// e
		5'h07: char_addr_pag_1_1 = 8'h6e;	// n
		5'h08: char_addr_pag_1_1 = 8'h76;	// v
		5'h09: char_addr_pag_1_1 = 8'h65;	// e
		5'h0a: char_addr_pag_1_1 = 8'h6e;	// n
		5'h0b: char_addr_pag_1_1 = 8'h69;	// i
		5'h0c: char_addr_pag_1_1 = 8'h64;	// d
		5'h0d: char_addr_pag_1_1 = 8'h6f;	// o
		5'h0e: char_addr_pag_1_1 = 8'h00;	// 
		default: char_addr_pag_1_1 = 8'h61;	// a
		endcase

	reg [7:0] char_addr_pag_1_2;
	wire pag_1_2;
	wire [3:0] row_addr_pag_1_2;
	wire [2:0] bit_addr_pag_1_2;

	assign pag_1_2 = (pixel_y [11:6] == 2) && (2 <= pixel_x [11:5]) && (pixel_x [11:5] < 18);
	assign row_addr_pag_1_2 = pixel_y [5:2];
	assign bit_addr_pag_1_2 = pixel_x [4:2];
		
	always @(*)
		case (pixel_x [9:5])
		5'h02: char_addr_pag_1_2 = 8'h44;	// D
		5'h03: char_addr_pag_1_2 = 8'h49;	// I
		5'h04: char_addr_pag_1_2 = 8'h47;	// G
		5'h05: char_addr_pag_1_2 = 8'h49;	// I
		5'h06: char_addr_pag_1_2 = 8'h4c;	// L
		5'h07: char_addr_pag_1_2 = 8'h4f;	// O
		5'h08: char_addr_pag_1_2 = 8'h43;	// C
		5'h09: char_addr_pag_1_2 = 8'h4b;	// K
		5'h0a: char_addr_pag_1_2 = 8'h00;	// 
		5'h0b: char_addr_pag_1_2 = 8'h53;	// S
		5'h0c: char_addr_pag_1_2 = 8'h59;	// Y
		5'h0d: char_addr_pag_1_2 = 8'h53;	// S
		5'h0e: char_addr_pag_1_2 = 8'h54;       // T
		5'h0f: char_addr_pag_1_2 = 8'h45;	// E
		5'h10: char_addr_pag_1_2 = 8'h4d;	// M
		default: char_addr_pag_1_2 = 8'h2e;	// .
		endcase

	reg [7:0] char_addr_pag_1_3;
	wire pag_1_3;
	wire [3:0] row_addr_pag_1_3;
	wire [2:0] bit_addr_pag_1_3;

	assign pag_1_3 = (pixel_y [11:4] == 22) && (25 <= pixel_x [11:3]) && (pixel_x [11:3] <= 52);
	assign row_addr_pag_1_3 = pixel_y [3:0];
	assign bit_addr_pag_1_3 = pixel_x [2:0];

	always @(*)
		case (pixel_x [8:3])
		6'h19: char_addr_pag_1_3 = 8'h70;	// p
		6'h1a: char_addr_pag_1_3 = 8'h72;	// r
		6'h1b: char_addr_pag_1_3 = 8'h65;	// e
		6'h1c: char_addr_pag_1_3 = 8'h73;	// s
		6'h1d: char_addr_pag_1_3 = 8'h69;	// i
		6'h1e: char_addr_pag_1_3 = 8'h6f;	// o
		6'h1f: char_addr_pag_1_3 = 8'h6e;	// n
		6'h20: char_addr_pag_1_3 = 8'h65;	// e
		6'h21: char_addr_pag_1_3 = 8'h00;	// 
		6'h22: char_addr_pag_1_3 = 8'h28;	// (
		6'h23: char_addr_pag_1_3 = 8'h30;	// 0
		6'h24: char_addr_pag_1_3 = 8'h29;	// )
		6'h25: char_addr_pag_1_3 = 8'h00;	// 
		6'h26: char_addr_pag_1_3 = 8'h70;	// p
		6'h27: char_addr_pag_1_3 = 8'h61;	// a
		6'h28: char_addr_pag_1_3 = 8'h72;	// r
		6'h29: char_addr_pag_1_3 = 8'h61;	// a
		6'h2a: char_addr_pag_1_3 = 8'h00;	// 
		6'h2b: char_addr_pag_1_3 = 8'h63;	// c
		6'h2c: char_addr_pag_1_3 = 8'h6f;	// o
		6'h2d: char_addr_pag_1_3 = 8'h6e;	// n
		6'h2e: char_addr_pag_1_3 = 8'h74;	// t
		6'h2f: char_addr_pag_1_3 = 8'h69;	// i
		6'h30: char_addr_pag_1_3 = 8'h6e;	// n
		6'h31: char_addr_pag_1_3 = 8'h75;	// u
		6'h32: char_addr_pag_1_3 = 8'h61;	// a
		6'h33: char_addr_pag_1_3 = 8'h72;	// r
		default: char_addr_pag_1_3 = 8'h2e;	// .
		endcase

//-----------------------------------------------------------------------------------------------
// PANTALLA 02
//-----------------------------------------------------------------------------------------------

	reg [7:0] char_addr_pag_2_1;
	wire pag_2_1;
	wire [3:0] row_addr_pag_2_1;
	wire [2:0] bit_addr_pag_2_1;

	assign pag_2_1 = (pixel_y [11:6] == 1) && (6 <= pixel_x [11:5]) && (pixel_x [11:5] < 14);
	assign row_addr_pag_2_1 = pixel_y [5:2];
	assign bit_addr_pag_2_1 = pixel_x [4:2];

	always @(*)
		case (pixel_x [8:5])
		4'h06: char_addr_pag_2_1 = 8'h52;	// R
		4'h07: char_addr_pag_2_1 = 8'h65;	// e
		4'h08: char_addr_pag_2_1 = 8'h67;	// g
		4'h09: char_addr_pag_2_1 = 8'h69;	// i
		4'h0a: char_addr_pag_2_1 = 8'h73;	// s
		4'h0b: char_addr_pag_2_1 = 8'h74;	// t
		4'h0c: char_addr_pag_2_1 = 8'h72;	// r
		default: char_addr_pag_2_1 = 8'h6f;	// o
		endcase

	reg [7:0] char_addr_pag_2_2;
	wire pag_2_2;
	wire [3:0] row_addr_pag_2_2;
	wire [2:0] bit_addr_pag_2_2;

	assign pag_2_2 = (pixel_y [11:4] == 15) && (27 <= pixel_x [11:3]) && (pixel_x [11:3] <= 52);
	assign row_addr_pag_2_2 = pixel_y [3:0];
	assign bit_addr_pag_2_2 = pixel_x [2:0];

	always @(*)
		case (pixel_x [8:3])
		6'h1b: char_addr_pag_2_2 = 8'h4e;	// N -28
		6'h1c: char_addr_pag_2_2 = 8'h6f;	// o
		6'h1d: char_addr_pag_2_2 = 8'h6d;	// m	
		6'h1e: char_addr_pag_2_2 = 8'h62;	// b
		6'h1f: char_addr_pag_2_2 = 8'h72;	// r
		6'h20: char_addr_pag_2_2 = 8'h65;	// e
		6'h21: char_addr_pag_2_2 = 8'h00;	// 
		6'h22: char_addr_pag_2_2 = 8'h64;	// d
		6'h23: char_addr_pag_2_2 = 8'h65;	// e
		6'h24: char_addr_pag_2_2 = 8'h00;	// 
		6'h25: char_addr_pag_2_2 = 8'h75;	// u
		6'h26: char_addr_pag_2_2 = 8'h73;	// s
		6'h27: char_addr_pag_2_2 = 8'h75;	// u
		6'h28: char_addr_pag_2_2 = 8'h61;	// a
		6'h29: char_addr_pag_2_2 = 8'h72;	// r
		6'h2a: char_addr_pag_2_2 = 8'h69;	// i
		6'h2b: char_addr_pag_2_2 = 8'h6f;	// o
		6'h2c: char_addr_pag_2_2 = 8'h3a;	// :
		6'h2d: char_addr_pag_2_2 = 8'h00;	// 
		6'h2e: char_addr_pag_2_2 = 8'h5f;	// _
		6'h2f: char_addr_pag_2_2 = 8'h5f;	// _
		6'h30: char_addr_pag_2_2 = 8'h5f;	// _
		6'h31: char_addr_pag_2_2 = 8'h5f;	// _
		6'h32: char_addr_pag_2_2 = 8'h5f;	// _
		6'h33: char_addr_pag_2_2 = 8'h5f;	// _
		6'h34: char_addr_pag_2_2 = 8'h5f;	// _
		default: char_addr_pag_2_2 = 8'h00;	// 
		endcase

	reg [7:0] char_addr_pag_2_3;
	wire pag_2_3;
	wire [3:0] row_addr_pag_2_3;
	wire [2:0] bit_addr_pag_2_3;

	assign pag_2_3 = (pixel_y [11:4] == 22) && (14 <= pixel_x [11:3]) && (pixel_x [11:3] <= 65);
	assign row_addr_pag_2_3 = pixel_y [3:0];
	assign bit_addr_pag_2_3 = pixel_x [2:0];

	always @(*)
		case (pixel_x [9:3])
		7'h0e: char_addr_pag_2_3 = 8'h44;	// D
		7'h0f: char_addr_pag_2_3 = 8'h65;	// e
		7'h10: char_addr_pag_2_3 = 8'h73;	// s
		7'h11: char_addr_pag_2_3 = 8'h6c;	// l
		7'h12: char_addr_pag_2_3 = 8'h69;	// i
		7'h13: char_addr_pag_2_3 = 8'h63;	// c
		7'h14: char_addr_pag_2_3 = 8'h65;	// e
		7'h15: char_addr_pag_2_3 = 8'h00;	// 
		7'h16: char_addr_pag_2_3 = 8'h73;	// s
		7'h17: char_addr_pag_2_3 = 8'h75;	// u
		7'h18: char_addr_pag_2_3 = 8'h00;	// 
		7'h19: char_addr_pag_2_3 = 8'h63;	// c
		7'h1a: char_addr_pag_2_3 = 8'h61;	// a
		7'h1b: char_addr_pag_2_3 = 8'h72;	// r
		7'h1c: char_addr_pag_2_3 = 8'h6e;	// n
		7'h1d: char_addr_pag_2_3 = 8'h65;	// e
		7'h1e: char_addr_pag_2_3 = 8'h74;	// t
		7'h1f: char_addr_pag_2_3 = 8'h00;	// 
		7'h20: char_addr_pag_2_3 = 8'h70;	// p
		7'h21: char_addr_pag_2_3 = 8'h6f;	// o
		7'h22: char_addr_pag_2_3 = 8'h72;	// r
		7'h23: char_addr_pag_2_3 = 8'h00;	// 
		7'h24: char_addr_pag_2_3 = 8'h65;	// e
		7'h25: char_addr_pag_2_3 = 8'h6c;	// l
		7'h26: char_addr_pag_2_3 = 8'h00;	// 
		7'h27: char_addr_pag_2_3 = 8'h6c;	// l
		7'h28: char_addr_pag_2_3 = 8'h65;	// e
		7'h29: char_addr_pag_2_3 = 8'h63;	// c
		7'h2a: char_addr_pag_2_3 = 8'h74;	// t
		7'h2b: char_addr_pag_2_3 = 8'h6f;	// o
		7'h2c: char_addr_pag_2_3 = 8'h72;	// r
		7'h2d: char_addr_pag_2_3 = 8'h00;	// 
		7'h2e: char_addr_pag_2_3 = 8'h64;	// d
		7'h2f: char_addr_pag_2_3 = 8'h65;	// e
		7'h30: char_addr_pag_2_3 = 8'h00;	// 
		7'h31: char_addr_pag_2_3 = 8'h63;	// c
		7'h32: char_addr_pag_2_3 = 8'h6f;	// o
		7'h33: char_addr_pag_2_3 = 8'h64;	// d
		7'h34: char_addr_pag_2_3 = 8'h69;	// i
		7'h35: char_addr_pag_2_3 = 8'h67;	// g
		7'h36: char_addr_pag_2_3 = 8'h6f;	// o
		7'h37: char_addr_pag_2_3 = 8'h00;	// 
		7'h38: char_addr_pag_2_3 = 8'h64;	// d
		7'h39: char_addr_pag_2_3 = 8'h65;	// e
		7'h3a: char_addr_pag_2_3 = 8'h00;	// 
		7'h3b: char_addr_pag_2_3 = 8'h62;	// b
		7'h3c: char_addr_pag_2_3 = 8'h61;	// a
		7'h3d: char_addr_pag_2_3 = 8'h72;	// r
		7'h3e: char_addr_pag_2_3 = 8'h72;	// r
		7'h3f: char_addr_pag_2_3 = 8'h61;	// a
		7'h40: char_addr_pag_2_3 = 8'h73;	// s
		default: char_addr_pag_2_3 = 8'h2e;	// .
		endcase

//-------------------------------------------------------------------------------------------------
// PANTALLA 03
//-------------------------------------------------------------------------------------------------

	reg [7:0] char_addr_pag_3_1;
	wire pag_3_1;
	wire [3:0] row_addr_pag_3_1;
	wire [2:0] bit_addr_pag_3_1;

	assign pag_3_1 = (pixel_y [11:6] == 1) && (6 <= pixel_x [11:5]) && (pixel_x [11:5] < 14);
	assign row_addr_pag_3_1 = pixel_y [5:2];
	assign bit_addr_pag_3_1 = pixel_x [4:2];

	always @(*)
		case (pixel_x [8:5])
		4'h06: char_addr_pag_3_1 = 8'h52;	// R
		4'h07: char_addr_pag_3_1 = 8'h65;	// e
		4'h08: char_addr_pag_3_1 = 8'h67;	// g
		4'h09: char_addr_pag_3_1 = 8'h69;	// i
		4'h0a: char_addr_pag_3_1 = 8'h73;	// s
		4'h0b: char_addr_pag_3_1 = 8'h74;	// t
		4'h0c: char_addr_pag_3_1 = 8'h72;	// r
		default: char_addr_pag_3_1 = 8'h6f;	// o
		endcase

	reg [7:0] char_addr_pag_3_2;
	wire pag_3_2;
	wire [3:0] row_addr_pag_3_2;
	wire [2:0] bit_addr_pag_3_2;

	assign pag_3_2 = (pixel_y [11:4] == 22) && (14 <= pixel_x [11:3]) && (pixel_x [11:3] <= 64);
	assign row_addr_pag_3_2 = pixel_y [3:0];
	assign bit_addr_pag_3_2 = pixel_x [2:0];

	always @(*)
		case (pixel_x [9:3])
		7'h0e: char_addr_pag_3_2 = 8'h55;	// U
		7'h0f: char_addr_pag_3_2 = 8'h73;	// s
		7'h10: char_addr_pag_3_2 = 8'h75;	// u
		7'h11: char_addr_pag_3_2 = 8'h61;	// a
		7'h12: char_addr_pag_3_2 = 8'h72;	// r
		7'h13: char_addr_pag_3_2 = 8'h69;	// i
		7'h14: char_addr_pag_3_2 = 8'h6f;	// o
		7'h15: char_addr_pag_3_2 = 8'h00;	// 
		7'h16: char_addr_pag_3_2 = 8'h6e;	// n
		7'h17: char_addr_pag_3_2 = 8'h6f;	// o
		7'h18: char_addr_pag_3_2 = 8'h00;	// 
		7'h19: char_addr_pag_3_2 = 8'h65;	// e
		7'h1a: char_addr_pag_3_2 = 8'h6e;	// n
		7'h1b: char_addr_pag_3_2 = 8'h63;	// c
		7'h1c: char_addr_pag_3_2 = 8'h6f;	// o
		7'h1d: char_addr_pag_3_2 = 8'h6e;	// n
		7'h1e: char_addr_pag_3_2 = 8'h74;	// t
		7'h1f: char_addr_pag_3_2 = 8'h72;	// r
		7'h20: char_addr_pag_3_2 = 8'h61;	// a
		7'h21: char_addr_pag_3_2 = 8'h64;	// d
		7'h22: char_addr_pag_3_2 = 8'h6f;	// o
		7'h23: char_addr_pag_3_2 = 8'h2c;	// ,
		7'h24: char_addr_pag_3_2 = 8'h00;	// 
		7'h25: char_addr_pag_3_2 = 8'h70;	// p
		7'h26: char_addr_pag_3_2 = 8'h72;	// r
		7'h27: char_addr_pag_3_2 = 8'h65;	// e
		7'h28: char_addr_pag_3_2 = 8'h73;	// s
		7'h29: char_addr_pag_3_2 = 8'h69;	// i
		7'h2a: char_addr_pag_3_2 = 8'h6f;	// o
		7'h2b: char_addr_pag_3_2 = 8'h6e;	// n
		7'h2c: char_addr_pag_3_2 = 8'h65;	// e
		7'h2d: char_addr_pag_3_2 = 8'h00;	// 
		7'h2e: char_addr_pag_3_2 = 8'h28;	// (
		7'h2f: char_addr_pag_3_2 = 8'h30;	// 0
		7'h30: char_addr_pag_3_2 = 8'h29;	// )
		7'h31: char_addr_pag_3_2 = 8'h00;	// 
		7'h32: char_addr_pag_3_2 = 8'h70;	// p
		7'h33: char_addr_pag_3_2 = 8'h61;	// a
		7'h34: char_addr_pag_3_2 = 8'h72;	// r
		7'h35: char_addr_pag_3_2 = 8'h61;	// a
		7'h36: char_addr_pag_3_2 = 8'h00;	// 
		7'h37: char_addr_pag_3_2 = 8'h63;	// c
		7'h38: char_addr_pag_3_2 = 8'h6f;	// o
		7'h39: char_addr_pag_3_2 = 8'h6e;	// n
		7'h3a: char_addr_pag_3_2 = 8'h74;	// t
		7'h3b: char_addr_pag_3_2 = 8'h69;	// i
		7'h3c: char_addr_pag_3_2 = 8'h6e;	// n
		7'h3d: char_addr_pag_3_2 = 8'h75;	// u
		7'h3e: char_addr_pag_3_2 = 8'h61;	// a
		7'h3f: char_addr_pag_3_2 = 8'h72;	// r
		default: char_addr_pag_3_2 = 8'h2e;	// .
		endcase

//-------------------------------------------------------------------------------------------------
// PANTALLA 04
//-------------------------------------------------------------------------------------------------

	reg [7:0] char_addr_pag_4_1;
	wire pag_4_1;
	wire [3:0] row_addr_pag_4_1;
	wire [2:0] bit_addr_pag_4_1;

	assign pag_4_1 = (pixel_y [11:6] == 1) && (6 <= pixel_x [11:5]) && (pixel_x [11:5] < 14);
	assign row_addr_pag_4_1 = pixel_y [5:2];
	assign bit_addr_pag_4_1 = pixel_x [4:2];

	always @(*)
		case (pixel_x [8:5])
		4'h06: char_addr_pag_4_1 = 8'h52;	// R
		4'h07: char_addr_pag_4_1 = 8'h65;	// e
		4'h08: char_addr_pag_4_1 = 8'h67;	// g
		4'h09: char_addr_pag_4_1 = 8'h69;	// i
		4'h0a: char_addr_pag_4_1 = 8'h73;	// s
		4'h0b: char_addr_pag_4_1 = 8'h74;	// t
		4'h0c: char_addr_pag_4_1 = 8'h72;	// r
		default: char_addr_pag_4_1 = 8'h6f;	// o
		endcase

	reg [7:0] char_addr_pag_4_2;
	wire pag_4_2;
	wire [3:0] row_addr_pag_4_2;
	wire [2:0] bit_addr_pag_4_2;

	assign pag_4_2 = (pixel_y [11:4] == 15) && (27 <= pixel_x [11:3]) && (pixel_x [11:3] <= 52);
	assign row_addr_pag_4_2 = pixel_y [3:0];
	assign bit_addr_pag_4_2 = pixel_x [2:0];

	always @(*)
		case (pixel_x [8:3])
		6'h1b: char_addr_pag_4_2 = 8'h43;	// C
		6'h1c: char_addr_pag_4_2 = 8'h6f;	// o
		6'h1d: char_addr_pag_4_2 = 8'h6e;	// n	
		6'h1e: char_addr_pag_4_2 = 8'h74;	// t
		6'h1f: char_addr_pag_4_2 = 8'h72;	// r
		6'h20: char_addr_pag_4_2 = 8'h61;	// a
		6'h21: char_addr_pag_4_2 = 8'h73;	// s
		6'h22: char_addr_pag_4_2 = 8'h65;	// e
		6'h23: char_addr_pag_4_2 = 8'h8a;	// ñ
		6'h24: char_addr_pag_4_2 = 8'h61;	// a
		6'h25: char_addr_pag_4_2 = 8'h00;	// 
		6'h26: char_addr_pag_4_2 = 8'h64;	// d
		6'h27: char_addr_pag_4_2 = 8'h65;	// e
		6'h28: char_addr_pag_4_2 = 8'h00;	// 
		6'h29: char_addr_pag_4_2 = 8'h75;	// u
		6'h2a: char_addr_pag_4_2 = 8'h73;	// s
		6'h2b: char_addr_pag_4_2 = 8'h75;	// u
		6'h2c: char_addr_pag_4_2 = 8'h61;	// a
		6'h2d: char_addr_pag_4_2 = 8'h72;	// r
		6'h2e: char_addr_pag_4_2 = 8'h69;	// i
		6'h2f: char_addr_pag_4_2 = 8'h6f;	// o
		6'h30: char_addr_pag_4_2 = 8'h3a;	// :
		6'h31: char_addr_pag_4_2 = 8'h00;	// 
		6'h32: char_addr_pag_4_2 = 8'h5f;	// _
		6'h33: char_addr_pag_4_2 = 8'h5f;	// _
		6'h34: char_addr_pag_4_2 = 8'h5f;	// _
		default: char_addr_pag_4_2 = 8'h00;	// _
		endcase

	reg [7:0] char_addr_pag_4_3;
	wire pag_4_3;
	wire [3:0] row_addr_pag_4_3;
	wire [2:0] bit_addr_pag_4_3;

	assign pag_4_3 = (pixel_y [11:4] == 22) && (13 <= pixel_x [11:3]) && (pixel_x [11:3] <= 66);
	assign row_addr_pag_4_3 = pixel_y [3:0];
	assign bit_addr_pag_4_3 = pixel_x [2:0];

	always @(*)
		case (pixel_x [9:3])
		7'h0d: char_addr_pag_4_3 = 8'h49;	// I
		7'h0e: char_addr_pag_4_3 = 8'h6e;	// n
		7'h0f: char_addr_pag_4_3 = 8'h67;	// g
		7'h10: char_addr_pag_4_3 = 8'h72;	// r
		7'h11: char_addr_pag_4_3 = 8'h65;	// e
		7'h12: char_addr_pag_4_3 = 8'h63;	// c
		7'h13: char_addr_pag_4_3 = 8'h65;	// e
		7'h14: char_addr_pag_4_3 = 8'h00;	// 
		7'h15: char_addr_pag_4_3 = 8'h73;	// s
		7'h16: char_addr_pag_4_3 = 8'h75;	// u
		7'h17: char_addr_pag_4_3 = 8'h00;	// 
		7'h18: char_addr_pag_4_3 = 8'h63;	// c
		7'h19: char_addr_pag_4_3 = 8'h6f;	// o
		7'h1a: char_addr_pag_4_3 = 8'h6e;	// n
		7'h1b: char_addr_pag_4_3 = 8'h74;	// t
		7'h1c: char_addr_pag_4_3 = 8'h72;	// r
		7'h1d: char_addr_pag_4_3 = 8'h61;	// a
		7'h1e: char_addr_pag_4_3 = 8'h73;	// s
		7'h1f: char_addr_pag_4_3 = 8'h65;	// e
		7'h20: char_addr_pag_4_3 = 8'h8a;	// ñ
		7'h21: char_addr_pag_4_3 = 8'h61;	// a
		7'h22: char_addr_pag_4_3 = 8'h00;	// 
		7'h23: char_addr_pag_4_3 = 8'h75;	// u
		7'h24: char_addr_pag_4_3 = 8'h74;	// t
		7'h25: char_addr_pag_4_3 = 8'h69;	// i
		7'h26: char_addr_pag_4_3 = 8'h6c;	// l
		7'h27: char_addr_pag_4_3 = 8'h69;	// i
		7'h28: char_addr_pag_4_3 = 8'h7a;	// z
		7'h29: char_addr_pag_4_3 = 8'h61;	// a
		7'h2a: char_addr_pag_4_3 = 8'h6e;	// n
		7'h2b: char_addr_pag_4_3 = 8'h64;	// d
		7'h2c: char_addr_pag_4_3 = 8'h6f;	// o
		7'h2d: char_addr_pag_4_3 = 8'h00;	// 
		7'h2e: char_addr_pag_4_3 = 8'h65;	// e
		7'h2f: char_addr_pag_4_3 = 8'h6c;	// l
		7'h30: char_addr_pag_4_3 = 8'h00;	// 
		7'h31: char_addr_pag_4_3 = 8'h74;	// t
		7'h32: char_addr_pag_4_3 = 8'h65;	// e
		7'h33: char_addr_pag_4_3 = 8'h63;	// c
		7'h34: char_addr_pag_4_3 = 8'h6c;	// l
		7'h35: char_addr_pag_4_3 = 8'h61;	// a
		7'h36: char_addr_pag_4_3 = 8'h64;	// d
		7'h37: char_addr_pag_4_3 = 8'h6f;	// o
		7'h38: char_addr_pag_4_3 = 8'h00;	// 
		7'h39: char_addr_pag_4_3 = 8'h6d;	// m
		7'h3a: char_addr_pag_4_3 = 8'h61;	// a
		7'h3b: char_addr_pag_4_3 = 8'h74;	// t
		7'h3c: char_addr_pag_4_3 = 8'h72;	// r
		7'h3d: char_addr_pag_4_3 = 8'h69;	// i
		7'h3e: char_addr_pag_4_3 = 8'h63;	// c
		7'h3f: char_addr_pag_4_3 = 8'h69;	// i
		7'h40: char_addr_pag_4_3 = 8'h61;	// a
		7'h41: char_addr_pag_4_3 = 8'h6c;	// l
		default: char_addr_pag_4_3 = 8'h2e;	// .
		endcase

//-------------------------------------------------------------------------------------------------
// PANTALLA 05
//-------------------------------------------------------------------------------------------------

	reg [7:0] char_addr_pag_5_1;
	wire pag_5_1;
	wire [3:0] row_addr_pag_5_1;
	wire [2:0] bit_addr_pag_5_1;

	assign pag_5_1 = (pixel_y [11:6] == 1) && (6 <= pixel_x [11:5]) && (pixel_x [11:5] < 14);
	assign row_addr_pag_5_1 = pixel_y [5:2];
	assign bit_addr_pag_5_1 = pixel_x [4:2];

	always @(*)
		case (pixel_x [8:5])
		4'h06: char_addr_pag_5_1 = 8'h52;	// R
		4'h07: char_addr_pag_5_1 = 8'h65;	// e
		4'h08: char_addr_pag_5_1 = 8'h67;	// g
		4'h09: char_addr_pag_5_1 = 8'h69;	// i
		4'h0a: char_addr_pag_5_1 = 8'h73;	// s
		4'h0b: char_addr_pag_5_1 = 8'h74;	// t
		4'h0c: char_addr_pag_5_1 = 8'h72;	// r
		default: char_addr_pag_5_1 = 8'h6f;	// o
		endcase

	reg [7:0] char_addr_pag_5_2;
	wire pag_5_2;
	wire [3:0] row_addr_pag_5_2;
	wire [2:0] bit_addr_pag_5_2;

	assign pag_5_2 = (pixel_y [11:4] == 22) && (12 <= pixel_x [11:3]) && (pixel_x [11:3] <= 65);
	assign row_addr_pag_5_2 = pixel_y [3:0];
	assign bit_addr_pag_5_2 = pixel_x [2:0];

	always @(*)
		case (pixel_x [9:3])
		7'h0c: char_addr_pag_5_2 = 8'h43;	// C
		7'h0d: char_addr_pag_5_2 = 8'h6f;	// o
		7'h0e: char_addr_pag_5_2 = 8'h6e;	// n		
		7'h0f: char_addr_pag_5_2 = 8'h74;	// t
		7'h10: char_addr_pag_5_2 = 8'h72;	// r
		7'h11: char_addr_pag_5_2 = 8'h61;	// a
		7'h12: char_addr_pag_5_2 = 8'h73;	// s
		7'h13: char_addr_pag_5_2 = 8'h65;	// e
		7'h14: char_addr_pag_5_2 = 8'h8a;	// ñ
		7'h15: char_addr_pag_5_2 = 8'h61;	// a
		7'h16: char_addr_pag_5_2 = 8'h00;	// 
		7'h17: char_addr_pag_5_2 = 8'h6e;	// n
		7'h18: char_addr_pag_5_2 = 8'h6f;	// o
		7'h19: char_addr_pag_5_2 = 8'h00;	// 
		7'h1a: char_addr_pag_5_2 = 8'h65;	// e
		7'h1b: char_addr_pag_5_2 = 8'h6e;	// n
		7'h1c: char_addr_pag_5_2 = 8'h63;	// c
		7'h1d: char_addr_pag_5_2 = 8'h6f;	// o
		7'h1e: char_addr_pag_5_2 = 8'h6e;	// n
		7'h1f: char_addr_pag_5_2 = 8'h74;	// t
		7'h20: char_addr_pag_5_2 = 8'h72;	// r
		7'h21: char_addr_pag_5_2 = 8'h61;	// a
		7'h22: char_addr_pag_5_2 = 8'h64;	// d
		7'h23: char_addr_pag_5_2 = 8'h61;	// a
		7'h24: char_addr_pag_5_2 = 8'h2c;	// ,
		7'h25: char_addr_pag_5_2 = 8'h00;	// 
		7'h26: char_addr_pag_5_2 = 8'h70;	// p
		7'h27: char_addr_pag_5_2 = 8'h72;	// r
		7'h28: char_addr_pag_5_2 = 8'h65;	// e
		7'h29: char_addr_pag_5_2 = 8'h73;	// s
		7'h2a: char_addr_pag_5_2 = 8'h69;	// i
		7'h2b: char_addr_pag_5_2 = 8'h6f;	// o
		7'h2c: char_addr_pag_5_2 = 8'h6e;	// n
		7'h2d: char_addr_pag_5_2 = 8'h65;	// e
		7'h2e: char_addr_pag_5_2 = 8'h00;	// 
		7'h2f: char_addr_pag_5_2 = 8'h28;	// (
		7'h30: char_addr_pag_5_2 = 8'h30;	// 0
		7'h31: char_addr_pag_5_2 = 8'h29;	// )
		7'h32: char_addr_pag_5_2 = 8'h00;	// 
		7'h33: char_addr_pag_5_2 = 8'h70;	// p
		7'h34: char_addr_pag_5_2 = 8'h61;	// a
		7'h35: char_addr_pag_5_2 = 8'h72;	// r
		7'h36: char_addr_pag_5_2 = 8'h61;	// a
		7'h37: char_addr_pag_5_2 = 8'h00;	// 
		7'h38: char_addr_pag_5_2 = 8'h63;	// c
		7'h39: char_addr_pag_5_2 = 8'h6f;	// o
		7'h3a: char_addr_pag_5_2 = 8'h6e;	// n
		7'h3b: char_addr_pag_5_2 = 8'h74;	// t
		7'h3c: char_addr_pag_5_2 = 8'h69;	// i
		7'h3d: char_addr_pag_5_2 = 8'h6e;	// n
		7'h3e: char_addr_pag_5_2 = 8'h75;	// u
		7'h3f: char_addr_pag_5_2 = 8'h61;	// a
		7'h40: char_addr_pag_5_2 = 8'h72;	// r
		default: char_addr_pag_5_2 = 8'h2e;	// .
		endcase

//-------------------------------------------------------------------------------------------------
// PANTALLA 06
//-------------------------------------------------------------------------------------------------

	reg [7:0] char_addr_pag_6_1;
	wire pag_6_1;
	wire [3:0] row_addr_pag_6_1;
	wire [2:0] bit_addr_pag_6_1;

	assign pag_6_1 = (pixel_y [11:6] == 1) && (8 <= pixel_x [11:5]) && (pixel_x [11:5] < 12);
	assign row_addr_pag_6_1 = pixel_y [5:2];
	assign bit_addr_pag_6_1 = pixel_x [4:2];

	always @(*)
		case (pixel_x [8:5])
		4'h08: char_addr_pag_6_1 = 8'h4d;	// M
		4'h09: char_addr_pag_6_1 = 8'h61;	// a
		4'h0a: char_addr_pag_6_1 = 8'h70;	// p
		default: char_addr_pag_6_1 = 8'h61;	// a
		endcase

	reg [7:0] char_addr_pag_6_2;
	wire pag_6_2;
	wire [3:0] row_addr_pag_6_2;
	wire [2:0] bit_addr_pag_6_2;

	assign pag_6_2 = (pixel_y [11:4] == 22) && (16 <= pixel_x [11:3]) && (pixel_x [11:3] <= 63);
	assign row_addr_pag_6_2 = pixel_y [3:0];
	assign bit_addr_pag_6_2 = pixel_x [2:0];

	always @(*)
		case (pixel_x [9:3])
		7'h10: char_addr_pag_6_2 = 8'h45;	// E
		7'h11: char_addr_pag_6_2 = 8'h6c;	// l
		7'h12: char_addr_pag_6_2 = 8'h00;	// 
		7'h13: char_addr_pag_6_2 = 8'h63;	// c
		7'h14: char_addr_pag_6_2 = 8'h61;	// a
		7'h15: char_addr_pag_6_2 = 8'h73;	// s
		7'h16: char_addr_pag_6_2 = 8'h69;	// i
		7'h17: char_addr_pag_6_2 = 8'h6c;	// l
		7'h18: char_addr_pag_6_2 = 8'h6c;	// l
		7'h19: char_addr_pag_6_2 = 8'h65;	// e
		7'h1a: char_addr_pag_6_2 = 8'h72;	// r
		7'h1b: char_addr_pag_6_2 = 8'h6f;	// o
		7'h1c: char_addr_pag_6_2 = 8'h00;	// 
		7'h1d: char_addr_pag_6_2 = 8'h61;	// a
		7'h1e: char_addr_pag_6_2 = 8'h73;	// s
		7'h1f: char_addr_pag_6_2 = 8'h69;	// i
		7'h20: char_addr_pag_6_2 = 8'h67;	// g
		7'h21: char_addr_pag_6_2 = 8'h6e;	// n
		7'h22: char_addr_pag_6_2 = 8'h61;	// a
		7'h23: char_addr_pag_6_2 = 8'h64;	// d
		7'h24: char_addr_pag_6_2 = 8'h6f;	// o
		7'h25: char_addr_pag_6_2 = 8'h00;	// 
		7'h26: char_addr_pag_6_2 = 8'h73;	// s
		7'h27: char_addr_pag_6_2 = 8'h65;	// e
		7'h28: char_addr_pag_6_2 = 8'h00;	// 
		7'h29: char_addr_pag_6_2 = 8'h6d;	// m
		7'h2a: char_addr_pag_6_2 = 8'h75;	// u
		7'h2b: char_addr_pag_6_2 = 8'h65;	// e
		7'h2c: char_addr_pag_6_2 = 8'h73;	// s
		7'h2d: char_addr_pag_6_2 = 8'h74;	// t
		7'h2e: char_addr_pag_6_2 = 8'h72;	// r
		7'h2f: char_addr_pag_6_2 = 8'h61;	// a
		7'h30: char_addr_pag_6_2 = 8'h00;	// 
		7'h31: char_addr_pag_6_2 = 8'h65;	// e
		7'h32: char_addr_pag_6_2 = 8'h6e;	// n
		7'h33: char_addr_pag_6_2 = 8'h00;	// 
		7'h34: char_addr_pag_6_2 = 8'h63;	// c
		7'h35: char_addr_pag_6_2 = 8'h6f;	// o
		7'h36: char_addr_pag_6_2 = 8'h6c;	// l
		7'h37: char_addr_pag_6_2 = 8'h6f;	// o
		7'h38: char_addr_pag_6_2 = 8'h72;	// r
		7'h39: char_addr_pag_6_2 = 8'h00;	// 
		7'h3a: char_addr_pag_6_2 = 8'h76;	// v
		7'h3b: char_addr_pag_6_2 = 8'h65;	// e
		7'h3c: char_addr_pag_6_2 = 8'h72;	// r
		7'h3d: char_addr_pag_6_2 = 8'h64;	// d
		7'h3e: char_addr_pag_6_2 = 8'h65;	// e
		default: char_addr_pag_6_2 = 8'h2e;	// .
		endcase
//-------------------------------------------------------------------------------------------------

	always @(*)
	begin
		grafico = 12'b111111111111;
		     if(pag_1_1 && (sw == 4'b0000))
			begin
				char_addr = char_addr_pag_1_1;
				row_addr = row_addr_pag_1_1;
				bit_addr = bit_addr_pag_1_1;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_1_2 && (sw == 4'b0000))
			begin
				char_addr = char_addr_pag_1_2;
				row_addr = row_addr_pag_1_2;
				bit_addr = bit_addr_pag_1_2;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_1_3 && (sw == 4'b0000))
			begin
				char_addr = char_addr_pag_1_3;
				row_addr = row_addr_pag_1_3;
				bit_addr = bit_addr_pag_1_3;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_2_1 && (sw == 4'b0001))
			begin
				char_addr = char_addr_pag_2_1;
				row_addr = row_addr_pag_2_1;
				bit_addr = bit_addr_pag_2_1;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_2_2 && (sw == 4'b0001))
			begin
				char_addr = char_addr_pag_2_2;
				row_addr = row_addr_pag_2_2;
				bit_addr = bit_addr_pag_2_2;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_2_3 && (sw == 4'b0001))
			begin
				char_addr = char_addr_pag_2_3;
				row_addr = row_addr_pag_2_3;
				bit_addr = bit_addr_pag_2_3;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if (pag_3_1 && (sw == 4'b0010))
			begin
				char_addr = char_addr_pag_3_1;
				row_addr = row_addr_pag_3_1;
				bit_addr = bit_addr_pag_3_1;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_3_2 && (sw == 4'b0010))
			begin
				char_addr = char_addr_pag_3_2;
				row_addr = row_addr_pag_3_2;
				bit_addr = bit_addr_pag_3_2;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_4_1 && (sw == 4'b0011))
			begin
				char_addr = char_addr_pag_4_1;
				row_addr = row_addr_pag_4_1;
				bit_addr = bit_addr_pag_4_1;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_4_2 && (sw == 4'b0011))
			begin
				char_addr = char_addr_pag_4_2;
				row_addr = row_addr_pag_4_2;
				bit_addr = bit_addr_pag_4_2;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_4_3 && (sw == 4'b0011))
			begin
				char_addr = char_addr_pag_4_3;
				row_addr = row_addr_pag_4_3;
				bit_addr = bit_addr_pag_4_3;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_5_1 && (sw == 4'b0100))
			begin
				char_addr = char_addr_pag_5_1;
				row_addr = row_addr_pag_5_1;
				bit_addr = bit_addr_pag_5_1;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_5_2 && (sw == 4'b0100))
			begin
				char_addr = char_addr_pag_5_2;
				row_addr = row_addr_pag_5_2;
				bit_addr = bit_addr_pag_5_2;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_6_1 && (sw == 4'b0101))
			begin
				char_addr = char_addr_pag_6_1;
				row_addr = row_addr_pag_6_1;
				bit_addr = bit_addr_pag_6_1;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(pag_6_2 && (sw == 4'b0101))
			begin
				char_addr = char_addr_pag_6_2;
				row_addr = row_addr_pag_6_2;
				bit_addr = bit_addr_pag_6_2;
				if (font_bit) begin grafico = 12'b000000001111; end
			end
		else if(borde_1)
			begin
				grafico = 12'b000000001111;
			end
		else if(borde_2)
			begin
				grafico = 12'b000000001111;
			end
		else if(borde_3)
			begin
				grafico = 12'b000000001111;
			end
		else	begin
				grafico = 12'b000000001111;
			end
	end

	assign text_on = {borde_4, borde_3, borde_2, borde_1, pag_6_2, pag_6_1, pag_5_2, pag_5_1, pag_4_3, pag_4_2, pag_4_1, pag_3_2, pag_3_1, pag_2_3, pag_2_2, pag_2_1, pag_1_3, pag_1_2, pag_1_1};


	assign rom_addr = {char_addr, row_addr};
	assign font_bit = font_word [~bit_addr];

endmodule
