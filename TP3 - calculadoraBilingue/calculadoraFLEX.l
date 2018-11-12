
%{
#include "calculadora.tab.h"
%}


%%

[1-9][0-9]*  {yylval = atoi(yytext); return DECNUM;}
0[0-7]+	{/*acá yyval = const octal*/
0[xX][0-9a-fA-F]+ { /*aca yyval = const hexadecimal*/ }
"+"     {return '+';}
"-"     {return '-';}
"*"     {return '*';}
"/"     {return '/';}
"^"     {return '^';}
"\n"    {return '\n';}

%%

