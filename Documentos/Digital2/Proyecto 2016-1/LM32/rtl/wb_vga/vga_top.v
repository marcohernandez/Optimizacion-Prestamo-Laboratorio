module vga_top(
		 input clk,
		 input reset,
		 input [3:0] sw,
		 output wire hsync,
		 output wire vsync,
		 output wire [11:0] rgb
		);

	//declaración de señales

	wire [11:0] pixel_x; 
	wire [11:0] pixel_y;
	wire video_on; 
	wire pixel_tick;
	reg [11:0] rgb_reg;
	reg [11:0] rgb_one;
	wire [11:0] rgb_next;
	wire [18:0] text_on;	
	reg clk_2;

	always @(posedge clk) begin
		clk_2 <= ~clk_2;
	end

	// body	

	// circuito de sincronización

	vga_sync vga_sync_unit(
		.clk(clk_2),
		.reset(reset),
		.hsync(hsync),
		.vsync(vsync),
		.video_on(video_on),
		.p_tick(pixel_tick),
		.pixel_x(pixel_x),
		.pixel_y(pixel_y)
	);

	//generador gráfico

	vista_vga vista_vga_unit(
		.clk(clk_2),
		.pixel_x(pixel_x),
		.pixel_y(pixel_y),
		.sw(sw),
		.grafico(rgb_next),
		.text_on(text_on)
	);

	always @(*)
		if(~video_on)
			rgb_one = 12'b000000000000;
		else
		begin
				if(text_on[0] && (sw == 4'b0000)) begin rgb_one = rgb_next; end
			else	if(text_on[1] && (sw == 4'b0000)) begin rgb_one = rgb_next; end
			else	if(text_on[2] && (sw == 4'b0000)) begin rgb_one = rgb_next; end
			else	if(text_on[3] && (sw == 4'b0001)) begin rgb_one = rgb_next; end
			else	if(text_on[4] && (sw == 4'b0001)) begin rgb_one = rgb_next; end
			else	if(text_on[5] && (sw == 4'b0001)) begin rgb_one = rgb_next; end
			else	if(text_on[6] && (sw == 4'b0010)) begin rgb_one = rgb_next; end
			else	if(text_on[7] && (sw == 4'b0010)) begin rgb_one = rgb_next; end
			else	if(text_on[8] && (sw == 4'b0011)) begin rgb_one = rgb_next; end
			else	if(text_on[9] && (sw == 4'b0011)) begin rgb_one = rgb_next; end
			else	if(text_on[10] && (sw == 4'b0011)) begin rgb_one = rgb_next; end
			else	if(text_on[11] && (sw == 4'b0100)) begin rgb_one = rgb_next; end
			else	if(text_on[12] && (sw == 4'b0100)) begin rgb_one = rgb_next; end
			else	if(text_on[13] && (sw == 4'b0101)) begin rgb_one = rgb_next; end
			else	if(text_on[14] && (sw == 4'b0101)) begin rgb_one = rgb_next; end
			else	if(text_on[15]) begin rgb_one = rgb_next; end
			else	if(text_on[16]) begin rgb_one = rgb_next; end
			else	if(text_on[17]) begin rgb_one = rgb_next; end
			else	if(text_on[18]) begin rgb_one = rgb_next; end
			else	begin rgb_one = 12'b111111111111; end
		end

	// rgb
	always @(posedge clk_2)
		if (pixel_tick)
			rgb_reg<= rgb_one;
	//output
	assign rgb = rgb_reg;
endmodule
