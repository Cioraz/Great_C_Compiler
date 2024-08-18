TEST_FILE ?= test1.c

all: scanner

scanner: lex.yy.c
	gcc -Wall lex.yy.c Scanner/scanner.c -o scanner -lfl

lex.yy.c: Scanner/scanner.l
	flex Scanner/scanner.l

run: scanner
	./scanner

check:

debug:
	./scanner tests/$(TEST_FILE)

clean:
	rm -f lex.yy.c scanner
