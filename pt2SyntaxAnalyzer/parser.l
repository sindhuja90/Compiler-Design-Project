%{
    #include "y.tab.h"
%}

letter      [a-zA-Z]
digit       [0-9]

%%

auto | 
break | 
case | 
const | 
continue |
default |
do | 
enum | 
extern |
goto |
inline | 
register |
restrict |
return |
sizeof |
static |
struct |
switch |
typedef |
union |
void |
volatile |
while |
_Alignas | 
_Alignof |
_Atomic |
_Bool |
_Complex | 
_Generic |
_Imaginary | 
_Noreturn |
_Static_assert | 
_Thread_local |
main                                                    ;


for                                                     { return FOR; }
if                                                      { return IF; }
else                                                    { return ELSE; }


char                                                    { return CHAR; }       
int                                                     { return INT; }         
short                                                   { return SHORT; }       
long                                                    { return LONG; }        
float                                                   { return FLOAT; }       
double                                                  { return DOUBLE; }      


"=="                                                    { return EQ; }
"!="                                                    { return NEQ; }
">"                                                     { return GE; }
"<"                                                     { return LE; }
">="                                                    { return GEQ; }
"<="                                                    { return LEQ; }


({letter}|_)({letter}|{digit}|_)*("++"|"--")            { return IDENTUPD; }

({letter}|_)({letter}|{digit}|_)*                       { return IDENTIFIER; }


{digit}+                                                { return NUMERIC; }
{digit}+(\.{digit}+)?([eE][+-]?{digit}+)?               { return DECEXP; }
"'"{letter}"'"                                          { return ALPHA; }


[ \t\n]                                                 ;

.                                                       { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
