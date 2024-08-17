all: scanner

scanner: lex.yy.c
	gcc -Wall lex.yy.c -o scanner -lfl

lex.yy.c: scanner.l
	flex scanner.l

run: scanner
	./scanner

check:
	

clean:
	rm -f scanner lex.yy.c
