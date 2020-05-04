%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int curLine = 1;
int curPos = 1;
%}

%%

		
function	{printf("FUNCTION\n"); curPos += strlen(yytext);}
beginparams	{printf("BEGIN_PARAMS\n"); curPos += strlen(yytext);}
endparams	{printf("END_PARAMS\n"); curPos += strlen(yytext);}
beginlocals	{printf("BEGIN_LOCALS\n"); curPos += strlen(yytext);}
endlocals	{printf("END_LOCALS\n"); curPos += strlen(yytext);}
beginbody	{printf("BEGIN_BODY\n"); curPos += strlen(yytext);}
endbody		{printf("END_BODY\n"); curPos += strlen(yytext);}
integer		{printf("INTEGER\n"); curPos += strlen(yytext);}
array		{printf("ARRAY\n"); curPos += strlen(yytext);}
of		{printf("OF\n"); curPos += strlen(yytext);}
if		{printf("IF\n"); curPos += strlen(yytext);}
then		{printf("THEN\n"); curPos += strlen(yytext);}
endif		{printf("ENDIF\n"); curPos += strlen(yytext);}
else		{printf("ELSE\n"); curPos += strlen(yytext);}
while		{printf("WHILE\n"); curPos += strlen(yytext);}
do		{printf("DO\n");curPos += strlen(yytext);}
beginloop	{printf("BEGINLOOP\n"); curPos += strlen(yytext);}
endloop		{printf("ENDLOOP\n"); curPos += strlen(yytext);}
continue	{printf("CONTINUE\n"); curPos += strlen(yytext);}
read		{printf("READ\n"); curPos += strlen(yytext);}
write		{printf("WRITE\n"); curPos += strlen(yytext);}
and		{printf("AND\n"); curPos += strlen(yytext);}
or		{printf("OR\n"); curPos += strlen(yytext);}
not		{printf("NOT\n"); curPos += strlen(yytext);}
true		{printf("TRUE\n"); curPos += strlen(yytext);}
false		{printf("FALSE\n"); curPos += strlen(yytext);}
		

"-"		{printf("SUB\n"); curPos += strlen(yytext);}
"+"		{printf("ADD\n"); curPos += strlen(yytext);}
"*"		{printf("MULT\n"); curPos += strlen(yytext);}
"/"		{printf("DIV\n"); curPos += strlen(yytext);}
"%"		{printf("MOD\n"); curPos += strlen(yytext);}


"=="		{printf("EQ\n"); curPos += strlen(yytext);}
"<>"		{printf("NEQ\n"); curPos += strlen(yytext);}
"<"		{printf("LT\n"); curPos += strlen(yytext);}
">"		{printf("GT\n"); curPos += strlen(yytext);}
"<="		{printf("LTE\n"); curPos += strlen(yytext);}
">="		{printf("GTE\n"); curPos += strlen(yytext);}



"##"		curPos=1;/*No need to count curPos in comments, As Single line comments can not be followed by any code*/      
		

		
";"		{printf("SEMICOLON\n"); curPos += strlen(yytext);}
":"		{printf("COLON\n"); curPos += strlen(yytext);}
","		{printf("COMMA\n"); curPos += strlen(yytext);}
"."		{printf("PERIOD\n"); curPos += strlen(yytext);}
"|"		{printf("OR\n"); curPos += strlen(yytext);}
"("		{printf("L_PAREN\n"); curPos += strlen(yytext);}
")"		{printf("R_PAREN\n"); curPos += strlen(yytext);}
"["		{printf("L_SQUARE_BRACKET\n"); curPos += strlen(yytext);}
"]"		{printf("R_SQUARE_BRACKET\n"); curPos += strlen(yytext);}
":="		{printf("ASSIGN\n"); curPos += strlen(yytext);}


[0-9]+					{printf("NUMBER %s\n",yytext); curPos += strlen(yytext);}

[0-9|_][a-zA-Z0-9|_]*[a-zA-Z0-9|_]      {printf("Error at line %d, column %d: Identifier \"%s\" must begin with a letter\n",curLine,curPos,yytext); curPos += strlen(yytext);exit(0);} 
[a-zA-Z][a-zA-Z0-9|_]*[_]               {printf("Error at line %d, column %d: Identifier \"%s\" cannot end with an underscore\n",curLine,curPos,yytext); curPos += strlen(yytext);exit(0);} 
[a-zA-Z][a-zA-Z0-9|_]*[a-zA-Z0-9]	{printf("IDENT %s\n", yytext); curPos += strlen(yytext);/*Multi letter Identifier*/} 
[a-zA-Z][a-zA-Z0-9]*			{printf("IDENT %s\n", yytext); curPos += strlen(yytext);/*Single Letter Identifier and Multi letter Identifier with underscores */}


[ ]         	curPos++; 
[\t]		curPos++;
[\n]		{curLine++; curPos = 1;}

		
.		{printf("Error at line %d, column %d :unrecognized symbol \"%s\"\n",curLine,curPos,yytext);exit(0);}
%%


int main(int argc, char* argv[])
{
    if(argc == 2)
    {
	yyin = fopen(argv[1],"r");
	yylex();
	fclose(yyin);
    }
    else
        yylex();
}
