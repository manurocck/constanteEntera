%{
#include "calculadoraBISON.tab.h"
#include <math.h>
#include <stdio.h>
#include <ctype.h>
%}

%%

[1-9][0-9]*  {yylval = atoi(yytext); return NUM; }
0[0-7]+	{yylval = octalAdecimal(yytext); return NUM; }
0[xX][0-9a-fA-F]+ { yylval = hexaAdecimal(yytext); return NUM; }
"+"     {return '+';}
"-"     {return '-';}
"*"     {return '*';}
"/"     {return '/';}
"^"     {return '^';}
"("	{return '(';}
")"	{return ')';}
"\n"    {return '\n';}

%%

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
