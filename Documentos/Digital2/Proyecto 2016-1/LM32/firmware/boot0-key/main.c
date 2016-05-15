#include "soc-hw.h"

int main (int argc, char **argv){

	int number = 0;

	for(;;){
		number = read_number();

		show_number(number);
	}
	
	return 0;
}
