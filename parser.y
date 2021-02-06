%code top{
#include <stdio.h>
#include "scanner.h"
}

%code provides {
extern int errlex; 	/* Contador de Errores Léxicos */
}

%defines "parser.h"
%output "parser.c"

%define api.value.type {char *}
%define parse.error verbose /* Mas detalles cuando el Parser encuentre un error en vez de "Syntax Error" */

%start programa /* El no terminal que es AXIOMA de la gramatica del TP2 */

%token PROGRAMA FIN_PROG DECLARAR LEER ESCRIBIR CONSTANTE IDENTIFICADOR
%token ASIGNACION "<-"

%left  '+'  '-'
%left  '*'  '/'
%precedence NEG

%%

programa : PROGRAMA listaSentencias FIN_PROG             {if (errlex+yynerrs > 0) YYABORT;else YYACCEPT;}

listaSentencias :               %empty
                            |   sentencia
                            |   listaSentencias sentencia
                            ;

sentencia       :               LEER '(' listaIdentificadores ')' ';'           {printf("leer\n");}
                            |   ESCRIBIR '(' listaExpresiones ')' ';'           {printf("escribir\n");}
                            |   DECLARAR '(' IDENTIFICADOR ')' ';'              {printf("declarar %s\n",$3);}
                            |   IDENTIFICADOR "<-" expresion ';'                {printf("asignacion\n");}
                            ;

listaIdentificadores :          IDENTIFICADOR
                            |   listaIdentificadores ',' IDENTIFICADOR
                            ;

listaExpresiones :   	        expresion
                            |   listaExpresiones ',' expresion
                            ;

expresion :                 	CONSTANTE
    	                    |   IDENTIFICADOR
    	                    |   '(' expresion ')'                               {printf("paréntesis\n");}
    	                    |   '-' expresion   %prec NEG                       {printf("inversion\n");}
    	                    |   expresion '+' expresion                         {printf("suma\n");}
    	                    |   expresion '-' expresion                         {printf("resta\n");}
                            |   expresion '*' expresion                         {printf("multiplicacion\n");}
    	                    |   expresion '/' expresion                         {printf("division\n");}
                            ;
%%

void yyerror(const char *error){
        printf("línea #%d  %s\n", yylineno, error);
        return;
}