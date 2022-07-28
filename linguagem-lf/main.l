%{
#include "main.tab.h"
%}

%%

<<EOF>> {return feof;}

<INITIAL>{
[iI][fF] {yylval.name = "if"; return IF;}
[eE][lL][sS][eE] {yylval.name = "else"; return ELSE;}
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
";" {yylval.name = ";"; return EOL;}
[ \s\t\n]+ ;
. ;
}

%%