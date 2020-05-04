build: lexer
lexer: lex.yy.c
	gcc -o lexer lex.yy.c -lfl
lex.yy.c: cs152_phase1.lex
	flex cs152_phase1.lex
clean:
	rm lex.yy.c lexer *.o
