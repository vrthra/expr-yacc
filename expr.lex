/* expr.lex */

%option noyywrap
%{
#include "main.h"
#include "tok.h"
int yyerror(char const *s);
// int yylineno = 1;
%}

digit        [0-9]
int_const    {digit}+

%%

{int_const}    { yylval.int_val = atoi(yytext); return INT; }
"+"            { yylval.op_val = new std::string(yytext); return PLUS; }
"-"            { yylval.op_val = new std::string(yytext); return MIN; }
"*"            { yylval.op_val = new std::string(yytext); return MUL; }
"/"            { yylval.op_val = new std::string(yytext); return DIV; }
"("            { yylval.op_val = new std::string(yytext); return OP; }
")"            { yylval.op_val = new std::string(yytext); return CP; }

[ \t]*         {}
[\n]           { yylineno++;    }

.              { std::cerr << "SCANNER "; yyerror(""); exit(1);    }

