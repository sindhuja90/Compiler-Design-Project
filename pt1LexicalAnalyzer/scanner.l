%{
    #include <stdio.h>
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
main                                            ;


for                                             { printf("for\n\n"); }
if                                              { printf("if\n\n"); }
else                                            { printf("else\n\n"); }


char                                            { printf("char\n\n"); }       
int                                             { printf("int\n\n"); }         
short                                           { printf("short\n\n"); }       
long                                            { printf("long\n\n"); }        
float                                           { printf("float\n\n"); }       
double                                          { printf("double\n\n"); }      


"=="                                            { printf("eq\n\n"); }
"!="                                            { printf("neq\n\n"); }
">"                                             { printf("ge\n\n"); }
"<"                                             { printf("le\n\n"); }
">="                                            { printf("geq\n\n"); }
"<="                                            { printf("leq\n\n"); }


({letter}|_)({letter}|{digit}|_)*("++"|"--")    { printf("identifier incr/decr\n\n"); }

({letter}|_)({letter}|{digit}|_)*               { printf("identifier\n\n"); }


{digit}+                                        { printf("numeric\n\n"); }
{digit}+(\.{digit}+)?([eE][+-]?{digit}+)?       { printf("decexp\n\n"); }
"'"{letter}"'"                                  { printf("alpha\n\n"); }


[ \t\n]                                         ;

.                                               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}

int main() {
    yylex();

    return 0;
}
