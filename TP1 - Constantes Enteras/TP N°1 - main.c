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
		    tipo = " octal\n";
			return tipo;
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
		case 10:
			tipo = " unsigned long decimal\n";
			return tipo;
        case 11:
            tipo = " unsigned octal\n";
            return tipo;
        case 12:
            tipo = " long octal\n";
            return tipo;
        case 13:
        case 14:
            tipo = " unsigned long octal\n";
            return tipo;
        case 15:
            tipo = " unsigned hexadecimal\n";
            return tipo;
        case 16:
            tipo = " long hexadecimal\n";
            return tipo;
        case 17:
        case 18:
            tipo = " unsigned long hexadecimal\n";
            return tipo;
	}
}

int cambiarEstado (int estado, char c) {
	switch (estado) {
		case 0:
			if (c == '0')
				return 2;
			else if (c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7' || c == '8' || c == '9')
				return 1;
			else
				return 6;
		case 1:
			if (c == '0' || c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7' || c == '8' || c == '9')
				return 1;
			else if (c == 'u' || c == 'U')
				return 7;
			else if (c == 'l' || c == 'L')
				return 8;
			else
				return 6;
		case 2:
			if (c == '0' || c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7')
				return 3;
			else if (c == 'x' || 'X')
				return 4;
			else if (c == 'u' || c == 'U')
				return 11;
			else if (c == 'l' || c == 'L')
				return 12;
			else
				return 6;
		case 3:
			if (c == '0' || c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7')
				return 3;
			else if (c == 'u' || c == 'U')
				return 11;
			else if (c == 'l' || c == 'L')
				return 12;
			else
				return 6;
		case 4:
			if (c == '0' || c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7' || c == '8' || c == '9' || c == 'a' || c == 'A' || c == 'b' || c == 'B' || c == 'c' || c == 'C' || c == 'd' || c == 'D' || c == 'e' || c == 'E' || c == 'f' || c == 'F')
				return 5;
			else
				return 6;
		case 5:
			if (c == '0' || c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7' || c == '8' || c == '9' || c == 'a' || c == 'A' || c == 'b' || c == 'B' || c == 'c' || c == 'C' || c == 'd' || c == 'D' || c == 'e' || c == 'E' || c == 'f' || c == 'F')
				return 5;
			else if (c == 'u' || c == 'U')
				return 15;
			else if (c == 'l' || c == 'L')
				return 16;
			else
				return 6;
		case 7:
			if (c == 'l' || c == 'L')
				return 9;
			else
				return 6;
		case 8:
			if (c == 'u' || c == 'U')
				return 10;
			else
				return 6;
		case 11:
			if (c == 'l' || c == 'L')
				return 13;
			else
				return 6;
		case 12:
			if (c == 'u' || c == 'U')
				return 14;
			else
				return 6;
		case 15:
			if (c == 'l' || c == 'L')
				return 17;
			else
				return 6;
		case 16:
			if (c == 'u' || c == 'U')
				return 18;
			else
				return 6;
		default:
			return 6;
	}
}

void main() {

	FILE *fInput, *fOutput;

	char caracter;
	int estado = 0;

	fInput = fopen ("input.txt", "r");
	fOutput = fopen("output.txt", "w");

	while (!feof(fInput)) {

		caracter = getc(fInput);
        printf(&caracter);
		if (caracter == espacio || caracter == enter || feof (fInput)) {
			if (estado !=0)
				fputs(escribirTipo(estado), fOutput);
			estado = 0;
		} else {
			fputc(caracter, fOutput);
			estado = cambiarEstado(estado, caracter);
		}
	}

	fclose(fInput);
	fclose(fOutput);

	return;
}
