%top{
	#include <stdio.h>
	#include "parser.h"
	char errorMsg[300];
	int errlex;
	void yyerror(const char *);
}

%option header-file = "scanner.h"
%option outfile = "scanner.c"
%option noinput
%option nounput

digito              [0-9]
letra               [[:alpha:]]
letraDigito         [[:alnum:]]
identificador       {letra}{letraDigito}*
asignacion          <-
comentario          ##.*$
digitoInvalido      [[:^digit:]]{-}[[:space:]]]
charDesconocido     [[:punct:]]{-}[{().,+\-*/;}{comentario}]
%%

[[:space:]]						                        ;
programa                                                return PROGRAMA;
fin-prog                                                return FIN_PROG;
leer                                                    return LEER;
escribir                                                return ESCRIBIR;
declarar                                                return DECLARAR;
"("							                            return '(';
")"							                            return ')';
";"                                                     return ';';
"."							                            return '.';
","							                            return ',';
"+"							                            return '+';
"-"							                            return '-';
"*"							                            return '*';
"/"							                            return '/';
{digito}+                                             	return CONSTANTE;
{identificador}	                                    	return IDENTIFICADOR;
{comentario}                                       	    //los elimina
{asignacion}	                                        		return ASIGNACION;
{identificador}{charDesconocido}({letraDigito}|{charDesconocido})*   {sprintf(errorMsg, "Error léxico: identificador inválido: %s",yytext);yyerror(errorMsg);errlex++;}
{digito}{identificador}*                                {sprintf(errorMsg, "Error léxico: constante inválida: %s",yytext);yyerror(errorMsg);errlex++;}
{charDesconocido}+                                      {sprintf(errorMsg, "Error léxico: cadena desconocida: %s", yytext);yyerror(errorMsg);errlex++;}
%%

