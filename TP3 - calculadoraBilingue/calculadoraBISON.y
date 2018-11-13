

%{

#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

%}

%token DECNUM
%token HEXNUM
%token OCTNUM


%% /* A continuación las reglas gramaticales y las acciones */

input:    /* vacío */
        | input line
;

line:     '\n'
        | expDEC '\n'  { printf ("\t %d\n", $1); }
		| expOCT '\n'  { printf ("\t %s\n", decimalAoctal($1) ) }	
		| expHEX '\n'  { printf ("\t %s\n", decimalAhexa($1) ) }
;

expDEC:   HEXNUM          		{ $$ = $1;         }
        | expDEC '+' expDEC     { $$ = $1 + $3;    }
        | expDEC '-' expDEC     { $$ = $1 - $3;    }
        | expDEC '*' expDEC     { $$ = $1 * $3;    }
        | expDEC '/' expDEC     { $$ = $1 / $3;    }
        | expDEC '^' expDEC     { $$ = pow ($1, $3); }
;

expOCT:   OCTNUM      		    { $$ = $1;         }
        | expOCT '+' expOCT     { $$ = $1 + $3;    }
        | expOCT '-' expOCT     { $$ = $1 - $3;    }
        | expOCT '*' expOCT     { $$ = $1 * $3;    }
        | expOCT '/' expOCT     { $$ = $1 / $3;    }
        | expOCT '^' expOCT     { $$ = pow ($1, $3); }
;

expHEX:   HEXNUM       		    { $$ = $1;         }
        | expHEX '+' expHEX     { $$ = $1 + $3;    }
        | expHEX '-' expHEX     { $$ = $1 - $3;    }
        | expHEX '*' expHEX     { $$ = $1 * $3;    }
        | expHEX '/' expHEX     { $$ = $1 / $3;    }
        | expHEX '^' expHEX     { $$ = pow ($1, $3); }
;

%%

char caracterHexa(int ndec){

    switch(ndec){
        case 10:
            return 'A';
        case 11:
            return 'B';
        case 12:
            return 'C';
        case 13:
            return 'D';
        case 14:
            return 'E';
        case 15:
            return 'F';
        default:
            return ndec + '0';
    }
	return 0
}

void decimalAhexa(char *cdec){

    int edec = atoi(cdec);
    int pos = 0;
    int posi = 0;
    char hexainv[20];
    char chexa[20];
    char resto;
    if (edec >= 16){
    while(edec >= 16){
        resto = caracterHexa(edec % 16);
        hexainv[posi] = resto;
        posi = posi + 1;
        edec = edec - (edec % 16);
        edec = edec / 16;
    }
    hexainv[posi] = caracterHexa(edec);
    while (posi >= 0){
        chexa[pos] = hexainv[posi];
        posi = posi - 1;
        pos = pos + 1;
    }
    chexa[pos] = '\0';
    strcpy(cdec,chexa);
    }else{
    chexa[0] = caracterHexa(edec);
    chexa[1] = '\0';
    strcpy(cdec,chexa);
    }

}

int decimalAoctal(char *cdec){

    int edec = atoi(cdec);
    int eoct;
    int pos = 0;
    int posi = 0;
    char octinv[20];
    char coct[20];
    char resto;
    if (edec >= 0 && edec < 8){
        return edec;
    }
    else{
    while(edec >= 8){
        resto = edec % 8 + '0';
        octinv[posi] = resto;
        posi = posi + 1;
        edec = edec - (edec % 8);
        edec = edec / 8;
    }
    octinv[posi] = edec + '0';
    while (posi >= 0){
        coct[pos] = octinv[posi];
        posi = posi - 1;
        pos = pos + 1;
    }
    coct[pos] = '\0';
    eoct = atoi(coct);
    return eoct;
    }

}

int caracterHexaADecimal(char c){
    switch(c){
        case '0':
            return 0 ;
        case '1':
            return 1 ;
        case '2':
            return 2 ;
        case '3':
            return 3 ;
        case '4':
            return 4 ;
        case '5':
            return 5 ;
        case '6':
            return 6 ;
        case '7':
            return 7 ;
        case '8':
            return 8 ;
        case '9':
            return 9 ;
        case 'A':
        case 'a':
            return 10 ;
        case 'B':
        case 'b':
            return 11 ;
        case 'C':
        case 'c':
            return 12 ;
        case 'D':
        case 'd':
            return 13 ;
        case 'E':
        case 'e':
            return 14 ;
        case 'F':
        case 'f':
            return 15 ;
        case '\n':
        case '\0':
            return 0 ;
        break;
    }
    return 0 ;
}
int caracterOctalADecimal(char c){
    switch(c){
        case '0':
            return 0 ;
        case '1':
            return 1 ;
        case '2':
            return 2 ;
        case '3':
            return 3 ;
        case '4':
            return 4 ;
        case '5':
            return 5 ;
        case '6':
            return 6 ;
        case '7':
            return 7 ;
        case '8':
            return 8 ;
        case '\n':
        case '\0':
            return 0 ;
        break;
    }
    return 0 ;
}
int longitudCadena(char cadena[]){
    int contador = 0 ;
    while(cadena[contador]!='\0'){
        contador++ ;
    }
    return contador ;
}
int hexaAdecimal(char cadena[]){ // convierte un string del tipo [a-a]{2}[a-fA-F0-9]* a decimal
    int punteroFinDeCadena = longitudCadena(cadena) - 3 ;
    int posicionReal = punteroFinDeCadena ;
    int posicionPuntero = 2 ;
    int numHexadecimal = 0 ;
    while (posicionReal>=0) { // se saltea el 0x
        numHexadecimal += caracterHexaADecimal(cadena[posicionPuntero]) * pow(16,posicionReal);
        posicionPuntero++ ;
        posicionReal-- ;
    }

    return numHexadecimal ;
}
int octalAdecimal(char cadena[]){
    int punteroFinDeCadena = longitudCadena(cadena) - 2 ; //1 porque está la posicion 0 + 1 p/caracter 0 con el que empieza todo octal
    int posicionReal = punteroFinDeCadena ;
    int posicionPuntero = 1 ; //porque todo octal empieza en 0
    int numOctal = 0 ;
    while (posicionReal>=0) {
        numOctal += caracterOctalADecimal(cadena[posicionPuntero]) * pow(8,posicionReal);
        posicionPuntero++ ;
        posicionReal-- ;
    }
    return numOctal ;
}

yyerror (s)  /* Llamada por yyparse ante un error */
     char *s;
{
  printf ("%s\n", s);
}

main ()
{
  yyparse();
}
