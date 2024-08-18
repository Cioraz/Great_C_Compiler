#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<stdbool.h>

#define MAX_IDENTIFIER_LENGTH 31
#define MAX_ATTR_LENGTH 100

typedef struct {
    char name[MAX_IDENTIFIER_LENGTH];
    char attr[MAX_ATTR_LENGTH];
} Token;

typedef struct Node{
    Token data;
    struct Node *next;
} Node;

typedef struct{
    Node *head;
} SymbolTable;

SymbolTable* createSymbolTable(){
    SymbolTable *table = (SymbolTable*)malloc(sizeof(SymbolTable));
    table->head=NULL;
    return table;
}

void insertToSymbolTable(SymbolTable *table,const char *name,const char *attr){
    Node *newData = (Node*)malloc(sizeof(Node));
    strcpy(newData->data.name,name);
    strcpy(newData->data.attr,attr);
    newData->next=table->head;
    table->head=newData;
}


bool lookupSymbol(SymbolTable *table,const char *name){
    Node *current=table->head;
    while(current!=NULL){
        if(strcmp(current->data.name,name)==0) {
            return true;
        }
        current = current->next;
    }
    return false;
}

void printSymbolTable(SymbolTable* table) {
    int k=1;
    printf("-------------------------------------------------------------------\n");
    printf("Number\t|\tToken \t\t|\tToken Type \t\n");
    printf("-------------------------------------------------------------------\n");
    Node* current = table->head;
    while(current!=NULL){
        printf("%d\t%-30s\t\"%s\"\n", k++, current->data.name, current->data.attr);
        current = current->next;
    }
    printf("\n");
}

void destroySymbolTable(SymbolTable* table) {
    Node* current=table->head;
    while(current!=NULL){
        Node* temp=current;
        current = current->next;
        free(temp);
    }
    free(table);
}


