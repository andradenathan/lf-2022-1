%{
#include "main.tab.h"
#include <stdio.h>

%}

%%

<<EOF>> {return EOF;}

<INITIAL>{
[iI][fF] {yylval.name = "if"; return IF;}
[eE][lL][sS][eE] {yylval.name = "else"; return ELSE;}
[wW][hH][iI][lL][eE] {yylval.name = "while"; return WHILE;}
[fF][nN] {yylval.name = "fn"; return FUNCTION;}
[rR][eE][tT][uU][rR][nN] {yylval.name = "return"; return RETURN;}
[iI][nN][tT] {yylval.name = "int"; return INT_TYPE;}
[fF][lL][oO][aA][tT] {yylval.name = "float"; return FLOAT_TYPE;}
[bB][oO][oO][lL] {yylval.name = "bool"; return BOOL_TYPE;}
[tT][rR][uU][eE] {yylval.name = "true"; return TRUE;}
[fF][aA][lL][sS][eE] {yylval.name = "false"; return FALSE;}
[0-9][.][0-9]+ {yylval.fval = atof(yytext); return FLOAT;}
0|[1-9][0-9]* {yylval.ival = atoi(yytext); return INT;}
[vV][aA][rR] {yylval.name = "var"; return VAR;}
[cC][oO][nN][sS][tT] {yylval.name = "const"; return CONST;}
[a-zA-Z_][a-zA-Z0-9_]* {yylval.name = yytext; return ID;}
"+" {yylval.name = "+"; return ADD;}
"*" {yylval.name = "*"; return MULT;}
"=" {yylval.name = "="; return ASSIGN;}
"==" {yylval.name = "=="; return EQ;}
"(" {yylval.name = "("; return OPAR;}
")" {yylval.name = ")"; return CPAR;}
"{" {yylval.name = "{"; return OBRACE;}
"}" {yylval.name = "}"; return CBRACE;}
":" {yylval.name = ":"; return COLON;}
"," {yylval.name = ","; return COMMA;}
";" {yylval.name = ";"; return EOL;}
[ \s\t\n]+ ;
. ;
}

%%