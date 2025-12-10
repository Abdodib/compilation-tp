%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ts.h"

int nb_ligne = 1;
TS* table;

/* temp storage for liste_idf during a declaration */
char *liste_temp[256];
int nb_temp = 0;

void free_temp_list() {
    for (int i=0;i<nb_temp;i++) free(liste_temp[i]);
    nb_temp = 0;
}

int yyerror(const char *s);
int yylex(void);
%}

%union {
    char *sval;
    double dval;
}

%token <sval> IDF STRING OP
%token <dval> CONSTANTE
%token <sval> INT FLT
%token ERREUR_LEXICAL
%token START STOP MAIN SEC_C SEC_V
%token ACC_OU ACC_FE PAR_OU PAR_FE ASSIGN_OP DEUX_POINTS VRG PVRG
%token OR AND CONDITION_OP
%token NOT PRINT
%token IF ELSE ENDIF DO WHILE FOR STEP FROM TO
%type <sval> type
%type <sval> liste_idf

%start main_program

%%

main_program:
      MAIN IDF PVRG section_variables section_code {
          printf("syntaxe correcte\n");
          ts_print(table);
          ts_free(table);
          YYACCEPT;
      }
;

section_variables:
      SEC_V liste_declarations
;

liste_declarations:
      /* empty */ 
    | liste_declarations declaration
;

declaration:
      liste_idf DEUX_POINTS type PVRG
      {
          /* $1 is built via side effects into liste_temp[] */
          for (int i=0; i<nb_temp; i++) {
              if (ts_find(liste_temp[i], table)) {
                  printf("Erreur semantique (ligne %d): double déclaration de %s\n", nb_ligne, liste_temp[i]);
              } else {
                  ts_insert_var_with_type(liste_temp[i], $3, table);
              }
          }
          free_temp_list();
          free($3);
      }
;

liste_idf:
      IDF { liste_temp[nb_temp++] = $1; }
    | liste_idf VRG IDF { liste_temp[nb_temp++] = $3; }
;

type:
      INT { $$ = $1; }
    | FLT { $$ = $1; }
;

section_code:
      SEC_C START ACC_OU liste_instructions ACC_FE STOP
;

liste_instructions:
      /* empty */
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
      {
        /* simple check: variable must be declared */
        if (!ts_find($2, table)) {
            printf("Erreur semantique (ligne %d): %s non déclarée dans FOR\n", nb_ligne, $2);
        }
      }
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
      {
          /* check ID declared */
          if (!ts_find($1, table)) {
              printf("Erreur semantique (ligne %d): %s non déclarée\n", nb_ligne, $1);
          }
      }
    | IDF CONDITION_OP EXPR
      {
          if (!ts_find($1, table)) {
              printf("Erreur semantique (ligne %d): %s non déclarée\n", nb_ligne, $1);
          }
      }
;

fonction_appel:
       PRINT PAR_OU STRING PAR_FE PVRG
     | PRINT PAR_OU EXPRESSION PAR_FE PVRG
;

%%

int yyerror(const char *s) {
    printf("Erreur syntaxique à la ligne %d: %s\n", nb_ligne, s);
    return 1;
}

int main(void) {
    table = ts_create();
    yyparse();
    return 0;
}
