%{
#include "calculadora.tab.h"
%}


%%

[1-9][0-9]*  {yylval = atoi(yytext); return DECNUM;}
0[0-7]+	{yyval = hexaAdecimal(yytext): return OCTNUM }
0[xX][0-9a-fA-F]+ { yyval = hexaAdecimal(yytext): return HEXNUM }
"+"     {return '+';}
"-"     {return '-';}
"*"     {return '*';}
"/"     {return '/';}
"^"     {return '^';}
"\n"    {return '\n';}

%%

