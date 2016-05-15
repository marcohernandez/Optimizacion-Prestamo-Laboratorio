#include "soc-hw.h"

char resultado[40];

//UI
void init(){

	uart_putstr("\r\n          **** Calculadora ****\n\n\r");
	uart_putstr("\r\nIngrese la operación de la forma: Num1+Num2\n\r\n");	
}

void printError(char type){

	if(type == 48){

		uart_putstr("\nError: No puede dividir por 0.\n\n\r");
	}else{
		uart_putstr("\n\rError: caracter no reconocido.\n\n\r");
	}
}

void printResult (uint32_t equal, int negative){

	int i,firstZero;
	firstZero = 0;
	
	if(equal == 0){

		uart_putstr("\n\n\r = 0");
	}
	uart_putstr("\n\n\r = ");

	if(negative == 1){

		uart_putstr("-");	
	}
	for(i = 0; i < 40; i = i+4){

		if((resultado[i] != '0')||(firstZero == 1)){

			firstZero = 1;
			uart_putchar(resultado[i]);
		}
	}
	uart_putstr("\n\n\n\r");
}

//Process
uint32_t getValue(uint8_t str[40]){
	
	int i;
	uint32_t value = 0;
	uint32_t digits[40];
	
	for(i = 0; i < 40; i = i+4){
		
		digits[i] = str[i] - 48;
	}
	digits[0] = (digits[0])*1000000000;
	digits[4] = (digits[4])*100000000;
	digits[8] = (digits[8])*10000000;
	digits[12] = (digits[12])*1000000;
	digits[16] = (digits[16])*100000;
	digits[20] = (digits[20])*10000;
	digits[24] = (digits[24])*1000;
	digits[28] = (digits[28])*100;
	digits[32] = (digits[32]*10);
	
	for(i = 0; i < 40; i = i+4){

		value = value + digits[i];
	}	
	return value;	
}

void toAscii(uint32_t value){

	resultado[0] = value/1000000000;
	value = value - (resultado[0]*1000000000);
	resultado[4] = value/100000000;
	value = value - (resultado[4]*100000000);
	resultado[8] = value/10000000;
	value = value - (resultado[8]*10000000);
	resultado[12] = value/1000000;
	value = value - (resultado[12]*1000000);
	resultado[16] = value/100000;
	value = value - (resultado[16]*100000);
	resultado[20] = value/10000;
	value = value - (resultado[20]*10000);
	resultado[24] = value/1000;
	value = value - (resultado[24]*1000);
	resultado[28] = value/100;
	value = value - (resultado[28]*100);
	resultado[32] = value/10;
	value = value - (resultado[32]*10);
	resultado[36] = value/1;
	value = value - (resultado[36]*1);	

	resultado[0] = resultado[0] + 48;
	resultado[4] = resultado[4] + 48;
	resultado[8] = resultado[8] + 48;
	resultado[12] = resultado[12] + 48;
	resultado[16] = resultado[16] + 48;
	resultado[20] = resultado[20] + 48;
	resultado[24] = resultado[24] + 48;
	resultado[28] = resultado[28] + 48;
	resultado[32] = resultado[32] + 48;
	resultado[36] = resultado[36] + 48;
}

int main (int argc, char **argv){

	for(;;){

		init();

		uint32_t num1,num2,equal;			
		char oper = 0;
				
		//Booleanos
		int getNumber = 1;
		int error = 0;
		int negative = 0;
		
		uint8_t str[40];	
		int i;	

		for( i = 0; i < 40; i = i+4){

			str[i] = 48;		
		}	
		char tec;		
		
		while(getNumber == 1){

			tec = uart_getchar();
			uart_putchar(tec);

			if((tec < 42)||(tec > 57)){
				
				printError(100);
				
				for(i = 0; i < 40; i = i+4){
					str[i] = 48;
				}							
			}else{
				if((tec == 42)||(tec == 43)||(tec == 45)||(tec == 47)){
			
					oper = tec;	
					getNumber = 0;					
				}else{				
					for(i = 0; i < 36; i = i+4){
			
						str[i] = str[i+4];
					}
					str[36] = tec;
				}
			}			
		}
		num1 = getValue(str);
		getNumber = 1;	

		for( i = 0; i < 40; i = i+4){

			str[i] = 48;		
		}	
		while(getNumber == 1){

			tec = uart_getchar();
			uart_putchar(tec);

			if(((tec < 48)||(tec > 57))&&(tec!=13)){

				printError(100);
				error = 1;
				getNumber = 0;					
			}else{
				if(tec == 13){

					getNumber = 0;
				}else{					
					for(i = 0; i < 36; i = i+4){
			
						str[i] = str[i+4];
					}
					str[36] = tec;					
				}
			}						
		}
		num2 = getValue(str);	
		
		if(error!=1){			

			switch(oper){
		
				case '+':equal = num1 + num2;
					break;

				case '-':
					if(num2 > num1){
	
						equal = num2 - num1;
						negative = 1;
					}else{
						equal = num1 - num2;
					}
					break;

				case '*':equal = num1 * num2;
					break;

				case '/':
					
					if(num2 == 0){

						printError(48);
						error = 1;
					}else{
						equal = num1/num2;
					}					
					break;
			}
			if(error!=1){			
				toAscii(equal);
				printResult(equal,negative);	
			}		
		}
	}
	return 0;
}
