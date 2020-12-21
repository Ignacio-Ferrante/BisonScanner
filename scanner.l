%{
#include <stdio.h>
#include "tokens.h"
%}

%option header-file = "scanner.h"
%option outfile = "scanner.c"
%option noinput
%option nounput

operador            [+\-*]
puntuacion          [().,/;]
digito              [0-9]
letra               [[:alpha:]]
letraDigito         [[:alnum:]]
identificador       {letra}{letraDigito}*
asignacion          <-
inicioFin           programa|fin-prog
funcion             leer|escribir|declarar
comentario          ##.*$
digitoInvalido      [[:^digit:]]{-}[[:space:]]]
charDesconocido                         [[:punct:]]{-}[{().,+\-*/;}{comentario}]
%%

[[:space:]]						                        ;
{inicioFin}                                           	|
{funcion}                                             	return PALABRA_RESERVADA;
{operador}                                            	|
{puntuacion}                                          	return CARACTER_VALIDO;
{digito}+                                             	return CONSTANTE;
{identificador}	                                    	return IDENTIFICADOR;
{comentario}                                       	    //los elimina
{asignacion}	                                                return ASIGNACION;
{identificador}+{charDesconocido}{letraDigito}+{charDesconocido}                return IDENTIFICADOR_INVALIDO;
{digito}{identificador}*                                     return CONSTANTE_INVALIDA;
{charDesconocido}+                                                 return CADENA_DESCONOCIDA;
%%


