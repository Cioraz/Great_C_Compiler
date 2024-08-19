#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include"../tokens.h"
#include"../SymbolTable/linked_list.h"

extern int yylex();
extern uint32_t line_number;
extern FILE *yyin;
extern char *yytext; // may need it or remove later
extern int yyleng;
extern SymbolTable *table;

// Prototypes
void processToken(int scan,int line_number);
void handleErr(int scan,int line_number);
void handleCommentErrors(int isMultiLineComment, int multiLineCommentLine, int doubleQuoteLine, int doubleQuote, int line_number);

int singleLineCommentLine = 0;
int isMultiLineCommentOpen = 0, multiLineCommentNumber = 0;
int doubleQuote = 0, doubleQuoteLine = 0;

int main(int argc,char **argv){
	printf("Token Value\t\t\t\t\t  Token Type \t\t\tLine Number\n");
	printf("-------------------------------------------------------------------------------------------");
    if(argc<2){
        fprintf(stderr, "Usage: %s <input_file>\n",argv[0]);
        exit(EXIT_FAILURE);
    }

    yyin=fopen(argv[1],"r");
    if(!yyin){
        perror("fopen");
        return EXIT_FAILURE;
    }

    int scan;
    printf("\n\n");
    while((scan=yylex())){
        if(isMultiLineCommentOpen==0){
            processToken(scan,line_number);
        }
        if(scan==MLCE && isMultiLineCommentOpen){
            isMultiLineCommentOpen=0;
            printf("%sMultiline Comment End\t\tLine %d\n", yytext, line_number);

        }
    }

}


void processToken(int scan,int line_number){
    switch(scan){
        case AUTO ... WHILE:
            printf("%-50sKEYWORD\t\t\tLine %-20d\n", yytext, line_number);
            insertToSymbolTable(table, yytext, "KEYWORD");
            break;
        case IDENTIFIER:
            if (yyleng > 31) {
                printf("\n******** ERROR!! Identifier '%s' is longer than 31 characters at Line %d ********\n\n", yytext, line_number);
            } else {
                printf("%-50sIDENTIFIER\t\t\tLine %-20d\n", yytext, line_number);
                insertToSymbolTable(table, yytext, "IDENTIFIER");
            }
            break;
        case SLC:
            printf("%-50sSingleline Comment\t\tLine %-20d\n", yytext, line_number);
            singleLineCommentLine = line_number;
            break;
        case MLCS:
             printf("%-50sMultiline Comment Start\tLine %-20d\n", yytext, line_number);
            multiLineCommentNumber= line_number;
            isMultiLineCommentOpen = 1;
            break;
        case LEQ ... DECR:
            printf("%-50sOPERATOR\t\t\tLine %-20d\n", yytext, line_number);
            insertToSymbolTable(table, yytext, "OPERATOR");
            break;
        case COMMA:
        case SEMICOLON:
        case OBO ... HASH:
            printf("%-50sSPECIAL SYMBOL\t\tLine %-20d\n", yytext, line_number);
            insertToSymbolTable(table, yytext, "SPECIAL SYMBOL");
            break;
         case PRINTF ... FREE:
            printf("%s\t\tLine %d\n", yytext, line_number);
            insertToSymbolTable(table, yytext, "PRE DEFINED FUNCTION");
            break;
         case INT_CONST:
            printf("INTEGER CONSTANT\t\tLine %d\n", line_number);
            insertToSymbolTable(table, yytext, "INTEGER CONSTANT");
            break;
        case FLOAT_CONST:
            printf("FLOATING POINT CONSTANT\tLine %d\n", line_number);
            insertToSymbolTable(table, yytext, "FLOATING POINT CONSTANT");
            break;
        case ARR:
            printf("ARRAY\t\t\t\tLine %d\n", line_number);
            insertToSymbolTable(table, yytext, "ARRAY");
            break;
        case MAIN:
            printf("%-50sMAIN FUNCTION\t\t\tLine %-20d\n", yytext, line_number);
            insertToSymbolTable(table, yytext, "IDENTIFIER");
            break;
        case CHAR_CONST:
            printf("%-50sCHARACTER CONSTANT\t\tLine %-20d\n", yytext, line_number);
            insertToSymbolTable(table, yytext, "CHARACTER CONSTANT");
            break;
        // case SIGNED_CONST:
            // printf("SIGNED CONSTANT\t\tLine %d\n", line_number);
            // insertToSymbolTable(st, yytext, "SIGNED CONSTANT");
            // break;
        case STRING_CONST:
             printf("%-50sSTRING CONSTANT\t\tLine %-20d\n", yytext, line_number);
            insertToSymbolTable(table, yytext, "STRING CONSTANT");
            break;
        default:
            handleErr(scan, line_number);
            break;
    }
}


void handleErr(int scan,int line_number){
    printf("%d",scan);
    switch(scan){
        case NUM_ERR:
            printf("\n******** ERROR!! CONSTANT ERROR %s at Line %d ********\n\n", yytext, line_number);
            break;
        case UNKNOWN:
            printf("\n******** ERROR!! UNKNOWN TOKEN %s at Line %d ********\n\n", yytext, line_number);
            break;
        default:
            printf("\n******** ERROR!! TOKEN NOT SUPPORTED BY COMPILER %s at Line %d ********\n\n", yytext, line_number);
            break;
    }
}

int yywrap(){
    return 1;
}
