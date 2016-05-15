#include "soc-hw.h"

int main (int argc, char **argv){

	char ascii = 0;

	for(;;){

		ascii = uart_getchar();
		uart_putchar(ascii);
		uart_putstr("\n\r");
		show_char(ascii);
	}
	return 0;
}
