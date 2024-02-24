/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_BISON1_TAB_H_INCLUDED
# define YY_YY_BISON1_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    ALPHANUMERIC = 258,            /* ALPHANUMERIC  */
    COMMENT_BEGIN = 259,           /* COMMENT_BEGIN  */
    COMMENT_END = 260,             /* COMMENT_END  */
    COMMENT_CONTENT = 261,         /* COMMENT_CONTENT  */
    OTHER = 262,                   /* OTHER  */
    WRAP = 263,                    /* WRAP  */
    MATCH = 264,                   /* MATCH  */
    LINEAR_LAYOUT = 265,           /* LINEAR_LAYOUT  */
    RELATIVE_LAYOUT = 266,         /* RELATIVE_LAYOUT  */
    EQU = 267,                     /* EQU  */
    NUMBER = 268,                  /* NUMBER  */
    OPEN_LINEAR_LAYOUT = 269,      /* OPEN_LINEAR_LAYOUT  */
    CLOSE_LINEAR_LAYOUT = 270,     /* CLOSE_LINEAR_LAYOUT  */
    OPEN_RELATIVE_LAYOUT = 271,    /* OPEN_RELATIVE_LAYOUT  */
    CLOSE_RELATIVE_LAYOUT = 272,   /* CLOSE_RELATIVE_LAYOUT  */
    OPEN_RADIO_GROUP = 273,        /* OPEN_RADIO_GROUP  */
    CLOSE_RADIO_GROUP = 274,       /* CLOSE_RADIO_GROUP  */
    OPEN_RADIO_BUTTON = 275,       /* OPEN_RADIO_BUTTON  */
    TEXT_VIEW = 276,               /* TEXT_VIEW  */
    IMAGE_VIEW = 277,              /* IMAGE_VIEW  */
    BUTTON = 278,                  /* BUTTON  */
    PROGRESS_BAR = 279,            /* PROGRESS_BAR  */
    ANDROID_LAYOUT_WIDTH = 280,    /* ANDROID_LAYOUT_WIDTH  */
    ANDROID_LAYOUT_HEIGHT = 281,   /* ANDROID_LAYOUT_HEIGHT  */
    ANDROID_ID = 282,              /* ANDROID_ID  */
    ANDROID_ORIENTATION = 283,     /* ANDROID_ORIENTATION  */
    ANDROID_TEXT = 284,            /* ANDROID_TEXT  */
    ANDROID_TEXT_COLOR = 285,      /* ANDROID_TEXT_COLOR  */
    ANDROID_SRC = 286,             /* ANDROID_SRC  */
    ANDROID_PADDING = 287,         /* ANDROID_PADDING  */
    ANDROID_MAX = 288,             /* ANDROID_MAX  */
    ANDROID_PROGRESS = 289,        /* ANDROID_PROGRESS  */
    ANDROID_CHECKED_BUTTON = 290,  /* ANDROID_CHECKED_BUTTON  */
    ANDROID_NUMBER_BUTTONS = 291,  /* ANDROID_NUMBER_BUTTONS  */
    CLOSE = 292,                   /* CLOSE  */
    CLOSE2 = 293                   /* CLOSE2  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 35 "bison1.y"

	char name[100];
	int number;

#line 107 "bison1.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_BISON1_TAB_H_INCLUDED  */
