/* expr.y */
/*%glr-parser*/
/*%define lr.type lalr*//*default*/
/*%define lr.type ielr*/
%define lr.type canonical-lr
/* %expect-rr 0*/

%{
#include "main.h"
int yyerror(char const *s);
int yylex(void);
%}

%union{
  int        int_val;
  string*    op_val;
}

%start    input 

%token    <int_val>    INT
%type    <int_val>    exp
%left    PLUS
%left    OP
%left    CP
%left    MIN
%left    MUL
%left    DIV

%%

input:  /* empty */
        | exp    { cout << "Result: " << $1 << endl; }
        ;

exp:    INT    { $$ = $1; }
        | exp PLUS exp    { $$ = $1 + $3; }
        | exp MIN exp    { $$ = $1 - $3; }
        | exp MUL exp    { $$ = $1 * $3; }
        | exp DIV exp    { $$ = $1 / $3; }
        | OP exp CP     { $$ = $2; }
        ;

%%

int yyerror(string s) {
  extern int yylineno;    // defined and maintained in lex.c
  extern char *yytext;    // defined and maintained in lex.c
  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << endl;
  exit(1);
}

int yyerror(char const *s) {
  return yyerror(string(s));
}


