%top{
	#include <stdio.h>
	#include "parser.h"
	char errorMsg[200];
	int errlex;
	void yyerror(const char *);
}

%option header-file = "scanner.h"
%option outfile = "scanner.c"
%option yylineno
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

{comentario}                                       	    				//los elimina
[[:space:]]+						                        				;
programa                                                				return PROGRAMA;
fin-prog                                                				return FIN_PROG;
leer                                                    				return LEER;
escribir                                                				return ESCRIBIR;
declarar                                                				return DECLARAR;
{asignacion}	                                        				return ASIGNACION;
"("							                            				return '(';
")"							                            				return ')';
";"                                                     				return ';';
"."							                            				return '.';
","							                            				return ',';
"+"							                            				return '+';
"-"							                            				return '-';
"*"							                            				return '*';
"/"							                            				return '/';
{digito}+                                             					{ yylval = strdup(yytext); return CONSTANTE; }
{identificador}	                                    					{ yylval = strdup(yytext); return IDENTIFICADOR; }
{identificador}{charDesconocido}({letraDigito}|{charDesconocido})*   	{ sprintf(errorMsg, "Error léxico: identificador inválido: %s",yytext); yyerror(errorMsg); errlex++; }
{digito}{identificador}*                                				{ sprintf(errorMsg, "Error léxico: constante inválida: %s",yytext); yyerror(errorMsg); errlex++; }
{charDesconocido}+                                      				{ sprintf(errorMsg, "Error léxico: cadena desconocida: %s", yytext); yyerror(errorMsg); errlex++; }

%%