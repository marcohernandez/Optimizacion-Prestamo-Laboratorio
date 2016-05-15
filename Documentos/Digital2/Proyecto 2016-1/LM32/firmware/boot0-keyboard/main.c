#include "soc-hw.h"

int main (int argc, char **argv){

	uint32_t code = 0;
	int corte = 0;
	int ready = 0;
	int esp = 0;
	int dif = 0;
	int val = 1;

	for(;;){

		code = scan_code_keyboard();

		if (code == 42){
			corte = 1;
			dif = 0;
		}
		else {	
			if (corte == 1 && dif == 0){
				esp = 1;
			}		
			if (corte == 1 && esp == 0){
				if (val == 1){
					val = 0;
				}				
				else {
					uart_putchar(code);
				}
				corte = 0;
				esp = 1;
			}
			if (code != 42){
				esp = 0;
				dif = 1;
			}
		}
	}

	return 0;
}
