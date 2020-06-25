build: parser
y.tab.c: lex.yy.c
	bison -v -d --file-prefix=y mini-l.y
lex.yy.c:
	flex phase1.l
parser: y.tab.c
	gcc -o parser lex.yy.c y.tab.c -lfl
clean:
	rm lex.yy.c y.tab.c y.tab.h parser y.output

