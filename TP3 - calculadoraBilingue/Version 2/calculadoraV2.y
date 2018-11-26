%{

#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

%}

%token NUM

%left '+' '-'
%left '*' '/'
%left '^'

%% /* A continuación las reglas gramaticales y las acciones */

input:    /* vacío */
        | input line
;

line:     '\n'
		| exp '\n'  { printf ("\t Resultado en decimal : %d\n 
								\t\t Resultado en octal : %s\n 
								\t\t\t Resultado en hexadecimal : %s\n",
								$1, decimalAoctal($1), decimalAhexa($1) ); }
;

exp:   NUM          	    { $$ = $1;         }
        | exp '+' exp     { $$ = $1 + $3;    }
        | exp '-' exp     { $$ = $1 - $3;    }
        | exp '*' exp     { $$ = $1 * $3;    }
        | exp '/' exp     { $$ = $1 / $3;    }
        | exp '^' exp     { $$ = pow ($1, $3); }
		| '('exp')'	        { $$ = ($2);       }
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
}

void decimalAhexa(char *cdec, int edec){

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

int decimalAoctal(int edec){

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

yyerror (s)  /* Llamada por yyparse ante un error */
     char *s;
{
  printf ("%s\n", s);
}

main ()
{
  yyparse();
}
