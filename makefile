all: scanner

scanner: lex.yy.c
	gcc -Wall lex.yy.c Scanner/scanner.c -o scanner -lfl

lex.yy.c: Scanner/scanner.l
	flex Scanner/scanner.l

run: scanner
	./scanner

check:
	

clean:
	rm -f lex.yy.c scanner
