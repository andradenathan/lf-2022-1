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
    _open_brack = 18,
    _close_brack = 19,
    _point = 20,
    _bool_type = 21,
    _eol = 22
} Token;
%}

IF [iI][fF]
ELSE [eE][lL][sS][eE]
WHILE [wW][hH][iI][lL][eE]
FUNCTION [fF][nN]
RETURN [rR][eE][tT][uU][rR][nN]
INT_TYPE [iI][nN][tT]
FLOAT_TYPE [fF][lL][oO][aA][tT]
BOOL_TYPE [bB][oO][oO][lL]
TRUE [tT][rR][uU][eE]
FALSE [fF][aA][lL][sS][eE]
INT [1-9]+[0-9]*|0
FLOAT [0-9].[0-9]+
EQUAL =
OP [\+]|[\*]|==
ID [a-zA-Z_][a-zA-Z0-9_]*
COMMENT ("/*"([^*]|\*+[^*/])*\*+"/")|"//".*
OPEN_PAR [\(]
CLOSE_PAR [\)]
OPEN_BRACK [\{]
CLOSE_BRACK [\}]
POINTS [\:]
EOL [\;]
WHITESPACE [ \s\t\n]

%%

<<EOF>> {return eof;}
{FUNCTION} {return _function;}
{IF} {return _if;}
{ELSE} {return _else;}
{WHILE} {return _while;}
{RETURN} {return _return;}
{INT_TYPE} {return _int_type;}
{FLOAT_TYPE} {return _float_type;}
{BOOL_TYPE} {return _bool_type;}
{TRUE} {return _true;}
{FALSE} {return _false;}
{ID} {return _id;}
{INT} {return _int;}
{FLOAT} {return _float;}
{EQUAL} {return _equal;}
{OP} {return _op;}
{COMMENT} {return _comment;}
{OPEN_PAR} {return _open_par;}
{CLOSE_PAR} {return _close_par;}
{OPEN_BRACK} {return _open_brack;}
{CLOSE_BRACK} {return _close_brack;}
{EOL} {return _eol;}
{POINTS} {return _point;}
{WHITESPACE}+
. {printf("Error: Unknown character: %c\n", yytext[0]); return invalid;}

%%

int yywrap(void) { return 1; }

char* find_token_by_type(int token_type) {
    switch(token_type) {
        case -1: return "EOF"; break;
        case 0: return "INVALID"; break;
        case 1: return "ID"; break;
        case 2: return "INT"; break;
        case 3: return "FLOAT"; break;
        case 4: return "COMMENT"; break;
        case 5: return "IF"; break;
        case 6: return "ELSE"; break;
        case 7: return "WHILE"; break;
        case 8: return "TRUE"; break;
        case 9: return "FALSE"; break;
        case 10: return "OP"; break;
        case 11: return "FUNCTION"; break;
        case 12: return "RETURN"; break;
        case 13: return "INT_TYPE"; break;
        case 14: return "FLOAT_TYPE"; break;
        case 15: return "EQUAL"; break;
        case 16: return "OPEN_PAR"; break;
        case 17: return "CLOSE_PAR"; break;
        case 18: return "OPEN_BRACK"; break;
        case 19: return "CLOSE_BRACK"; break;
        case 20: return "POINTS"; break;
        case 21: return "BOOL"; break;
        case 22: return "EOL"; break;
        default: return "UNKNOWN"; break;
    }
}

int main(void) {
    int token_type = 0;
    
    FILE *in = fopen("./in.txt", "r");
    yyin = in;

    FILE *out = fopen("./out.txt", "w"); 
    
    while((token_type = yylex()) != eof) {
        fprintf(out, "[%s, %s]\n", yytext, find_token_by_type(token_type));
    }

    fclose(in);
    fclose(out);
    return 0;
}