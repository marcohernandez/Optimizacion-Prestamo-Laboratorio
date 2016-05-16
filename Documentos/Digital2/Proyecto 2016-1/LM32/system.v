//---------------------------------------------------------------------------
// LatticeMico32 System On A Chip
//
// Top Level Design for the Xilinx Spartan 3-200 Starter Kit
//---------------------------------------------------------------------------

module system
#(
	parameter   bootram_file     = "../firmware/boot0-final/image.ram",
	parameter   clk_freq         = 100000000,
	parameter   uart_baud_rate   = 115200
) (
	input		clk,
	input		rst,
	// UART 0
	output		uart_led,
	input		uart_rxd, 
	output		uart_txd,
        // UART 1
	output		uartt_led,
	input		uartt_rxd, 
	output		uartt_txd,
	// ps2 0
	input 		ps2_dat_in,
	input		ps2_clk_in,
	// gpio 0
	input		[3:0] JDin,
	output		[3:0] JDout
);

//------------------------------------------------------------------
// Whishbone Wires
//------------------------------------------------------------------

wire         gnd   =  1'b0;
wire   [3:0] gnd4  =  4'h0;
wire  [31:0] gnd32 = 32'h00000000;

 
wire [31:0]  lm32i_adr,
             lm32d_adr,
             uart0_adr,
             uart1_adr,
             timer0_adr,
             bram0_adr,
	     ps20_adr,
	     gpio0_adr;


wire [31:0]  lm32i_dat_r,
             lm32i_dat_w,
             lm32d_dat_r,
             lm32d_dat_w,
             uart0_dat_r,
             uart0_dat_w,
             uart1_dat_r,
             uart1_dat_w,
             timer0_dat_r,
             timer0_dat_w,
             bram0_dat_r,
             bram0_dat_w,
	     ps20_dat_w,
	     ps20_dat_r,
	     gpio0_dat_w,
	     gpio0_dat_r;

wire [3:0]   lm32i_sel,
             lm32d_sel,
             uart0_sel,
             uart1_sel,
             timer0_sel,
             bram0_sel,
	     ps20_sel,
	     gpio0_sel;

wire         lm32i_we,
             lm32d_we,
             uart0_we,
             uart1_we,
             timer0_we,
             bram0_we,
	     ps20_we,
             gpio0_we;

wire         lm32i_cyc,
             lm32d_cyc,
             uart0_cyc,
             timer0_cyc,
             uart1_cyc,
             bram0_cyc,
	     ps20_cyc,
	     gpio0_cyc;

wire         lm32i_stb,
             lm32d_stb,
             uart0_stb,
             uart1_stb,
             timer0_stb,
             bram0_stb,
	     ps20_stb,
	     gpio0_stb;

wire         lm32i_ack,
             lm32d_ack,
             uart0_ack,
             uart1_ack,
             timer0_ack,
             bram0_ack,
	     ps20_ack,
	     gpio0_ack;

wire         lm32i_rty,
             lm32d_rty;

wire         lm32i_err,
             lm32d_err;

wire         lm32i_lock,
             lm32d_lock;

wire [2:0]   lm32i_cti,
             lm32d_cti;

wire [1:0]   lm32i_bte,
             lm32d_bte;

//---------------------------------------------------------------------------
// Interrupts
//---------------------------------------------------------------------------

wire [31:0]  intr_n;
wire         uart0_intr = 0;
wire   [1:0] timer0_intr;
wire	     ps20_intr;
wire	     gpio0_intr;

