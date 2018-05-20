#include<stdio.h>

//EJERCICIO 20 B

int cadenaVacia (char *cadena) {

    if (cadena[0] == '\0')
		return 1;
    else
		return 0;
}

//EJERCICIO 21 B

int main (void) {

    char cad1[] = "Esta cadena es grande";
    char cad2[] = "";

    if (cadenaVacia(cad1))
		printf("La cadena 1 es vacia\n");
    else
		printf("La cadena 1 no es vacia, y es: \"%s\"\n", cad1);

	if (cadenaVacia(cad2))
		printf("La cadena 2 es vacia\n");
    else
		printf("La cadena 2 no es vacia %s\n", cad2);

return 0;

}
