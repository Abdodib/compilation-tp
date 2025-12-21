%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "run.tab.h"

extern int nb_ligne;
%}

DIGIT       [0-9]
ID          [a-zA-Z]([a-zA-Z0-9_])*
CST         {DIGIT}+(\.{DIGIT}+)?
OP          [\+\-\*/]
COMMENT     "%%".*
STRING      \"([^"\n]*)\"

%%

"Integer"               { yylval.sval = strdup("INTEGER"); return INT; }
"Float"                 { yylval.sval = strdup("FLOAT"); return FLT; }
"Start"                 { return START; }
"Stop"                  { return STOP; }
"Main"                  { return MAIN; }
"Section Code"   { return SEC_C; }        
"Section Variables" { return SEC_V; } 
"if"                    { return IF; }
"else"                  { return ELSE; }
"or"                    { return OR; }
"and"                   { return AND; }
"endif"                 { return ENDIF; }
"do"                    { return DO; }
"while"                 { return WHILE; }
"for"                   { return FOR; }
"from"                  { return FROM; }
"to"                    { return TO; }
"step"                  { return STEP; }
"print"                 { return PRINT; }
"=="                    { return CONDITION_OP; }
"!="                    { return CONDITION_OP; }
"<="                    { return CONDITION_OP; }
">="                    { return CONDITION_OP; }
"<"                     { return CONDITION_OP; }
">"                     { return CONDITION_OP; }
"!"                     { return NOT; }
"{"                     { return ACC_OU; }
"}"                     { return ACC_FE; }
":="                    { return ASSIGN_OP; }
":"                     { return DEUX_POINTS; }
","                     { return VRG; }
";"                     { return PVRG; }
"("                     { return PAR_OU; }
")"                     { return PAR_FE; }
{OP}                    { yylval.sval = strdup(yytext); return OP; }
{CST}                   { yylval.dval = atof(yytext); yylval.sval = strdup(yytext); return CONSTANTE; }
{STRING}                { 
                            char *s = strdup(yytext);
                            int len = strlen(s);
                            if (len >= 2) {
                                s[len-1] = '\0';
                                memmove(s, s+1, len-1);
                            }
                            yylval.sval = s;
                            return STRING;
                        }
{ID}                    { yylval.sval = strdup(yytext); return IDF; }
{COMMENT}             
[ \t\r]+               
\n                      { nb_ligne++; }
.                       { return ERREUR_LEXICAL; }

%%

int yywrap(void) { return 1; }
