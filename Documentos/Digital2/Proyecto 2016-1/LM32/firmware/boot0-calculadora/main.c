/////////////////////////////////////////////////////
///					          ///
///              Calculadora 32 bits.	          ///
///					          ///
/// Ejemplo: numero 1 (operador) numero 2 (enter) ///
///                                               ///
/////////////////////////////////////////////////////

#include "soc-hw.h"

// constantes

	#define igual 61
	#define espacio 32
	#define suma 43
	#define resta 45
	#define division 47
	#define multiplicacion 42
	#define enter 13
	#define min_num 47
	#define max_num 58
	#define const_res 48

int main(int argc, char **argv){

	// variables

	uint32_t numero_1;
	uint32_t numero_2; 
	uint32_t mostrar;
	uint32_t div; 
	uint32_t resultado;
	uint8_t temp;
	uint8_t ind;
	uint8_t operacion; 
	uint8_t i;
	uint8_t error;

	uart_init();
	
	for(;;){

		numero_1=0;
		numero_2=0;
		mostrar=0;
		temp=0;
		ind=0;
		operacion=0;
		div=1000000000;
		resultado=0;
		i=0;
		error=0;

		//Lee el primer numero.

		uart_putstr("\r\n/////////////////////////////////////////////////////\r");
		uart_putstr("\r\n///                                               ///\r");
		uart_putstr("\r\n///              Calculadora 32 bits.             ///\r");
		uart_putstr("\r\n///                                               ///\r");
		uart_putstr("\r\n/// Ejemplo: numero 1 (operador) numero 2 (enter) ///\r");
		uart_putstr("\r\n///                                               ///\r");
		uart_putstr("\r\n/////////////////////////////////////////////////////\r\n\n");

		do{
		
			temp=uart_getchar();
		
			if(temp>(min_num) && temp<(max_num)){
				uart_putchar(temp);
				numero_1=numero_1*10+(temp-const_res);

			}
			if(temp==multiplicacion || temp==suma || temp==resta || temp==division){
				operacion=temp;
				uart_putchar(operacion);
				ind=1;
			}
			if((temp<min_num || temp>max_num) && temp!=enter && temp!=multiplicacion && temp!=suma && temp!=resta && temp!=division ){
				uart_putstr("\r\nCaracter no válido ingrese de nuevo el primer número\r\n");
				numero_1=0;
			}
			
		}
		while(ind==0);

		ind=0;

		//Lee el segundo número.

		do{

			temp=uart_getchar();

			if(temp>min_num && temp <max_num){
				uart_putchar(temp);
				numero_2=numero_2*10+(temp-const_res);
                                
                                
			}
			if(temp==enter){
				ind=1;
			}
			if((temp<min_num || temp >max_num) && temp!=enter){
				uart_putstr("\r\nCaracter no válido ingrese de nuevo el segundo número\r\n");
				numero_2=0;
			}			

		}
		while(ind==0);

		ind=0;

		// switch donde se generan las operaciones segun sea el caso (case)
		
		switch(operacion){  

			case (resta):
				if(numero_1>=numero_2){
					resultado=numero_1-numero_2;
					uart_putchar(espacio);
					uart_putchar(igual);
					uart_putchar(espacio);
				}
				else{
					resultado=numero_2-numero_1;
					uart_putchar(espacio);
					uart_putchar(igual);
					uart_putchar(espacio);
					uart_putstr("\r\nEs un valor negativo\r\n");
					error=0;
				}
				break;
			case (suma):
				resultado=numero_1+numero_2;
				uart_putchar(espacio);
				uart_putchar(igual);
				uart_putchar(espacio);
				break;
			case (multiplicacion):
				resultado=numero_1*numero_2;
				uart_putchar(espacio);
				uart_putchar(igual);
				uart_putchar(espacio);
				break;
			case (division):
				if(numero_2==0){
					uart_putstr("\r\nError indeterminado, no se puede dividir por cero.\r\n");
					error=1;
				}
				else{
					resultado=numero_1/numero_2;
					uart_putchar(espacio);
					uart_putchar(igual);
					uart_putchar(espacio);
				}

				break;
			default:
				return 0;
				break;		

		} 
		
		// imprimir resultado

		for(i=0;i<10;i++){

			if(error==0){			

             			mostrar=resultado/div;   
             
             			if(mostrar<1 && mostrar>0){
                       			div=div/10;                             
             			}
	             		else{
					uart_putchar(mostrar+const_res);
                  			resultado=resultado-mostrar*div;
                  			div=div/10;     
             			}
             			if(div==1){
                        	    	uart_putchar(resultado+const_res);
                        	    	i=10;					
                		}
  			} 
			else{
				i=10;
			}    
		}
		
		uart_putstr("\r\nOperacion finalizada exitosamente. !\r\n");
	}
}
