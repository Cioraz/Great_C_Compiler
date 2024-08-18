%{
#include <stdio.h>
#include "tokens.h"
uint32_t line_number=1;
%}

space [ ]
alphabet [a-zA-Z]
digit [0-9]
newline [\n]
tab [\t]
single_char \'.\'
underscore [_]
invalid [`@$]
string \"(\\[nt\"'\\]|[^"\n\\])*\"  
identifier ({alphabet}|{underscore})({alphabet}|{digit}|{underscore})*

%%
{space}* { /* ignore whitespace and read abt string regexp */ }
{tab}* { /* ignore tabs */ }
{newline} { line_number++; }
auto { return AUTO; }
break { return BREAK; }
case { return CASE; }
char { return CHAR; } /* need to implement */
const { return CONST; }
continue { return CONTINUE; }
default { return DEFAULT; }
do { return DO; }
double { return DOUBLE; }
else { return ELSE; }
enum { return ENUM; }
extern { return EXTERN; }
float { return FLOAT; }
for { return FOR; }
goto { return GOTO; }
if { return IF; }
int { return INT; }
long { return LONG; }
register { return REGISTER; }
return { return RETURN; }
short { return SHORT; }
signed { return SIGNED; }
sizeof\([^)]*\) { return SIZEOF; } 
static { return STATIC; }
struct { return STRUCT; }
switch { return SWITCH; }
typedef { return TYPEDEF; }
union { return UNION; }
unsigned { return UNSIGNED; }
void { return VOID; }
volatile { return VOLATILE; }
while { return WHILE; }

"<=" { return LEQ; }
">=" { return GEQ; }
"==" { return EQEQ; }
"!=" { return NEQ; }
"||" { return LOR; }
"&&" { return LAND; }
"=" { return ASSIGN; }
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MULT; }
"/" { return DIV; }
"%" { return MOD; }
"<" { return LT; }
">" { return GT; }
"++" { return INCR; }
"--" { return DECR; }
"!" { return LNOT; }
"&" { return BAND; }
"|" { return BOR; }
"^" { return XOR; }
"~" { return BNOT; }
"<<" { return LSHIFT; }
">>" { return RSHIFT; }

"," { return COMMA; }
";" { return SEMICOLON; }
"(" { return OBO; }
")" { return CBO; }
"{" { return CBO; }
"}" { return CBC; }
"#" { return HASH; }

printf\([^)]*\) return PRINTF;
scanf return SCANF;
malloc\([^)]*\) return MALLOC;
calloc\([^)]*\) return CALLOC;
realloc\([^)]*\) return REALLOC;
free\([^)]*\) return FREE;

getch return GETCH;
puts return PUTS;
strlen return STRLEN;
strcpy return STRCPY;
strcat return STRCAT;
strcmp return STRCMP;

ceil return CEIL;
floor return FLOOR;
abs return FABS;
log return LOG;
sqrt return SQRT;
pow return POW;
exp return EXP;

[+-]?{digit}+(\.{digit}+)? {printf("number\n");}
[+-]?[0-9]*\.[0-9]+ return FLOAT_CONST;
{string} return STRING_CONST;
{single_char} return CHAR_CONST;

{identifier} { printf("identi"); return IDENTIFIER; }

{identifier}\[({identifier}|{digit}+)\] return ARR;
%%

int main(int argc,char **argv){
    yylex();
    return 0;
}

int yywrap(){
    return 1;
}
