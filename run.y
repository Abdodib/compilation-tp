%{
#include <stdio.h>
#include <stdlib.h>
#include "ts.h"       
#include "run.tab.h"

int yylex(void);
int yyerror(char* msg);
extern int nb_ligne;
extern TS table;     
%}

%start main_program

%token INT FLT START STOP MAIN SEC_C SEC_V
%token ACC_OU ACC_FE PAR_OU PAR_FE ASSIGN_OP DEUX_POINTS VRG PVRG
%token OR AND CONDITION_OP
%token OP IDF CONSTANTE NOT PRINT STRING
%token IF ELSE ENDIF
%token DO WHILE FOR STEP
%token FROM TO
%token ERREUR_LEXICAL

%%

main_program:
      MAIN IDF PVRG section_variables section_code {
            printf("syntaxe correcte\n");
            afficher(&table); // afficher la table des symboles
            YYACCEPT;
      }
;

section_variables:
      SEC_V liste_declarations
;

liste_declarations:
      declaration
    | liste_declarations declaration
;

declaration:
      liste_idf DEUX_POINTS type PVRG
;

liste_idf:
      IDF
    | liste_idf VRG IDF
;

type:
      INT
    | FLT
;

section_code:
      SEC_C START ACC_OU liste_instructions ACC_FE STOP
;

liste_instructions:
      /* vide */
    | instruction liste_instructions
;

instruction:
      EXPRESSION PVRG
    | fonction_appel
    | if_exprission
    | FOR_boucle
    | DOWHILE_boucle
;

if_exprission:
      IF PAR_OU Condition PAR_FE ACC_OU liste_instructions ACC_FE if_exprission
    | ELSE ACC_OU liste_instructions ACC_FE if_exprission
    | ELSE if_exprission
    | ENDIF PVRG
;

FOR_boucle:
      FOR IDF FROM CONSTANTE TO CONSTANTE STEP CONSTANTE
      ACC_OU liste_instructions ACC_FE
;

DOWHILE_boucle:
      DO ACC_OU liste_instructions ACC_FE WHILE PAR_OU Condition PAR_FE PVRG
;

Condition:
      EXPRESSION
    | Condition AND Condition
    | Condition OR Condition
    | NOT PAR_OU Condition PAR_FE
;

EXPR:
      CONSTANTE
    | IDF
    | EXPR OP EXPR
    | PAR_OU EXPR PAR_FE
;

EXPRESSION:
      IDF ASSIGN_OP EXPR
    | IDF CONDITION_OP EXPR
;

fonction_appel:
       PRINT PAR_OU STRING PAR_FE PVRG
     | PRINT PAR_OU EXPRESSION PAR_FE PVRG
;

%%

int main(void) {
    yyparse();
    return 0;
}

int yyerror(char* msg) {
    printf("Erreur syntaxique à la ligne %d\n", nb_ligne);
    return 1;
}
