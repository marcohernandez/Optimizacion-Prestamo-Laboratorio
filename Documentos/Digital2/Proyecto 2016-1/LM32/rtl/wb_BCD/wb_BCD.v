//---------------------------------------------------------------------------
// Wishbone General Pupose IO Component
//
//     0x00	
//     
//     0x14     number   (read/write)
//    
//
//---------------------------------------------------------------------------

module wb_BCD (
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
	
	output [6:0] seg_out,
	output [7:0] an_out
);

//---------------------------------------------------------------------------
// 
//---------------------------------------------------------------------------

wire [31:0] BCDcr = 32'b0;

// Wishbone
reg  ack;
assign wb_ack_o = wb_stb_i & wb_cyc_i & ack;

wire wb_rd = wb_stb_i & wb_cyc_i & ~wb_we_i;
wire wb_wr = wb_stb_i & wb_cyc_i &  wb_we_i;

reg [31:0] number;

always @(posedge clk)
begin
	if (reset) begin
		ack      <= 0;
		number 	 <= 32'b0;
	end else begin
		// Handle WISHBONE access
		ack    <= 0;

		if (wb_rd & ~ack) begin           // read cycle
			ack <= 1;

			case (wb_adr_i[7:0])
			'h00: wb_dat_o <= BCDcr;
			'h10: wb_dat_o <= number;			
			default: wb_dat_o <= 32'b0;
			endcase
		end else if (wb_wr & ~ack ) begin // write cycle
			ack <= 1;

			case (wb_adr_i[7:0])
			'h00: begin
			end
			'h10: number <= wb_dat_i;			
			endcase
		end
	end
end

wire [6:0] seg0;
wire [7:0] an0;
wire [3:0] dato0;

BCD bcd0 (
	.clk(clk),
	.dato(dato0),
	.seg(seg0),
	.an(an0)
);

assign an_out = an0;
assign seg_out = seg0;
assign dato0 = number[3:0];

endmodule
