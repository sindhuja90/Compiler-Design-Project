%{
	#include <stdio.h>
	#include <string.h>
	#include "lex.yy.c"
	
    extern FILE *yyin;

	void yyerror();
	void insertType();
	void search(char *);
	void add();

	struct dataType {
		char *name;
		char *type;
		int offset;
		int size;
	} symbolTable[20];

	int count = 0, flag = 0;
	char dtType[20];
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

P : S																		{ printf("\nParsing Successful\n\n\n"); return 0; }

S : FOR '(' OPTINIT ';' OPTTEST ';' OPTUPD ')' '{' BODY '}' 				;

OPTINIT : DTYPE IDENTIFIER { add(); } '=' VAL OPT1							;
		|																	;

DTYPE : CHAR 																{ insertType(); }	
		| INT 																{ insertType(); }
		| SHORT 															{ insertType(); }	
		| LONG 																{ insertType(); }
		| FLOAT 															{ insertType(); }	
		| DOUBLE															{ insertType(); }	

VAL : NUMERIC																;
	| DECEXP																;
	| ALPHA																	;

OPT1 : ',' IDENTIFIER { add(); } '=' VAL OPT1								;
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
	| ALPHA																	;
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
	flag = 1;
}

void insertType() {
	strcpy(dtType, (char *)yytext);

	return;
}

void search(char *idName) {
	int i;
	for(i = 0; i < count; i++) 
		if(strcmp(symbolTable[i].name, idName) == 0) {
			printf("\nInvalid input\n\n");
			exit(0);
		}

	return;
}

void add() {
	search(yytext);

	symbolTable[count].name = strdup(yytext);

	symbolTable[count].type = strdup(dtType);
	
	if(strcmp(dtType, "char") == 0)  
		symbolTable[count].size = 1;

	else if(strcmp(dtType, "int") == 0) 
		symbolTable[count].size = 4;

	else if(strcmp(dtType, "short") == 0) 
		symbolTable[count].size = 2;

	else if(strcmp(dtType, "long") == 0) 
		symbolTable[count].size = 8;

	else if(strcmp(dtType, "float") == 0) 
		symbolTable[count].size = 4;

	else if(strcmp(dtType, "double") == 0) 
		symbolTable[count].size = 8;

	if(count == 0)
		symbolTable[count].offset = 0;
	else	
		symbolTable[count].offset = symbolTable[count-1].offset + symbolTable[count-1].size;
	
	count++;

	return;
}

int main(int argc, char *argv[]) {
    yyin = fopen(argv[1], "r");
	yyparse();
	fclose(yyin);

	if(flag == 0) {
		printf("\t\t    SYMBOL TABLE");
		printf("\nNAME\t\tTYPE\t\tOFFSET\t\tSIZE");
		printf("\n___________________________________________________________\n\n");

		int i;
		for(i = 0; i < count; i++) 
			printf("%s\t\t%s\t\t%d\t\t%d\n", symbolTable[i].name, symbolTable[i].type, symbolTable[i].offset, symbolTable[i].size);

		printf("\n");

		for(i = 0; i < count; i++) {
			free(symbolTable[i].name);
			free(symbolTable[i].type);
		}
	}

	return 0;
}
