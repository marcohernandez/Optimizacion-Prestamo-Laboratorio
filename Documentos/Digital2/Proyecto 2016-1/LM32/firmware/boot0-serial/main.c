#include "soc-hw.h"

int main (int argc, char **argv){

	int number = 0;

	for(;;){

		if(number == 9){
			
			number = 0;
		}else{

			number++;
		}

		show_number(number);
		sleep(1000);
	}
	
	return 0;
}
