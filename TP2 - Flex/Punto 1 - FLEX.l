%option noyywrap 

%{
	#include <stdio.h>
	#include <stdlib.h>
	FILE* fOutput;
%}

%%

"//"[^\n]*\n		{printf("%s \n", yytext);}
"/*"([^"/*"]|\n)*"*/" 	{printf("%s \n", yytext);}
[" "\n\t]+			{fputs(yytext, fOutput);}
.					{fputs(yytext, fOutput);};

%%

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