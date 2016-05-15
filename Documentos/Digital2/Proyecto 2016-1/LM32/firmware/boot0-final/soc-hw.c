#include "soc-hw.h"

uart0_t  *uart0  = (uart0_t *)  0xF0000000;
timer_t  *timer0 = (timer_t *)  0xF0010000;
uart1_t  *uart1  = (uart1_t *)  0xF0020000;
gpio0_t  *gpio0  = (gpio0_t *)  0xF0030000;
ps2_t	 *ps20	 = (ps2_t   *)	0xF0040000;

uint32_t msec = 0;

/***************************************************************************
 * General utility functions
 */
/*

/***************************************************************************
 * TIMER Functions
 */

void sleep(int msec){

	uint32_t tcr;

	// Use timer0.1      
	timer0->compare1 = (100000*msec);
	timer0->counter1 = 0;
	timer0->tcr1 = TIMER_EN | TIMER_IRQEN;

	do {
		//halt();
 		tcr = timer0->tcr1;
 	} while ( ! (tcr & TIMER_TRIG) );
}

void nsleep(uint32_t nsec){

	uint32_t tcr;

	// Use timer0.1
	timer0->compare1 = (nsec/10);
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
 * GPIO 0 Functions
 */

int read_columna(){
	gpio0->ctrl = 0x10;
	return gpio0->in;
}

void write_fila(int code){
	gpio0->ctrl = 0x14;
	gpio0->out = code;
}

void write_buzzer(int signal){
	gpio0->ctrl = 0x18;
	gpio0->oe = signal;
}

/***************************************************************************
 * PS2 Functions
 */

int scan_code_ps2(){

	ps20->ctrl = 0x10;
	return ps20->scancode;
}

/***************************************************************************
 * UART 0 Functions
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
/***************************************************************************
 * UART 1 Functions
 */

void uart1_init()
{
	//uart0->ier = 0x00;  // Interrupt Enable Register
	//uart0->lcr = 0x03;  // Line Control Register:    8N1
	//uart0->mcr = 0x00;  // Modem Control Register

	// Setup Divisor register (Fclk / Baud)
	//uart0->div = (FCPU/(57600*16));
}

char uart1_read()
{   
	return uart1->rxtx;
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

