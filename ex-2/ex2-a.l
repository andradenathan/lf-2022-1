%{
#include <stdio.h>
#include <stdlib.h>

typedef enum _TOKEN {
    eof = -1, invalido = 0, valido = 1
} TOKEN;

%}

VALIDO [a-zA-Z]{6,8}
INVALIDO (.|[\n])

%%

<<EOF>> { return eof; }
{VALIDO} { return valido; }
{INVALIDO} { return invalido; }

%%

/*Function yywrap is called by lex when input is exhausted.
Return 1 if you are done or 0 if more processing is required.*/
int yywrap(void) { return 1; }

int main() {
    if((TOKEN) yylex() == valido) {
        printf("A senha %s pertence a linguagem.\n", yytext);
    } else {
        printf("A senha %s e invalida\n.", yytext);
    }
    
    return 0;
}