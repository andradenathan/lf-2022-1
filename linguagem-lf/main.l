%{  
#include <stdio.h>
#include <stdlib.h>

// Autores: Nathan Andrade | Bruna Ribeiro | Milton Quillinan

int comment = 0;

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
    _attribution = 15,
    _open_par = 16,
    _close_par = 17,
    _open_brack = 18,
    _close_brack = 19,
    _point = 20,
    _bool_type = 21,
    _var = 22,
    _const = 23,
    _eol = 24
} Token;
%} 

%x STATE_COMMENT

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
FLOAT [0-9][.][0-9]+
INT 0|[1-9][0-9]*
ATTRIBUTION =
OP [\+]|[\*]|==
VAR [vV][aA][rR]
CONST [cC][oO][nN][sS][tT]
ID [a-zA-Z_][a-zA-Z0-9_]*
OPEN_PAR [\(]
CLOSE_PAR [\)]
OPEN_BRACK [\{]
CLOSE_BRACK [\}]
POINTS [\:]
EOL [\;]
WHITESPACE [ \s\t\n]

%%

<<EOF>> {return eof;}

<INITIAL>{
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
{VAR} {return _var;}
{CONST} {return _const;}
{ID} {return _id;}
{INT} {return _int;}
{FLOAT} {return _float;}
{ATTRIBUTION} {return _attribution;}
"/*"    { BEGIN(STATE_COMMENT); }
"//".* ;
{OP} {return _op;}
{OPEN_PAR} {return _open_par;}
{CLOSE_PAR} {return _close_par;}
{OPEN_BRACK} {return _open_brack;}
{CLOSE_BRACK} {return _close_brack;}
{EOL} {return _eol;}
{POINTS} {return _point;}
{WHITESPACE}+
. {return invalid;}
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
        case 15: return "ATTRIBUTION"; break;
        case 16: return "OPEN_PAR"; break;
        case 17: return "CLOSE_PAR"; break;
        case 18: return "OPEN_BRACK"; break;
        case 19: return "CLOSE_BRACK"; break;
        case 20: return "POINTS"; break;
        case 21: return "BOOL"; break;
        case 22: return "VAR"; break;
        case 23: return "CONST"; break;
        case 24: return "EOL"; break;
        default: return "UNKNOWN"; break;
    }
}

int main(int argc, char* argv[]) {
    int token_type = 0;
    
    FILE *in = fopen(argv[1], "r");
    yyin = in;

    FILE *out = fopen("./out.txt", "w"); 

    while((token_type = yylex()) != eof) 
        fprintf(out, "[%s, %s]\n", yytext, find_token_by_type(token_type));

    fclose(in);
    fclose(out);
    
    return 0;
}