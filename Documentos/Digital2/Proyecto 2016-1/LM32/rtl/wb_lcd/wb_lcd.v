//---------------------------------------------------------------------------
// Wishbone General Pupose IO Component
//
//     0x00	
//     
//     0x14     number   (read/write)
//    
//
//---------------------------------------------------------------------------

module wb_lcd (
	input              clk,
	input              reset,
	// Wishbone interface
	input              wb_stb_i,
	input              wb_cyc_i,
	output             wb_ack_o,
	input              wb_we_i,
	input       [31:0] wb_adr_i,
	input        [3:0] wb_sel_i,
	input       [31:0] wb_dat_i,
	output reg  [31:0] wb_dat_o,
	//
	output             intr,
	// IO Wires	

	input		   pul1_in,
	input		   pul2_in,
	input	           wrmenu_in,
	input		   init_in,
	input 	     [3:0] select_in,
	input	     [1:0] carga_in,
	output       [7:0] db_out,
	output  	   led_out,
	output  	   led2_out,
	output  	   led3_out,
	output  	   rs_out,
	output  	   e_out
);

//---------------------------------------------------------------------------
// 
//---------------------------------------------------------------------------

wire [31:0] lcdcr = 32'b0;

// Wishbone
reg  ack;
assign wb_ack_o = wb_stb_i & wb_cyc_i & ack;

wire wb_rd = wb_stb_i & wb_cyc_i & ~wb_we_i;
wire wb_wr = wb_stb_i & wb_cyc_i &  wb_we_i;

always @(posedge clk)
begin
	if (reset) begin
		ack      <= 0;
	end else begin
		// Handle WISHBONE access
		ack    <= 0;

		if (wb_rd & ~ack) begin           // read cycle
			ack <= 1;

			case (wb_adr_i[7:0])
			'h00: wb_dat_o <= lcdcr;
//			'h10: wb_dat_o <= scan_code_wire;			
			default: wb_dat_o <= 32'b0;
			endcase
		end else if (wb_wr & ~ack ) begin // write cycle
			ack <= 1;

			case (wb_adr_i[7:0])
			'h00: begin
			end			
			endcase
		end
	end
end

wire pul1_wire;
wire pul2_wire;
wire wrmenu_wire;
wire init_wire;
wire [3:0] select_wire;
wire [1:0] carga_wire;

top top_lcd0(
	.clk(clk),
	.pul1(pul1_wire),
	.pul2(pul1_wire),
	.wrmenu(wrmenu_wire),
	.init(init_wire),
	.rst(reset),
	.select(select_wire),
	.carga(carga_wire),
	.db(db_out),
	.led(led_out),
	.led2(led2_out),
	.led3(led3_out),
	.rs(rs_out),
	.e(e_out)
);

assign pul1_wire = pul1_in;
assign pul2_wire = pul2_in;
assign wrmenu_wire = wrmenu_in;
assign init_wire = init_in;
assign select_wire = select_in;
assign carga_wire = carga_in;

endmodule
