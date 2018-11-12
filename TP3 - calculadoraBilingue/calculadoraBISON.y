/* Calculadora de notación polaca inversa */

%{
#include <math.h>
#include <stdio.h>
#include <ctype.h>
%}

%token NUM


%% /* A continuación las reglas gramaticales y las acciones */

input:    /* vacío */
        | input line
;

line:     '\n'
        | expDEC '\n'  { printf ("\t %d\n", $1); }
		| expOCT '\n'  { printf () }	
		| expHEX '\n'  { printf () }
;

expDEC:   decNUM          		{ $$ = $1;         }
        | expDEC '+' expDEC     { $$ = $1 + $3;    }
        | expDEC '-' expDEC     { $$ = $1 - $3;    }
        | expDEC '*' expDEC     { $$ = $1 * $3;    }
        | expDEC '/' expDEC     { $$ = $1 / $3;    }
        | expDEC '^' expDEC     { $$ = pow ($1, $3); }
;

expOCT:   octNUM      		    { $$ = $1;         }
        | expOCT '+' expOCT     { $$ = $1 + $3;    }
        | expOCT '-' expOCT     { $$ = $1 - $3;    }
        | expOCT '*' expOCT     { $$ = $1 * $3;    }
        | expOCT '/' expOCT     { $$ = $1 / $3;    }
        | expOCT '^' expOCT     { $$ = pow ($1, $3); }
;

expHEX:   hexNUM       		    { $$ = $1;         }
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
