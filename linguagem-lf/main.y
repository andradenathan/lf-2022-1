%{
#include <stdio.h>

int yylex(void);
void yyerror(char* s);
%}

%union {
    char* name;
    int ival;
    float fval;
}

%token <ival> INT
%token <fval> FLOAT
%token<name> 
    ADD ASSIGN EQ OPAR CPAR OBRACE CBRACE EOL MULT 
    IF ELSE VAR CONST ID COLON

%type <fval> expr
%type <fval> condition
%type <fval> number
%type <fval> dec
%type <name> assign code_block code_if line program

%%

program: line
    | program line
;

line: 
    assign EOL {printf("%s\n", $1);}
    | if_ EOL {printf("if\n");} 
    | expr EOL  {printf("%g\n", $1);};

if_:
    IF OPAR condition CPAR code_if ELSE code_else
    | IF OPAR condition CPAR code_if {printf("%lf\n", $3);}
;

code_if:
    assign
    | code_block
;

code_else:
    assign EOL
    | if_
    | code_block
;

code_block:
    OBRACE line CBRACE {$$ = $2;}
;

assign:
    VAR ID {$$ = $1;}
    | VAR ID ASSIGN expr {$$ = $1;}
    | CONST ID ASSIGN expr {$$ = $1;}
;

expr: ID ASSIGN expr {$$ = $3;}
    | expr ADD expr {$$ = $1 + $3;}
    | expr MULT expr {$$ = $1 * $3;}
    | OPAR expr CPAR {$$ = $2;}
    | dec
;

condition:
    expr EQ expr {$$ = $1 == $3;}
    | expr
;

dec:
    number {$$ = $1;}
;

number: INT {$$ = (double) $1;} 
        | FLOAT
;

%%

void main(int argc, char** argv) {
    yyparse();
}

void yyerror(char *s) {
    printf("Error: %s\n", s);
}