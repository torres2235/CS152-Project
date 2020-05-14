build: parser

parser: y.tab.c
	gcc -o lex.yy.c y.tab.c -lfl
y.tab.c: mini-l.y
	bison -v -d --file-prefix=y mini-l.y
lexer: lex.yy.c
	gcc -o lexer lex.yy.c -lfl
lex.yy.c: cs152_phase1.lex
	flex phase1.l
clean:
	rm lex.yy.c y.tab.c y.tab.h parse y.output
