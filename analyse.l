%{
#include <stdio.h>
#include "run.tab.h"
#include "ts.h"
int nb_ligne = 1;
TS table; // racine de la table des symboles
%}

chiffre         [0-9]
IDF             [a-zA-Z]([a-zA-Z0-9_])*
cst             {chiffre}+(\.{chiffre}+)? 
operateur       [\+\-\*/]
comnts          "%%".*
operation       ({IDF}[ \t]*":="[ \t]*.*";")

%%

"Integer"               { inserer(yytext,"TYPE",&table); return INT; }  
"Float"                 { inserer(yytext,"TYPE",&table); return FLT; }
"Start"                 { return START; }
"Stop"                  { return STOP; }
"Main"                  { return MAIN; }
"Section Code"          { return SEC_C; }
"Section Variables"     { return SEC_V; }

("=="|"!="|"<="|">="|"<"|">")  { return CONDITION_OP; }
"!"                     { return NOT; }
"{"                     { return ACC_OU; }
"}"                     { return ACC_FE; }
":="                    { return ASSIGN_OP; }
":"                     { return DEUX_POINTS; }
","                     { return VRG; }
";"                     { return PVRG; }
"("                     { return PAR_OU; }
")"                     { return PAR_FE; }

{operateur}             { return OP; }
{operation}             ;
{cst}                   { inserer(yytext,"CONST",&table); return CONSTANTE; }
{comnts}                ;
[ \t\r]+                ;

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

\"([^\"]*)\"            { inserer(yytext,"STRING",&table); return STRING; }

{IDF}                   { inserer(yytext,"IDF",&table); return IDF; }

\n                      { nb_ligne++; }
.                       { return ERREUR_LEXICAL; }

%%

int yywrap() { return 1; }
