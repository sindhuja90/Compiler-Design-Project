%{
	#include <stdio.h>
	#include "lex.yy.c"
	
    extern FILE *yyin;

	void yyerror();
%}

%token FOR IF ELSE
%token CHAR INT SHORT LONG FLOAT DOUBLE
%token EQ NEQ GE LE GEQ LEQ
%token IDENTIFIER IDENTUPD
%token NUMERIC DECEXP ALPHA

%left EQ NEQ
%left LE LEQ GE GEQ
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'

%start P

%%

P : S																		{ printf("\nParsing Successful\n\n"); return 0; }

S : FOR '(' OPTINIT ';' OPTTEST ';' OPTUPD ')' '{' BODY '}' 				;

OPTINIT : DTYPE IDENTIFIER '=' VAL OPT1										;
		|																	;

DTYPE : CHAR 																;	
		| INT 																;
		| SHORT 															;
		| LONG 																;
		| FLOAT 															;
		| DOUBLE															;	

VAL : NUMERIC																;
	| DECEXP																;
	| ALPHA																	;

OPT1 : ',' IDENTIFIER '=' VAL OPT1											;
		|																	;

OPTTEST : EXP																;
		|																	;

EXP : EXP EQ EXP															;
	| EXP NEQ EXP															;
	| EXP LE EXP															;
	| EXP LEQ EXP															;	
	| EXP GE EXP															;
	| EXP GEQ EXP															;
	| NUMERIC                             									;
	| DECEXP																;
	| ALPHA
    | IDENTIFIER															;

OPTUPD : IDENTUPD OPT2														;
		|																	;

OPT2 : ',' IDENTUPD	OPT2													;
		|																	;

BODY : S																	;
	| IFELSE																;
	| IDENTIFIER '=' OPR ';'												;

IFELSE : IF '(' EXP ')' '{' BODY '}'										;
    	| IF '(' EXP ')' '{' BODY '}' ELSE '{' BODY '}'						;

OPR : OPR '+' OPR															;
	| OPR '-' OPR															;
	| OPR '*' OPR															;
	| OPR '/' OPR                                                 			;
	| OPR '%' OPR															;
	| NUMERIC																;
	| DECEXP																;
	| ALPHA																	;
	| IDENTIFIER															;

%%

void yyerror() {
    printf("\nParsing Unsuccessful\n\n");
}

int main(int argc, char *argv[]) {
    yyin = fopen(argv[1], "r");
	yyparse();
	fclose(yyin);

	return 0;
}
