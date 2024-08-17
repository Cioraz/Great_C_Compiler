all: scanner

scanner: lex.yy.c
	gcc -Wall lex.yy.c -o scanner -ll

lex.yy.c: scanner.l
	lex scanner.l

run: scanner
	./scanner

clean:
	rm -f scanner lex.yy.c
