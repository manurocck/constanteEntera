# include "stdio.h"
void main()
{
FILE *ptrArchLectura;
FILE *ptrArchEscritura;
char caracter;

ptrArchLectura = fopen ("input.txt", "r");
ptrArchEscritura = fopen("output.txt", "w+");


while (!feof(ptrArchLectura))
{
    caracter = getc(ptrArchLectura);
    printf ("%c", caracter);
}

fclose (ptrArchLectura);
fclose (ptrArchEscritura);

return;
}
