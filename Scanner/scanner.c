#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include"../tokens.h"
#include"../SymbolTable/hash.h"

extern int yylex();
extern uint32_t line_number;
extern FILE *yyin;
extern char *yytext; // may need it or remove later

// Prototypes
void processToken(int scan,int line_number);
void handleErr(int scan,int line_number);
void handleCommentErrors(int isMultiLineComment, int multiLineCommentLine, int doubleQuoteLine, int doubleQuote, int line_number);

int singleLineCommentLine = 0;
int isMultiLineCommentOpen = 0, multiLineCommentNumber = 0;
int doubleQuote = 0, doubleQuoteLine = 0;

int main(int argc,char **argv){
    printf("\n***********************************Lexed Tokens Order***********************************\n\n");
	printf("Token Value\t\t\t\t\t  Token Type \t\t\tLine Number\n");
	printf("-------------------------------------------------------------------------------------------");
    if(argc<2){
        fprintf(stderr, "Usage: %s <input_file>\n",argv[0]);
        exit(EXIT_FAILURE);
    }

    FILE *yyin=fopen(argv[1],"r");
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
            printf("%sKEYWORD\t\t\tLine %d\n", yytext, line_number);
            insertToSymbolTable(st, yytext, "KEYWORD");
            break;

        case COMMA:
        case SEMICOLON:
        case OBO ... HASH:
            printf("%-50sSPECIAL SYMBOL\t\tLine %-20d\n", yytext, lineNumber);
            insertToSymbolTable(st, yytext, "SPECIAL SYMBOL");
            break;


    }
}
