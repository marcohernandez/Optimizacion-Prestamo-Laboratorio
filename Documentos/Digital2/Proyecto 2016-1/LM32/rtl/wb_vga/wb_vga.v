//---------------------------------------------------------------------------
// Wishbone VGA
//
//     0x00	
//     0x10     hsync_out
//     0x14     vsync_out
//     0x18     rgb_out
//
//---------------------------------------------------------------------------

module wb_vga (
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
	output	wire	   hsync_out,
	output	wire	   vsync_out,
	output  wire    [11:0] rgb_out
);

//---------------------------------------------------------------------------
// 
//---------------------------------------------------------------------------

wire [31:0] vgacr = 32'b0;

// Wishbone
reg  ack;
assign wb_ack_o = wb_stb_i & wb_cyc_i & ack;

wire wb_rd = wb_stb_i & wb_cyc_i & ~wb_we_i;
wire wb_wr = wb_stb_i & wb_cyc_i &  wb_we_i;

reg [31:0] intro;

always @(posedge clk)
begin
	if (reset) begin
		ack      <= 0;
		intro    <= 32'b0;
	end else begin
		// Handle WISHBONE access
		ack    <= 0;

		if (wb_rd & ~ack) begin           // read cycle
			ack <= 1;

			case (wb_adr_i[7:0])
			'h00: wb_dat_o <= vgacr;
			'h10: wb_dat_o <= intro;
			default: wb_dat_o <= 32'b0;
			endcase
		end else if (wb_wr & ~ack ) begin // write cycle
			ack <= 1;

			case (wb_adr_i[7:0])
			'h00: begin
			end
			'h10: intro <= wb_dat_i;
			
			endcase
		end
	end
end

wire hsync_wire;
wire vsync_wire;
wire [11:0] rbg_wire;
wire [3:0] intro0;

vga_top vga0(
	.clk(clk),
	.reset(reset),
	.sw(4'b0000),
	.hsync(hsync_wire),
	.vsync(vsync_wire),
	.rgb(rgb_wire)
);

assign hsync_out = hsync_wire; 
assign vsync_out = vsync_wire; 
assign rgb_out = 12'b111111111111;
assign intro0 = intro[3:0];

endmodule
