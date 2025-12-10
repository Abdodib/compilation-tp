
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     IDF = 258,
     STRING = 259,
     OP = 260,
     CONSTANTE = 261,
     INT = 262,
     FLT = 263,
     ERREUR_LEXICAL = 264,
     START = 265,
     STOP = 266,
     MAIN = 267,
     SEC_C = 268,
     SEC_V = 269,
     ACC_OU = 270,
     ACC_FE = 271,
     PAR_OU = 272,
     PAR_FE = 273,
     ASSIGN_OP = 274,
     DEUX_POINTS = 275,
     VRG = 276,
     PVRG = 277,
     OR = 278,
     AND = 279,
     CONDITION_OP = 280,
     NOT = 281,
     PRINT = 282,
     IF = 283,
     ELSE = 284,
     ENDIF = 285,
     DO = 286,
     WHILE = 287,
     FOR = 288,
     STEP = 289,
     FROM = 290,
     TO = 291
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 23 "run.y"

    char *sval;
    double dval;



/* Line 1676 of yacc.c  */
#line 95 "run.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


