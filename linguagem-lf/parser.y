%{
#include <stdio.h>

extern int yylex();
extern void yyerror(char* s);
extern char* yytext;
extern FILE* yyin;

FILE* out;
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
%type <fval> numtype
%type <fval> number
%type <name> 
    assign  code_block block 
    line program lines while_
    function_ return_ params args type

%left ADD MULT

%%

program: line {fprintf(out, "program -> line\n");}
    | program line {fprintf(out, "program -> program line\n");}
;

line: 
    assign EOL {fprintf(out, "line -> assign %s\n", $2);}
    | if_ {fprintf(out,"line -> if_\n");} 
    | while_ {fprintf(out,"line -> while_\n");}
    | expr EOL {fprintf(out,"line -> expr %s\n", $2);}
    | function_ EOL {fprintf(out,"line -> function_ %s\n", $2);}
;

function_:
    FUNCTION ID OPAR params CPAR COLON type code_block 
    {fprintf(out,"function -> %s %s %s params %s %s type code_block\n", $1, $2, $3, $4, $5);}
;

return_:
    RETURN expr EOL {fprintf(out, "return -> %s expr %s\n", $1, $3);}
;

params: args {fprintf(out,"params -> args\n");}
    | {fprintf(out,"params -> epsilon\n");}
;

args:
    ID COLON type COMMA args {fprintf(out,"args -> %s %s type %s args\n", $1, $2, $4);}
    | ID COLON type {fprintf(out,"args -> %s %s type\n", $1, $2);}
;

type:
    INT_TYPE {fprintf(out,"type -> %s\n", $1);}
    | FLOAT_TYPE {fprintf(out,"type -> %s\n", $1);}
    | BOOL_TYPE {fprintf(out,"type -> %s\n", $1);}
;

while_:
    WHILE OPAR condition CPAR block {fprintf(out,"while -> %s %s condition %s block\n", $1, $2, $4);}
;

if_:
    IF OPAR condition CPAR block ELSE code_else {fprintf(out,"if -> %s%s condition %s block %s code_else\n", $1, $2, $4, $6);}
    | IF OPAR condition CPAR block {fprintf(out,"if -> %s%s condition %s block\n", $1, $2, $4);}
;

block:
    assign EOL {fprintf(out,"block -> assign %s\n", $2);}
    | return_ {fprintf(out,"block -> return\n");}
    | code_block {fprintf(out,"block -> code_block\n");}
;

code_else:
    assign EOL {fprintf(out,"code_else -> return %s\n", $2);}
    | if_ {fprintf(out,"code_else -> if\n");}
    | code_block {fprintf(out,"code_else -> code_block\n");}
;

code_block:
    OBRACE lines CBRACE {fprintf(out, "code_block -> %s lines %s\n", $1, $3);}
;

lines:
    line {fprintf(out, "lines -> line\n");}
    | return_ {fprintf(out, "lines -> return\n");}
    | line lines {fprintf(out, "lines -> line lines\n");}
    | line lines return_ {fprintf(out, "lines -> line lines return_\n");}
;

assign:
    VAR ID COLON type {fprintf(out, "assign -> %s %s %s type\n", $1, $2, $3);}
    | VAR ID COLON type ASSIGN expr {fprintf(out, "assign -> %s %s %s type %s expr\n", $1, $2, $3, $5);}
    | CONST ID COLON type ASSIGN expr {fprintf(out,"assign -> %s %s %s type %s expr\n", $1, $2, $3, $5);}
;

expr: ID ASSIGN expr {fprintf(out, "expr -> %s %s expr\n", $1, $2);}
    | expr ADD expr {fprintf(out,"expr -> expr %s expr\n", $2);}
    | expr MULT expr {$$ = $1 * $3; fprintf(out,"expr -> expr %s expr\n", $2);}
    | OPAR expr CPAR {$$ = $2; fprintf(out,"expr -> %s expr %s\n", $1, $3);}
    | number {fprintf(out, "expr -> number\n");}
;

condition:
    expr EQ expr {$$ = $1 == $3; fprintf(out,"condition -> expr %s expr\n", $2);}
    | ID EQ expr {fprintf(out,"condition -> %s %s expr\n", $1, $2);}
    | expr {fprintf(out,"condition -> expr\n");}
;

number:
    numtype {$$ = $1; fprintf(out,"number -> %g\n", $1);}
;

numtype: INT {$$ = (double) $1; fprintf(out,"numtype -> %d\n", $1);} 
        | FLOAT {fprintf(out,"numtype -> %lf\n", $1);}
;

%%

void main(int argc, char** argv) {
    yyin = fopen(argv[1], "r");
    out = fopen("./out.txt", "w");
    yyparse();
}

void yyerror(char *s) {
    printf("Error: %s\n", s);
}