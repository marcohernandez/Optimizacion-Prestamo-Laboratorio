#include "soc-hw.h"

int main (int argc, char **argv){

	uart_putstr("UART Funcionando\n\r");

	int contador = 0;

	for(;;){
		
		if(contador == 256){
			
			contador = 0;
		}else{

			contador++;
		}

		show_led(contador);
		sleep(1000);
	}
	return 0;
}
