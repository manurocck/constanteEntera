%{
#include "calculadoraBISON.tab.h"
#include <math.h>
#include <stdio.h>
#include <ctype.h>
%}

%%

[1-9][0-9]*  {yyval = atoi(yytext); return DECNUM;}
0[0-7]+	{yyval = octalAdecimal(yytext): return OCTNUM }
0[xX][0-9a-fA-F]+ { yyval = hexaAdecimal(yytext): return HEXNUM }
"+"     {return '+';}
"-"     {return '-';}
"*"     {return '*';}
"/"     {return '/';}
"^"     {return '^';}
"\n"    {return '\n';}

%%
