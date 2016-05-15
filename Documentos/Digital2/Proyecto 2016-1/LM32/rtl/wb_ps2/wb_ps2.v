//---------------------------------------------------------------------------
// Wishbone General Pupose IO Component
//
//     0x00	
//     
//     0x14     number   (read/write)
//    
//
//---------------------------------------------------------------------------

module wb_ps2 (
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
	input		   ps2_dat_in,
	input		   ps2_clk_in
);

//---------------------------------------------------------------------------
// 
//---------------------------------------------------------------------------

wire [31:0] keyboardcr = 32'b0;

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
			'h00: wb_dat_o <= keyboardcr;
			'h10: wb_dat_o <= scan_code_wire;			
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

wire PS2_DAT_wire;
wire PS2_CLK_wire;
wire [7:0] scan_code_wire;

ps2_controller ps20 (
	.clk(clk),
	.reset(reset),
	.PS2_DAT(PS2_DAT_wire),
	.PS2_CLK(PS2_CLK_wire),
	.scan_code(scan_code_wire)
);

assign PS2_DAT_wire = ps2_dat_in;
assign PS2_CLK_wire = ps2_clk_in;

endmodule
