%{
#include <math.h>
#include <stdio.h>
#include <ctype.h>
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

yyerror (s)  /* Llamada por yyparse ante un error */
     char *s;
{
  printf ("%s\n", s);
}

main ()
{
  yyparse ();
}
