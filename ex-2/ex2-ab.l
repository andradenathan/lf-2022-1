%{
#include <stdio.h>
#include <stdlib.h>

typedef enum _TOKEN {
    eof = -1, invalido = 0, senha_valida = 1, tel_valido = 2
} TOKEN;

%}

SENHA_VALIDA [a-zA-Z]{6,8}
TEL_VALIDO 9[0-9]{8}
INVALIDO (.|[\n])

%%

<<EOF>> { return eof; }
{SENHA_VALIDA} { return senha_valida; }
{TEL_VALIDO} { return tel_valido; }
{INVALIDO} { return invalido; }

%%

/*Function yywrap is called by lex when input is exhausted.
Return 1 if you are done or 0 if more processing is required.*/
int yywrap(void) { return 1; }

int main() {
    switch(yylex()) {
        case senha_valida:
            printf("A senha %s pertence a linguagem\n", yytext);
            break;
        case tel_valido:
            printf("O telefone %s e valido\n", yytext);
            break;
        case invalido:
            printf("%s nao e valido para nenhuma linguagem\n", yytext);
            break;
        default:
            printf("%s nao pertence a nenhuma linguagem\n", yytext);
            break;
    }

    return 0;
}