build: lexer
lexer: lex.yy.c
	gcc -o lexer lex.yy.c -lfl
lex.yy.c: phase1.l
	flex phase1.l
clean:
	rm lex.yy.c lexer *.o

