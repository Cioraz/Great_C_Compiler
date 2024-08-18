#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include"../SymbolTable/hash.h"

extern int yylex();
extern uint32_t line_number;
extern FILE *yyin;

int main(int argc,char **argv){
    printf("\n***********************************Lexed Tokens Order***********************************\n\n");
	printf("Token Value\t\t\t\t\t  Token Type \t\t\tLine Number\n");
	printf("-------------------------------------------------------------------------------------------");
    if(argc==1){
        printf("Please give input file: ");
        exit(EXIT_FAILURE);
    }

    SymbolTable *table= createSymbolTable();
}
