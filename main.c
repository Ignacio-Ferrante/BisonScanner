//////////////////////////////////////////////////////////////////////////////////////
/*
      TP4 - 2020
      "Un escaner elemental"

      INTEGRANTES: 
      Alejandro Buergo / 168.569-7
      Ignacio Ferrante / 171.524-0
      Patricio Galli   / 172.467-8
                                                                                    */
//////////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include "parser.h"
#include "scanner.h"
extern int yynerrs;

int main() {
	int parser = yyparse();

	switch(parser){
		case 0:
			puts("Compilacion terminada con exito");
		case 1:
			puts("Errores de compilación");
		case 2:
			puts("Memoria insuficiente");
		}

	printf("Errores sintácticos: %d - Errores léxicos: %d\n",yynerrs,errlex);
	return parser;
}