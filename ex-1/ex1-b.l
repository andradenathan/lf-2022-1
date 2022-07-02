%{
#include <stdio.h>
#include<stdlib.h>

typedef enum _TOKEN {
    eof = -1, invalido = 0, valido = 1
} TOKEN;


%}

VALIDO [A-Z]
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
    FILE* fp = fopen("output-ex1-b.txt", "ab+");

    if((TOKEN) yylex() == valido) {
        printf("Valido\n");
        printf("A palavra %s pertence a linguagem\n", yytext);
        fprintf(fp, "%s - VALIDO\n", yytext);
    } else {
        printf("Invalido\n");
        printf("A palavra %s nao pertence a linguagem\n", yytext);
        fprintf(fp, "%s - INVALIDO\n", yytext);
    }
    
    return 0;
}