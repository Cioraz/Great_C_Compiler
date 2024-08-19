%{
uint32_t line_number = 1;
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#include"../SymbolTable/linked_list.h"
#include"../tokens.h"

%}

alphabet [A-Za-z]
digit [0-9]
underscore [_]
space [ ]
tab [	]
newline [\n]
single_char \'.\'
unknowns [@~`$^]
string \"(\\[nt\"'\\]|[^\n\"])*\"
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
sizeof\([^)]*\) { return SIZEOF; } 
static { return STATIC; }
struct { return STRUCT; }
switch { return SWITCH; }
typedef { return TYPEDEF; }
union { return UNION; }
void { return VOID; }
volatile { return VOLATILE; }
while { return WHILE; }

"//" return SLC;
"/*" return MLCS;
"*/" return MLCE;


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

"#include"{space}*"<stdio.h>" return HEADER;
"#include"{space}*"<string.h>" return STRINGH;
"#include"{space}*"<math.h>" return MATH;

main\(\) return MAIN;
printf return PRINTF;
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

{string} return STRING_CONST;
{single_char} return CHAR_CONST;
{identifier}\[({identifier}|{digit}+)\] return ARR;
[+-]?[0-9]*\.[0-9]+([eE][+-]?[0-9]+)?  return FLOAT_CONST;
[+-]?{digit}+ return INT_CONST;
{identifier} return IDENTIFIER;
[+-]?[0-9]*\.[0-9]*[^\n\t\r\f\s\(\)\[\]\{\},;:]+ { return NUM_ERR; }
. return UNKNOWN;

%%

int main(int argc, char *argv[])
{
    printf("Tokens begin lexed as their order in the program\n");
	printf("Token Value\t\t\t\t\t  Token Type \t\t\tLine Number\n");
	printf("-------------------------------------------------------------------------------------------");
	if(argc == 1){
		printf("Please give input file name");
		return 0;
	}
	SymbolTable* st = createSymbolTable();
	
	int scan;
	int singleLineCommentLine = 0; 
	int isMultiLineComment = 0, multiLineCommentLine = 0;
	int doubleQuote = 0, doubleQuoteLine = 0;
	yyin = fopen(argv[argc - 1],"r");
	printf("\n\n");
	scan = yylex();
	while(scan)
	{
		if(line_number == singleLineCommentLine)
		{
			scan = yylex();
			continue;
		}

		if(line_number!=doubleQuoteLine && doubleQuoteLine!=0)
		{
			if(doubleQuote%2!=0)
				printf("\n******** ERROR!! INCOMPLETE STRING at Line %d ********\n\n", doubleQuoteLine);
			doubleQuote=0;
		}

		if(isMultiLineComment == 0){
			switch (scan) {
				case AUTO ... WHILE:
					printf("%-50sKEYWORD\t\t\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "KEYWORD");
					break;
				case IDENTIFIER:
					if (yyleng > 31) {
        				printf("\n******** ERROR!! Identifier '%s' is longer than 31 characters at Line %d ********\n\n", yytext, line_number);
            		}else{
					printf("%-50sIDENTIFIER\t\t\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "IDENTIFIER");
					}
					break;
				case SLC:
					printf("%-50sSingleline Comment\t\tLine %-20d\n", yytext, line_number);
					singleLineCommentLine = line_number;
					break;
				case MLCS:
					printf("%-50sMultiline Comment Start\tLine %-20d\n", yytext, line_number);
					multiLineCommentLine = line_number;
					isMultiLineComment = 1;
					break;
				case MLCE:
					printf("\n******** ERROR!! UNMATCHED MULTILINE COMMENT END %s at Line %d ********\n\n", yytext, line_number);
					break;
				case LEQ ... DECR:
					printf("%-50sOPERATOR\t\t\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "OPERATOR");
					break;
				case COMMA:
				case SEMICOLON:
				case OBO ... HASH:
					printf("%-50sSPECIAL SYMBOL\t\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "SPECIAL SYMBOL");
					break;
				case DQ:
					printf("%-50sSPECIAL SYMBOL\t\tLine %-20d\n", yytext, line_number);
					doubleQuote++;
					doubleQuoteLine = line_number;
					insertToSymbolTable(st, yytext, "SPECIAL SYMBOL");
					break;
				case HEADER:
				case STRINGH:
				case MATH:
					printf("%-50sHEADER\t\t\tLine %-20d\n",yytext, line_number);
					break;
				case MAIN:
					printf("%-50sMAIN FUNCTION\t\t\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "IDENTIFIER");
					break;
				case PRINTF ... FREE:
					printf("%-50sPRE DEFINED FUNCTION\t\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "PRE DEFINED FUNCTION");
					break;
				case GETCH ... STRCPY:
				case CEIL ... EXP:
					printf("%-50sLIBRARY DEFINED FUNCTION\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "LIBRARY DEFINED FUNCTION");
					break;
                /*
				case DEFINE:
					printf("%-50sPRE PROCESSOR DIRECTIVE\t\t\tLine %-20d\n", yytext, line_number);
					break;
                */
				case INT_CONST:
					printf("%-50sINTEGER CONSTANT\t\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "INTEGER CONSTANT");
					break;
				case FLOAT_CONST:
					printf("%-50sFLOATING POINT CONSTANT\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "FLOATING POINT CONSTANT");
					break;
                /*
				case TYPE_SPEC:
					printf("%-50sTYPE SPECIFIER\t\t\tLine %-20d\n", yytext, line_number);
					break;
                */
				case ARR:
					printf("%-50sARRAY\t\t\t\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "ARRAY");
					break;
				// case FUNC:
				// 	printf("%-50sUSER DEFINED FUNCTION\t\t\tLine %-20d\n", yytext, line_number);
				// 	insertToSymbolTable(st, yytext, "USER DEFINED FUNCTION");
				// 	break;
				case NUM_ERR:
					printf("\n******** ERROR!! CONSTANT ERROR %s at Line %d ********\n\n", yytext, line_number);
					break;
				case UNKNOWN:
					printf("\n******** ERROR!! UNKNOWN TOKEN %s at Line %d ********\n\n", yytext, line_number);
					break;
				case CHAR_CONST:
					printf("%-50sCHARACTER CONSTANT\t\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "CHARACTER CONSTANT");
					break;
                /*
				case SIGNED_CONST:
					printf("%-50sSIGNED CONSTANT\t\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "SIGNED CONSTANT");
					break;
                */
				case STRING_CONST:
					printf("%-50sSTRING CONSTANT\t\tLine %-20d\n", yytext, line_number);
					insertToSymbolTable(st, yytext, "STRING CONSTANT");
					break;
				default:
					printf("\n******** ERROR!! TOKEN NOT SUPPORTED BY COMPILER %s at Line %d ********\n\n", yytext, line_number);		
			}
		}
		if (scan == MLCE && isMultiLineComment == 1) {
			isMultiLineComment = 0;
			printf("%-50sMultiline Comment End\t\tLine %-20d\n", yytext, line_number);
		}
		
		scan = yylex();
	}
	if(isMultiLineComment == 1)
		printf("\n******** ERROR!! UNMATCHED COMMENT STARTING at Line %d ********\n\n",multiLineCommentLine);
	printf("\n");
	printf("-------------------------------------------------------------------------------------------\n\n");
	printf("\n************************* SYMBOL TABLE ****************************\n\n");
	printSymbolTable(st);
	destroySymbolTable(st);
}
int yywrap()
{
	return 1;
}
