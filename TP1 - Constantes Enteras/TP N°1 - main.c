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
	int tipo;
	
	fInput = fopen ("input.txt", "r");
	fOutput = fopen("output.txt", "w+");


	while (!feof(ptrArchLectura)){
		caracter = getc(ptrArchLectura);
		
		tipo = definirTipo(caracter);

		estado = transicionarEstado(cero, estado);
		
		printf ("%c", caracter);
	}

	fclose (ptrArchLectura);
	fclose (ptrArchEscritura);

	return;
}
