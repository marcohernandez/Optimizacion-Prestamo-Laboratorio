#include "soc-hw.h"

uart_t   *uart0  = (uart_t *)   0xF0000000;
timer_t  *timer0 = (timer_t *)  0xF0010000;
gpio_t   *gpio0  = (gpio_t *)   0xF0020000;
vga_t	 *vga0   = (vga_t *)    0xF0030000;
bcd_t 	 *bcd0   = (bcd_t *)    0xF0040000;


uint32_t msec = 0;

/***************************************************************************
 * General utility functions
 */

void write_intro(int number){

	vga0->ctrl = 0x10;
	vga0->intro = number;
}

int read_sw(){
	gpio0->ctrl = 0x10;
	return gpio0->in;
}

void show_char(char ascii){
	gpio0->ctrl = 0x14;
	gpio0->out = ascii;
}

void show_led(int led){
	gpio0->ctrl = 0x14;
	gpio0->out = led;
}

void show_number(int numero){

	bcd0->ctrl = 0x10;
	bcd0->number = numero;
}

void sleep(int msec)
{
	uint32_t tcr;

	// Use timer0.1
	timer0->compare1 = (FCPU/1000)*msec;
	timer0->counter1 = 0;
	timer0->tcr1 = TIMER_EN | TIMER_IRQEN;

	do {
		//halt();
 		tcr = timer0->tcr1;
 	} while ( ! (tcr & TIMER_TRIG) );
}

void tic_init()
{
	// Setup timer0.0
	timer0->compare0 = (FCPU/1000);
	timer0->counter0 = 0;
	timer0->tcr0     = TIMER_EN | TIMER_AR | TIMER_IRQEN;
}

/***************************************************************************
 * UART Functions
 */
void uart_init()
{
	//uart0->ier = 0x00;  // Interrupt Enable Register
	//uart0->lcr = 0x03;  // Line Control Register:    8N1
	//uart0->mcr = 0x00;  // Modem Control Register

	// Setup Divisor register (Fclk / Baud)
	//uart0->div = (FCPU/(57600*16));
}

char uart_read()
{   
	return uart0->rxtx;
}
char uart_getchar()
{   
	while (! (uart0->ucr & UART_DR)) ;
	return uart0->rxtx;
}

void uart_putchar(char c)
{
	while (uart0->ucr & UART_BUSY) ;
	uart0->rxtx = c;
}

void uart_putstr(char *str)
{
	char *c = str;
	while(*c) {
		uart_putchar(*c);
		c++;
	}
}

