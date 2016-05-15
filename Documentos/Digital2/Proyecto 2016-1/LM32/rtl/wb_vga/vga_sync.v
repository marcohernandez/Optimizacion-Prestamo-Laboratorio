module vga_sync(
	 input wire clk, 
	 input wire reset,
	 output wire hsync,
	 output wire vsync,
	 output wire video_on,
	 output wire p_tick,
	 output wire [11:0] pixel_x,
	 output wire [11:0] pixel_y
	);

	localparam HD=640;	// area de display horizontal	640
	localparam HF=48;	// borde izquierdo		48
	localparam HB=16;	// borde derecho		16
	localparam HR=96;	// retraso horizontal		96

	localparam VD=480;	// area de display vertical	480
	localparam VF=21;	// borde superior		21
	localparam VB=11;	// borde inferior		11
	localparam VR=2;	// retaso vertical		2

	// contador hasta dos
	reg mod2_reg;
	wire mod2_next;

	//sincronización de los contadores
	reg [11:0] h_count_reg, h_count_next;
	reg [11:0] v_count_reg, v_count_next;

	// salidas
	reg v_sync_reg, h_sync_reg;
	wire v_sync_next, h_sync_next;

	// status signal
	wire h_end, v_end, pixel_tick;
	
	//body
	//registers

	always @(posedge clk, posedge reset)
		if (reset)
			begin
				mod2_reg <= 1'b0;
				v_count_reg<= 0;
				h_count_reg<= 0;
				v_sync_reg<= 1'b0;
				h_sync_reg<= 1'b0;
			end
		else
			begin
				mod2_reg <= mod2_next;
				v_count_reg<= v_count_next;
				h_count_reg<= h_count_next;
				v_sync_reg<= v_sync_next;
				h_sync_reg<= h_sync_next;
			end



	// Divisor de frecuencias a 25MHz
	assign mod2_next = ~mod2_reg;
	assign pixel_tick = mod2_reg;

	//señales de estado
	//Final del contador horizontal (799)
	assign h_end = (h_count_reg==(HD+HF+HB+HR-1));

	//Final delcontador vertical (524)
	assign v_end = (v_count_reg==(VD+VF+VB+VR-1));

	// logica de estado siguiente para un contador síncrono horizontal mod-800

	always @*
		if (pixel_tick)
			if (h_end)
				h_count_next = 0;
			else
				h_count_next = h_count_reg + 1;
		else
			h_count_next = h_count_reg;

	//logica de estado siguiente para un contador síncrono vertical mod-525

	always @*
		if (pixel_tick & h_end)
			if (v_end)
				v_count_next = 0;
			else
				v_count_next = v_count_reg + 1;
		else
			v_count_next = v_count_reg;

	//Sincronización horizontal y vertical, buffered para evitar gliches
	// h_sync_next entre 656 y 751
	assign h_sync_next = (h_count_reg >= (HD+HB) && h_count_reg <= (HD+HB+HR-1));

	// v_sync_next entre 490 y 491
	assign v_sync_next = (v_count_reg >= (VD+VB) && v_count_reg <= (VD+VB+VR-1));

	//Activar o desactivar el video
	assign video_on = (h_count_reg<HD) && (v_count_reg<VD);

	// output
	assign hsync = h_sync_reg;
	assign vsync = v_sync_reg;
	assign pixel_x = h_count_reg;
	assign pixel_y = v_count_reg;
	assign p_tick = pixel_tick;

endmodule
