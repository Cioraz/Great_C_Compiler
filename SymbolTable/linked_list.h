#ifndef LINKED_UTILITY
#define LINKED_UTILITY

#include <stdbool.h>

#define MAX_IDENTIFIER_LENGTH 31
#define MAX_ATTR_LENGTH 100

typedef struct {
    char name[MAX_IDENTIFIER_LENGTH];
    char attr[MAX_ATTR_LENGTH];
} Token;

typedef struct Node {
    Token data;
    struct Node* next;
} Node;

typedef struct {
    Node* head;
} SymbolTable;

SymbolTable* createSymbolTable();
void insertToSymbolTable(SymbolTable* table, const char* name, const char* attr);
bool lookupSymbol(SymbolTable* table, const char* name);
void printSymbolTable(SymbolTable* table);
void destroySymbolTable(SymbolTable* table);


#endif 
