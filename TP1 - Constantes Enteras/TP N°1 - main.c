# include "stdio.h"

# define espacio 32
# define enter '\n'
# define escape 27

char *escribirTipo(int estado) {
    static char *tipo;
	switch (estado) {
		case 1:
			tipo = " decimal\n";
			return tipo;
		case 2:
		case 3:
			tipo = " octal\n";
			return tipo;
		case 4:
		case 6:
			tipo = " no es constante entera\n";
			return tipo;
		case 5:
			tipo = " hexadecimal\n";
			return tipo;
		case 7:
			tipo = " unsigned decimal\n";
			return tipo;
		case 8:
			 tipo = " long decimal\n";
             return tipo;
		case 9:
			tipo = " unsigned long decimal\n";
			return tipo;
        case 10:
            tipo = " unsigned octal\n";
            return tipo;
        case 11:
            tipo = " long octal\n";
            return tipo;
        case 12:
            tipo = " unsigned long octal\n";
            return tipo;
        case 13:
            tipo = " unsigned hexadecimal\n";
            return tipo;
        case 14:
            tipo = " long hexadecimal\n";
            return tipo;
        case 15:
            tipo = " unsigned long hexadecimal\n";
            return tipo;
	}
}

int definirTipo (char c) {
	switch (c) {
		case '0':
			return 0;
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
			return 1;
		case '8':
		case '9':
			return 2;
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
			return 3;
		case 'x':
		case 'X':
			return 4;
		case 'u':
		case 'U':
			return 5;
		case 'l':
		case 'L':
			return 6;
		default:
			return 7;
	}
}

int cambiarEstado (int tabla[16][8],int estado, char c) {
	int tipoCaracter = definirTipo(c);
	return tabla[estado][tipoCaracter];
}

void mostrarResultadoPorPantalla(){

	FILE *fOutput;

	fOutput = fopen ("output.txt", "r");
	char c;

	while(!feof(fOutput) ){
		c = getc(fOutput);
		printf("%c",c);
	}

	fclose(fOutput);
	return;
}

void main() {

	FILE *fInput, *fOutput;

	char caracter;
	int estado = 0;
	int tablaDeTransicion[16][8] = {
		{2, 1, 1, 6, 6, 6, 6, 6},
		{1, 1, 1, 6, 6, 7, 8, 6},
		{3, 3, 6, 6, 4, 7, 8, 6},
		{3, 3, 6, 6, 6,10,11, 6},
		{5, 5, 5, 5, 6, 6, 6, 6},
		{5, 5, 5, 5, 6,13,14, 6},
		{6, 6, 6, 6, 6, 6, 6, 6},
		{6, 6, 6, 6, 6, 6, 9, 6},
		{6, 6, 6, 6, 6, 9, 6, 6},
		{6, 6, 6, 6, 6, 6, 6, 6},
		{6, 6, 6, 6, 6, 6,12, 6},
		{6, 6, 6, 6, 6,12, 6, 6},
		{6, 6, 6, 6, 6, 6, 6, 6},
		{6, 6, 6, 6, 6, 6,15, 6},
		{6, 6, 6, 6, 6,15, 6, 6},
		{6, 6, 6, 6, 6, 6, 6, 6}
	};

	fInput = fopen ("input.txt", "r");
	fOutput = fopen("output.txt", "w");

    printf("  ARCHIVO ENTRADA : \n");
    printf("---------------------\n");

	while (!feof(fInput)) {

		caracter = getc(fInput);
        printf("%c",caracter);
		if (caracter == espacio || caracter == enter || feof (fInput)) {
			if (estado !=0)
				fputs(escribirTipo(estado), fOutput);
			estado = 0;
		} else {
			fputc(caracter, fOutput);
			estado = cambiarEstado(tablaDeTransicion, estado, caracter);
		}
	}
	fclose(fInput);
	fclose(fOutput);


    printf("\n\n  ARCHIVO SALIDA : \n");
    printf("---------------------\n");
    mostrarResultadoPorPantalla();


	return;
}
