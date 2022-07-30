%{
#include <stdio.h>
#define YYDEBUG 1
int yylex();
extern FILE* yyin;
FILE* out;
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
    IF ELSE VAR CONST ID COLON COMMA WHILE FUNCTION RETURN
    INT_TYPE FLOAT_TYPE BOOL_TYPE TRUE FALSE

%type <fval> expr
%type <fval> condition
%type <fval> number
%type <fval> dec
%type <name> 
    assign  code_block block 
    line program test while_
    function_ return_ params args type

%%

program: line
    | program line
;

line: 
    assign EOL {printf("%s\n", $1);}
    | if_ {printf("if\n");} 
    | while_ {printf("while\n");}
    | expr EOL {printf("%g\n", $1);}
    | function_ {printf("function\n");}
;

function_:
    FUNCTION ID OPAR params CPAR COLON type code_block 
;

return_:
    RETURN expr EOL {printf("return\n");}
;

params: args {printf("parasm: %s\n", $1);}
    | 
;

args:
    ID COLON type COMMA args
    | ID COLON type {printf("args: %s\n", $1);}
;

type:
    INT_TYPE 
    | FLOAT_TYPE
    | BOOL_TYPE
;

while_:
    WHILE OPAR condition CPAR block 
;

if_:
    IF OPAR condition CPAR block ELSE code_else
    | IF OPAR condition CPAR block {printf("%lf\n", $3);}
;

block:
    assign EOL
    | code_block
;

code_else:
    assign EOL
    | if_
    | code_block
;

code_block:
    OBRACE test CBRACE {$$ = $2;}
;

test:
    line 
    | return_
    | line test
    | line test return_
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
    // yydebug = 1;
    // yyin = fopen(argv[1], "r");
    // FILE* out = fopen("./bison_out.txt", "w");

    // do {
    //     yyparse();
    //     fprintf(out, "%s\n", yylex());
    // } while(!feof(yyin));
}

void yyerror(char *s) {
    printf("Error: %s\n", s);
}