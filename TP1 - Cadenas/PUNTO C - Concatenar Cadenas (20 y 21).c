#include<stdio.h>

//EJERCICIO 20 C

void concatenarCadenas (char* unaCadena, const char* otraCadena) {

    int i, j;
    i = 0;
    j = 0;

    while(unaCadena[i]!='\0'){
        i++;
    }

    while(otraCadena[j]!='\0'){
        unaCadena[i] = otraCadena[j];
        j++;
        i++;
    }

	unaCadena[i]='\0';

	return;
}

//EJERCICIO 21 C

int main (void) {

    char cad1[30] = "Primera parte";
    char cad2[] = "Segunda parte";

    concatenarCadenas(cad1, cad2);

	printf ("La cadena concatenada es: %s\n", cad1);

    return 0;

}

