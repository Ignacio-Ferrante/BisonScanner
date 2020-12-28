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

%token PROGRAMA FIN VARIABLES CODIGO DECLARAR LEER ESCRIBIR CONSTANTE IDENTIFICADOR
%token ASIGNACION "<-"

%left  '+'  '-'
%left  '*'  '/'
%precedence NEG

%%

    programa : inicio listaSentencias fin-prog

    listaSentencias :   %empty
                    |   sentencia
                    |   listaSentencias sentencia

    sentencia :
    leer ( listaIdentificadores ) ;
    escribir ( listaExpresiones ) ;
    declarar identificador ;
    identificador <- expresión ;

    listaIdentificadores :
    identificador
    listaIdentificadores , identificador

    listaExpresiones :
    	expresión
    	listaExpresiones , expresión

    expresión :
    	término
    	expresión operador-suma término

    término :
    	factor
    	término operador-producto factor

    factor :
    	número
    	identificador
    	( expresión )
    	- expresión
%%
/* Informa la ocurrencia de un error. */
void yyerror(const char *error){
        printf("línea #%d  %s\n", yylineno, error);
        return;
}