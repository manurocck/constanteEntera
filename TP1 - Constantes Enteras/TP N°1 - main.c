typedef enum { false, true } bool; //para usar booleanos

# include "stdio.h"


//Son los valores que tienen en la tabla ascii (en decimales)
# define espacio 32
# define enter '\n'
# define escape 27 
//Códigos para cada tipo de variable
# define cero -1
# define digOct -2
# define unoDe89 -3
# define letHex -4
# define equis -5
# define otro -99

int definirTipo(char caracter){ //definir dentro de que clase de digito entra (columnas de la tabla de transiciones)
	switch(caracter){
			case '0':
				return cero;
				break;
			
			case '1':
			case '2':
			case '3':
			case '5':
			case '6':
			case '7':
				return digOct;
				break;
				
			case '8':
			case '9':
				return unoDe89;
				break;
				
			case 'a':
			case 'b':
			case 'c':
			case 'd':
			case 'e':
			case 'f':
			case 'A':
			case 'B':
			case 'C':
			case 'D':
			case 'E':
			case 'F':
				return letHex;
				break;
			
			case 'x':
			case 'X':
				return equis;
				break;
			
			case espacio:
				return espacio;
				break;
			
			default:
				return otro;
				break;
	}
	return -1000;
}

int transicionEstado(int tipo, int estado){ // completado con la tabla de transiciones. devuelve el nuevo estado
	int nuevoEstado = -6; //estado de rechazo
	
	switch(tipo){
		case cero :
			if(estado == 1 || estado == 3 || estado == 5)
				nuevoEstado = estado;
			else{
				if(estado == 0)
					nuevoEstado = 2;
				else
					nuevoEstado = estado + 1;
				}
			break;

		case digOct :
			if(estado == 1 || estado == 3 || estado == 5)
				nuevoEstado = estado;
			else
				nuevoEstado = estado + 1;
			break;
		
		case unoDe89 :
			if(estado == 0 || estado == 1)
				nuevoEstado = 1;
			else if(estado == 2 || estado == 3)
				nuevoEstado = -6;
			else
				nuevoEstado = 5;
			break;
		
		case letHex :
			if(estado == 4 || estado == 5)
				nuevoEstado = 5;
			else
				nuevoEstado = -6;
			break;
		
		case equis :
			if(estado == 2)
				nuevoEstado = estado + 2;
			break;
		
		default:
			break;
			
	}
	
	return nuevoEstado;
}

void main(){
	
	FILE *fInput;
	FILE *fOutput;
	
	char caracter;
	int tipo, estado=0, i=0;
	bool finPalabra = false, finRenglon = false, terminarPalabra = false;
	
	char noConstante[24] = " No es constante entera";
	char cteDecimal[9] = " Decimal";
	char cteOctal[7] = " Octal";
	char cteHexa[13] = " Hexadecimal";
	
	fInput = fopen ("input.txt", "r");
	fOutput = fopen("output.txt", "w");


	while (!feof(fInput)){
		caracter = getc(fInput);
		tipo = definirTipo(caracter);

		switch(tipo){
			case cero:
			case digOct:
				estado = transicionarEstado(tipo, estado);
				break;
			case unoDe89:
				if(estado != 2 || estado !=3 )
					estado = transicionarEstado(tipo, estado);
				else
					terminarPalabra = true;
				break;
			case letHex:
				if(estado == 4 || estado == 5 )
					estado = transicionarEstado(tipo, estado);
				else
					terminarPalabra = true;
				break;
			case equis:
				if(estado == 2 )
					estado = transicionarEstado(tipo, estado);
				else
					terminarPalabra = true;
				break;
			case espacio: 
				finPalabra = true;
				break;
			default:

				while(!feof(fInput) && tipo != espacio){ //termina de escribir la palabra 
					fwrite(caracter,sizeof(char),1,fOutput);
					caracter = getc(fInput);
					tipo = definirTipo(caracter);
				}
				
				do{ //escribe " No es constante entera", seguido de la palabra
					fwrite(noConstante[i],sizeof(char),1,fOutput);
					i++;
				}while(noConstante[i] != '\0');
				i=0;

				fwrite('\n',sizeof(char),1,fOutput); //escribir salto de línea
				
				finRenglon = true;
				
				break;
		}
		
		if(!finRenglon || feof(fInput)){			
			if(!finPalabra)
				fwrite(caracter,sizeof(char),1,fOutput);
			else{
				if(estado == 2 || estado == 3){
					do{ //escribe " Octal" seguido de la palabra
						fwrite(cteOctal[i],sizeof(char),1,fOutput);
						i++;
					}while(cteOctal[i] != '\0');
				}else if(estado == 1){
					do{ //escribe " Decimal" seguido de la palabra
						fwrite(cteDecimal[i],sizeof(char),1,fOutput);
						i++;
					}while(cteDecimal[i] != '\0');
				}else{
					do{ //escribe " Hexadecimal" seguido de la palabra
						fwrite(cteHexa[i],sizeof(char),1,fOutput);
						i++;
					}while(cteHexa[i] != '\0');
				}
				i=0;
				fwrite('\n',sizeof(char),1,fOutput); //escribir salto de línea
				
				finPalabra = false;
			}
		}
		else //se reinicia para leer una nueva palabra
			finRenglon = false;
		
	}

	fclose (ptrArchLectura);
	fclose (ptrArchEscritura);

	return;
}
