%{
#include "calculadoraBISON.tab.h"
#include <math.h>
#include <stdio.h>
#include <ctype.h>
%}

%%

[1-9][0-9]*  { return DECNUM; }
0[0-7]+	{ return OCTNUM; }
0[xX][0-9a-fA-F]+ { return HEXNUM; }
"+"     {return '+';}
"-"     {return '-';}
"*"     {return '*';}
"/"     {return '/';}
"^"     {return '^';}
"\n"    {return '\n';}

%%

