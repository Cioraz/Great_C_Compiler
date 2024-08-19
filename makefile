TEST_FILE ?= test1.c

all: scanner

scanner: lex.yy.c
	gcc -I./SymbolTable -o scanner lex.yy.c SymbolTable/linked_list.c

lex.yy.c: Scanner/scanner.l
	flex Scanner/scanner.l

run: scanner
	./scanner

check:

debug:
	./scanner tests/$(TEST_FILE)

clean:
	rm -f lex.yy.c scanner