assign intr_n = { 26'hFFFFFFF, ~timer0_intr[1], ~timer0_intr[0], ~uart0_intr, ~ps20_intr, ~gpio0_intr};

//---------------------------------------------------------------------------
// Wishbone Interconnect
//---------------------------------------------------------------------------

wb_conbus_top #(
	.s0_addr_w ( 3 ),
	.s0_addr   ( 3'h4 ),        
	.s1_addr_w ( 3 ),
	.s1_addr   ( 3'h5 ),        
	.s27_addr_w( 15 ),
	.s2_addr   ( 15'h0000 ),    // bram0 
	.s3_addr   ( 15'h7000 ),    // uart0        
	.s4_addr   ( 15'h7001 ),    // timer0
	.s5_addr   ( 15'h7002 ),    // uart1
	.s6_addr   ( 15'h7003 ),    // gpio0
	.s7_addr   ( 15'h7004 )	    // ps20

) conmax0 (
	.clk_i( clk ),
	.rst_i( rst ),
	// Master0
	.m0_dat_i(  lm32i_dat_w  ),
	.m0_dat_o(  lm32i_dat_r  ),
	.m0_adr_i(  lm32i_adr    ),
	.m0_we_i (  lm32i_we     ),
	.m0_sel_i(  lm32i_sel    ),
	.m0_cyc_i(  lm32i_cyc    ),
	.m0_stb_i(  lm32i_stb    ),
	.m0_ack_o(  lm32i_ack    ),
	.m0_rty_o(  lm32i_rty    ),
	.m0_err_o(  lm32i_err    ),
	// Master1
	.m1_dat_i(  lm32d_dat_w  ),
	.m1_dat_o(  lm32d_dat_r  ),
	.m1_adr_i(  lm32d_adr    ),
	.m1_we_i (  lm32d_we     ),
	.m1_sel_i(  lm32d_sel    ),
	.m1_cyc_i(  lm32d_cyc    ),
	.m1_stb_i(  lm32d_stb    ),
	.m1_ack_o(  lm32d_ack    ),
	.m1_rty_o(  lm32d_rty    ),
	.m1_err_o(  lm32d_err    ),
	// Master2
	.m2_dat_i(  gnd32  ),
	.m2_adr_i(  gnd32  ),
	.m2_sel_i(  gnd4   ),
	.m2_cyc_i(  gnd    ),
	.m2_stb_i(  gnd    ),
	// Master3
	.m3_dat_i(  gnd32  ),
	.m3_adr_i(  gnd32  ),
	.m3_sel_i(  gnd4   ),
	.m3_cyc_i(  gnd    ),
	.m3_stb_i(  gnd    ),
	// Master4
	.m4_dat_i(  gnd32  ),
	.m4_adr_i(  gnd32  ),
	.m4_sel_i(  gnd4   ),
	.m4_cyc_i(  gnd    ),
	.m4_stb_i(  gnd    ),
	// Master5
	.m5_dat_i(  gnd32  ),
	.m5_adr_i(  gnd32  ),
	.m5_sel_i(  gnd4   ),
	.m5_cyc_i(  gnd    ),
	.m5_stb_i(  gnd    ),
	// Master6
	.m6_dat_i(  gnd32  ),
	.m6_adr_i(  gnd32  ),
	.m6_sel_i(  gnd4   ),
	.m6_cyc_i(  gnd    ),
	.m6_stb_i(  gnd    ),
	// Master7
	.m7_dat_i(  gnd32  ),
	.m7_adr_i(  gnd32  ),
	.m7_sel_i(  gnd4   ),
	.m7_cyc_i(  gnd    ),
	.m7_stb_i(  gnd    ),

	// Slave0
	.s0_dat_i(  gnd32  ),
	.s0_ack_i(  gnd    ),
	.s0_err_i(  gnd    ),
	.s0_rty_i(  gnd    ),
	// Slave1
	.s1_dat_i(  gnd32  ),
	.s1_ack_i(  gnd    ),
	.s1_err_i(  gnd    ),
	.s1_rty_i(  gnd    ),
	// Slave2
	.s2_dat_i(  bram0_dat_r  ),
	.s2_dat_o(  bram0_dat_w  ),
	.s2_adr_o(  bram0_adr    ),
	.s2_sel_o(  bram0_sel    ),
	.s2_we_o (  bram0_we     ),
	.s2_cyc_o(  bram0_cyc    ),
	.s2_stb_o(  bram0_stb    ),
	.s2_ack_i(  bram0_ack    ),
	.s2_err_i(  gnd          ),
	.s2_rty_i(  gnd          ),
	// Slave3
	.s3_dat_i(  uart0_dat_r  ),
	.s3_dat_o(  uart0_dat_w  ),
	.s3_adr_o(  uart0_adr    ),
	.s3_sel_o(  uart0_sel    ),
	.s3_we_o (  uart0_we     ),
	.s3_cyc_o(  uart0_cyc    ),
	.s3_stb_o(  uart0_stb    ),
	.s3_ack_i(  uart0_ack    ),
	.s3_err_i(  gnd          ),
	.s3_rty_i(  gnd          ),
	// Slave4
	.s4_dat_i(  timer0_dat_r ),
	.s4_dat_o(  timer0_dat_w ),
	.s4_adr_o(  timer0_adr   ),
	.s4_sel_o(  timer0_sel   ),
	.s4_we_o (  timer0_we    ),
	.s4_cyc_o(  timer0_cyc   ),
	.s4_stb_o(  timer0_stb   ),
	.s4_ack_i(  timer0_ack   ),
	.s4_err_i(  gnd          ),
	.s4_rty_i(  gnd          ),
	// Slave5
	.s5_dat_i(  uart1_dat_r  ),
	.s5_dat_o(  uart1_dat_w  ),
	.s5_adr_o(  uart1_adr    ),
	.s5_sel_o(  uart1_sel    ),
	.s5_we_o (  uart1_we     ),
	.s5_cyc_o(  uart1_cyc    ),
	.s5_stb_o(  uart1_stb    ),
	.s5_ack_i(  uart1_ack    ),
	.s5_err_i(  gnd          ),
	.s5_rty_i(  gnd          ),
	// Slave6
	.s6_dat_i(  gpio0_dat_r  ),
	.s6_dat_o(  gpio0_dat_w  ),
	.s6_adr_o(  gpio0_adr    ),
	.s6_sel_o(  gpio0_sel    ),
	.s6_we_o (  gpio0_we     ),
	.s6_cyc_o(  gpio0_cyc    ),
	.s6_stb_o(  gpio0_stb    ),
	.s6_ack_i(  gpio0_ack    ),
	.s6_err_i(  gnd          ),
	.s6_rty_i(  gnd          ),
	// Slave7
	.s7_dat_i(  ps20_dat_r   ),
	.s7_dat_o(  ps20_dat_w   ),
	.s7_adr_o(  ps20_adr     ),
	.s7_sel_o(  ps20_sel     ),
	.s7_we_o (  ps20_we      ),
	.s7_cyc_o(  ps20_cyc     ),
	.s7_stb_o(  ps20_stb     ),
	.s7_ack_i(  ps20_ack     ),
	.s7_err_i(  gnd          ),
	.s7_rty_i(  gnd          )
);


//---------------------------------------------------------------------------
// LM32 CPU 
//---------------------------------------------------------------------------

lm32_cpu lm0 (
	.clk_i(  clk  ),
	.rst_i(  rst  ),
	.interrupt_n(  intr_n  ),
	//
	.I_ADR_O(  lm32i_adr    ),
	.I_DAT_I(  lm32i_dat_r  ),
	.I_DAT_O(  lm32i_dat_w  ),
	.I_SEL_O(  lm32i_sel    ),
	.I_CYC_O(  lm32i_cyc    ),
	.I_STB_O(  lm32i_stb    ),
	.I_ACK_I(  lm32i_ack    ),
	.I_WE_O (  lm32i_we     ),
	.I_CTI_O(  lm32i_cti    ),
	.I_LOCK_O( lm32i_lock   ),
	.I_BTE_O(  lm32i_bte    ),
	.I_ERR_I(  lm32i_err    ),
	.I_RTY_I(  lm32i_rty    ),
	//
	.D_ADR_O(  lm32d_adr    ),
	.D_DAT_I(  lm32d_dat_r  ),
	.D_DAT_O(  lm32d_dat_w  ),
	.D_SEL_O(  lm32d_sel    ),
	.D_CYC_O(  lm32d_cyc    ),
	.D_STB_O(  lm32d_stb    ),
	.D_ACK_I(  lm32d_ack    ),
	.D_WE_O (  lm32d_we     ),
	.D_CTI_O(  lm32d_cti    ),
	.D_LOCK_O( lm32d_lock   ),
	.D_BTE_O(  lm32d_bte    ),
	.D_ERR_I(  lm32d_err    ),
	.D_RTY_I(  lm32d_rty    )
);
	
//---------------------------------------------------------------------------
// Block RAM
//---------------------------------------------------------------------------

wb_bram #(
	.adr_width( 12 ),
	.mem_file_name( bootram_file )
) bram0 (
	.clk_i(  clk  ),
	.rst_i(  rst  ),
	//
	.wb_adr_i(  bram0_adr    ),
	.wb_dat_o(  bram0_dat_r  ),
	.wb_dat_i(  bram0_dat_w  ),
	.wb_sel_i(  bram0_sel    ),
	.wb_stb_i(  bram0_stb    ),
	.wb_cyc_i(  bram0_cyc    ),
	.wb_ack_o(  bram0_ack    ),
	.wb_we_i(   bram0_we     )
);

//---------------------------------------------------------------------------
// uart0
//---------------------------------------------------------------------------

wire uart0_rxd;
wire uart0_txd;

wb_uart #(
	.clk_freq( clk_freq        ),
	.baud(     uart_baud_rate  )
) uart0 (
	.clk( clk ),
	.reset( rst ),
	//
	.wb_adr_i( uart0_adr ),
	.wb_dat_i( uart0_dat_w ),
	.wb_dat_o( uart0_dat_r ),
	.wb_stb_i( uart0_stb ),
	.wb_cyc_i( uart0_cyc ),
	.wb_we_i(  uart0_we ),
	.wb_sel_i( uart0_sel ),
	.wb_ack_o( uart0_ack ), 
//	.intr(       uart0_intr ),
	.uart_rxd( uart0_rxd ),
	.uart_txd( uart0_txd )
);

assign uart_txd  = uart0_txd;
assign uart0_rxd   = uart_rxd;
assign uart_led  = ~uart_txd;

//---------------------------------------------------------------------------
// uart1
//---------------------------------------------------------------------------

wire uart1_rxd;
wire uart1_txd;

wb_uart #(
	.clk_freq( clk_freq        ),
	.baud(     uart_baud_rate  )
) uart1 (
	.clk( clk ),
	.reset( rst ),
	//
	.wb_adr_i( uart1_adr ),
	.wb_dat_i( uart1_dat_w ),
	.wb_dat_o( uart1_dat_r ),
	.wb_stb_i( uart1_stb ),
	.wb_cyc_i( uart1_cyc ),
	.wb_we_i(  uart1_we ),
	.wb_sel_i( uart1_sel ),
	.wb_ack_o( uart1_ack ), 
//	.intr(       uart0_intr ),
	.uart_rxd( uart1_rxd ),
	.uart_txd( uart1_txd )
);

assign uartt_txd  = uart1_txd;
assign uart1_rxd   = uartt_rxd;
assign uart_led  = ~uartt_txd;

//---------------------------------------------------------------------------
// timer0
//---------------------------------------------------------------------------

wb_timer #(
	.clk_freq(   clk_freq  )
) timer0 (
	.clk(      clk          ),
	.reset(    rst          ),
	//
	.wb_adr_i( timer0_adr   ),
	.wb_dat_i( timer0_dat_w ),
	.wb_dat_o( timer0_dat_r ),
	.wb_stb_i( timer0_stb   ),
	.wb_cyc_i( timer0_cyc   ),
	.wb_we_i(  timer0_we    ),
	.wb_sel_i( timer0_sel   ),
	.wb_ack_o( timer0_ack   ), 
	.intr(     timer0_intr  )
);

//---------------------------------------------------------------------------
// PS2
//---------------------------------------------------------------------------

wire ps2_dat_in0;
wire ps2_clk_in0;

wb_ps2 ps20 (
	.clk(      clk           ),
	.reset(    rst           ),
	//
	.wb_adr_i  ( ps20_adr    ),
	.wb_dat_i  ( ps20_dat_w  ),
	.wb_dat_o  ( ps20_dat_r  ),
	.wb_stb_i  ( ps20_stb    ),
	.wb_cyc_i  ( ps20_cyc    ),
	.wb_we_i   ( ps20_we     ),
	.wb_sel_i  ( ps20_sel    ),
	.wb_ack_o  ( ps20_ack    ), 
	.intr      ( ps20_intr   ),
	.ps2_dat_in( ps2_dat_in0 ),
	.ps2_clk_in( ps2_clk_in0 )
);

assign ps2_dat_in0 = ps2_dat_in;
assign ps2_clk_in0 = ps2_clk_in;

//---------------------------------------------------------------------------
// General Purpose IO [0]
//---------------------------------------------------------------------------

wire [31:0] gpio0_in;
wire [31:0] gpio0_out;
wire [31:0] gpio0_oe;

wb_gpio gpio0 (
	.clk(      clk          ),
	.reset(    rst          ),
	//
	.wb_adr_i( gpio0_adr    ),
	.wb_dat_i( gpio0_dat_w  ),
	.wb_dat_o( gpio0_dat_r  ),
	.wb_stb_i( gpio0_stb    ),
	.wb_cyc_i( gpio0_cyc    ),
	.wb_we_i(  gpio0_we     ),
	.wb_sel_i( gpio0_sel    ),
	.wb_ack_o( gpio0_ack    ), 
	.intr(     gpio0_intr   ),
	// GPIO
	.gpio_in(  gpio0_in     ),
	.gpio_out( gpio0_out    ),
	.gpio_oe(  gpio0_oe     )
);

assign JDout = gpio0_out;
assign gpio0_in = JDin;

endmodule 
