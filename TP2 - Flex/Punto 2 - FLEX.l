%option noyywrap 

%{
	#include <stdio.h>
	#include <stdlib.h>
	FILE* fOutput;
	char cambiarCAPSlock (char c);
%}

%%

[a-zA-Z]		{putc(cambiarCAPSlock(yytext[0]),fOutput);}
[" "\n\t]+		{fputs(yytext, fOutput);}
.				{fputs(yytext, fOutput);};

%%

char cambiarCAPSlock (char c){
	if ( c>='a' && c<='z' ){
		return (c-32);
	}else if ( c>='A' && c<='Z' ){
		return (c+32);
	}else
		return 0;
}

int main(){
	
	fOutput = fopen("output.txt","w");
	yyin = fopen("input.txt","r");
	
	yylex();
		
	fclose(fOutput);
	//yyout guarda todo lo que matcheó con una regla
	//yylex{} retorna 0 cuando llega al fin de archivo
	//yylval variable global int 
	//yytext variable global *char con contenido emparejado en ultimo analisis
	//yyleng variable global int con la longitud de la cadena yytext
	//si una cadena no cumple con ninguna regla, se devuelve por pantalla
	//yytext guarda lo último que leyó de la última regla aplicada

	return 0;
}