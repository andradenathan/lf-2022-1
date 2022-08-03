%{
#include "parser.tab.h"
#include <stdio.h>

int comment = 0;
%}

%x STATE_COMMENT

%%

<INITIAL>{
[iI][fF] {yylval.name = "if"; return IF;}
[eE][lL][sS][eE] {yylval.name = strdup(yytext); return ELSE;}
[wW][hH][iI][lL][eE] {yylval.name = strdup(yytext); return WHILE;}
[fF][nN] {yylval.name = strdup(yytext); return FUNCTION;}
[rR][eE][tT][uU][rR][nN] {yylval.name = strdup(yytext); return RETURN;}
[iI][nN][tT] {yylval.name = strdup(yytext); return INT_TYPE;}
[fF][lL][oO][aA][tT] {yylval.name = strdup(yytext); return FLOAT_TYPE;}
[bB][oO][oO][lL] {yylval.name = strdup(yytext); return BOOL_TYPE;}
[tT][rR][uU][eE] {yylval.name = strdup(yytext); return TRUE;}
[fF][aA][lL][sS][eE] {yylval.name = strdup(yytext); return FALSE;}
[0-9][.][0-9]+ {yylval.fval = atof(yytext); return FLOAT;}
0|[1-9][0-9]* {yylval.ival = atoi(yytext); return INT;}
[vV][aA][rR] {yylval.name = strdup(yytext); return VAR;}
[cC][oO][nN][sS][tT] {yylval.name = strdup(yytext); return CONST;}
[a-zA-Z_][a-zA-Z0-9_]* {yylval.name = strdup(yytext); return ID;}
"+" {yylval.name = "+"; return ADD;}
"*" {yylval.name = "*"; return MULT;}
"=" {yylval.name = "="; return ASSIGN;}
"/*"    { BEGIN(STATE_COMMENT); }
"//".* ;
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

<STATE_COMMENT>{
"/*"           { ++comment; }
"*/"        { if (comment) --comment;
                else { BEGIN(INITIAL); } }
"*"+          
[^/*\n]+        
"//".*         
[/]            
\n                 
}

%%