%{  
#include <stdio.h>
#include <stdlib.h>

typedef enum Token {
    eof = -1, 
    invalid = 0,
    _id = 1,
    _int = 2,
    _float = 3,
    _comment = 4,
    _if = 5,
    _else = 6,
    _while = 7,
    _true = 8,
    _false = 9,
    _op = 10,
    _function = 11,
    _return = 12,
    _int_type = 13,
    _float_type = 14,
    _equal = 15,
    _open_par = 16,
    _close_par = 17,
    _open_brace = 18,
    _close_brace = 19,
    _end_of_line = 20
} Token;
%}

ID [a-zA-Z_]|[a-zA-Z0-9_]
INT [1-9]+[0-9]*|0
FLOAT [0-9].[0-9]+
OP [\+\*\==]
COMMENT ("/*"([^*]|\*+[^*/])*\*+"/")|"//".*
IF [iI][fF]
ELSE [eE][lL][sS][eE]
WHILE [wW][hH][iI][lL][eE]
FUNCTION [fF][nN]
RETURN [rR][eE][tT][uU][rR][nN]
INT_TOKEN [iI][nN][tT]
FLOAT_TOKEN [fF][lL][oO][aA][tT]
TRUE [tT][rR][uU][eE]
FALSE [fF][aA][lL][sS][eE]
WHITESPACE [ \t\n]*

%%

<<EOF>> {return eof;}
{ID} {return _id;}
{INT} {return _int;}
{FLOAT} {return _float;}
{OP} {return _op;}
{COMMENT} {return _comment;}
{IF} {return _if;}
{ELSE} {return _else;}
{WHILE} {return _while;}
{FUNCTION} {return _function;}
{RETURN} {return _return;}
{INT_TOKEN} {return _int_type;}
{FLOAT_TOKEN} {return _float_type;}
{TRUE} {return _true;}
{FALSE} {return _false;}
"=" {return '=';}
"(" {return _open_par;}
")" {return _close_par;}
"{" {return _open_brace;}
"}" {return _close_brace;}
";" {return _end_of_line;}
{WHITESPACE} { continue; }
. {printf("Error: Unknown character: %c\n", yytext[0]); return invalid;}

%%

int yywrap(void) { return 1; }

int main(void) {
    int token = (Token) yylex();
    FILE *in = fopen("./in.txt", "r");
    yyin = in;

    FILE *out = fopen("./out.txt", "w"); 
    
    while(token != invalid) {
        fprintf(out, "<%s, %d>\n", yytext, token);
        // switch(yylex()) {
        //     case _id:
                
        //     case _int:
        //         fprintf(out, "<%s, int>\n", yytext);
        //         break;
        //     case _float:
        //         fprintf(out, "<%s, float>\n", yytext);
        //         break;
        //     case _comment:
        //         fprintf(out, "<%s, comment>\n", yytext);
        //         break;
        //     case _function:
        //         fprintf(out, "<%s, function>\n", yytext);
        //         break;
        //     case _return:
        //         fprintf(out, "<%s, return>\n", yytext);
        //         break;
        //     case _while:
        //         fprintf(out, "<%s, while>\n", yytext);
        //         break;
        //     case _if:
        //         fprintf(out, "<%s, if>\n", yytext);
        //         break;
        //     case _else:
        //         fprintf(out, "<%s, else>\n", yytext);
        //         break;
        //     default:
        //         fprintf(out, "<%s, invalid>\n", yytext);
        //         break;
        // }
    }

    fclose(in);
    fclose(out);

    return 0;
}