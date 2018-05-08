#include<stdio.h>

//EJERCICIO 20 A

int tamCadena (char *cadena) {

    int tam=0, i;
    for(i=0; cadena[i]!= '\0'; i++);
        tam = i;

    return tam;
}

//EJERCICIO 21 A

int main (void) {

    char cad1[] = "longitud 11";
    char cad2[] = "";
    char cad3[] = " ";

    printf("La cadena 1 es de tamanio: %u\n", tamCadena(cad1));
    printf("La cadena 2 es de tamanio: %u\n", tamCadena(cad2));
    printf("La cadena 3 es de tamanio: %u\n", tamCadena(cad3));

return 0;

}
