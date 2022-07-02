%{
#include <stdio.h>
#include <stdlib.h>

typedef enum _TOKEN {
    eof = -1, invalido = 0, senha_valida = 1
} TOKEN;

%}

SENHA_VALIDA (([a-zA-Z])*([a-z][A-Z])+([a-zA-Z])*)*|([a-zA-Z])*([A-Z][a-z])+([a-zA-Z])*
INVALIDO (.|[\n])

%%

<<EOF>> { return eof; }
{SENHA_VALIDA} { return senha_valida; }
{INVALIDO} { return invalido; }

%%

/*Function yywrap is called by lex when input is exhausted.
Return 1 if you are done or 0 if more processing is required.*/
int yywrap(void) { return 1; }

int main() {
    FILE* fp = fopen("output-ex2-d.txt", "ab+");
    switch(yylex()) {
        case senha_valida:
            printf("A senha %s pertence a linguagem\n", yytext);
            fprintf(fp, "SENHA %s - VALIDA\n", yytext);
            break;
        case invalido:
            printf("A senha %s nao e valido para nenhuma linguagem\n", yytext);
            break;
        default:
            printf("%s nao pertence a nenhuma linguagem\n", yytext);
            break;
    }

    return 0;
}