%{
#include <stdio.h>
#include <stdlib.h>

typedef enum _TOKEN {
    eof = -1, invalido = 0, valido = 1
} TOKEN;

%}

VALIDO [a-zA-Z\s\.\,\;\!\?\-\:]{2,}
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
    FILE* fp = fopen("output-ex2-h.txt", "ab+");
    switch(yylex()) {
        case valido:
            printf("O texto %s pertence a linguagem\n", yytext);
            fprintf(fp, "TEXTO %s - VALIDO\n", yytext);
            break;
        case invalido:
            printf("O texto %s nao e valido para a linguagem\n", yytext);
            fprintf(fp, "TEXTO %s - INVALIDO\n", yytext);
            break;
        default:
            printf("%s nao pertence a linguagem\n", yytext);
            break;
    }

    fclose(fp);

    return 0;
}