%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "y.tab.h" //include bison file for tokens

int curLine = 1;
int curPos = 1;
%}

%%

		
function	{curPos += strlen(yytext); return FUNCTION;}
beginparams	{curPos += strlen(yytext); return BEGIN_PARAMS;}
endparams	{curPos += strlen(yytext); return END_PARAMS;}
beginlocals	{curPos += strlen(yytext); return BEGIN_LOCALS;}
endlocals	{curPos += strlen(yytext); return END_LOCALS;}
beginbody	{curPos += strlen(yytext); return BEGIN_BODY;}
endbody		{curPos += strlen(yytext); return END_BODY;}
integer		{curPos += strlen(yytext); return INTEGER;}
array		{curPos += strlen(yytext); return ARRAY;}
of		{curPos += strlen(yytext); return OF;}
if		{curPos += strlen(yytext); return IF;}
then		{curPos += strlen(yytext); return THEN;}
endif		{curPos += strlen(yytext); return ENDIF;}
else		{curPos += strlen(yytext); return ELSE;}
while		{curPos += strlen(yytext); return WHILE;}
do		{curPos += strlen(yytext); return DO;}
beginloop	{curPos += strlen(yytext); return BEGINLOOP;}
endloop		{curPos += strlen(yytext); return ENDLOOP;}
continue	{curPos += strlen(yytext); return CONTINUE;}
read		{curPos += strlen(yytext); return READ;}
write		{curPos += strlen(yytext); return WRITE;}
and		{curPos += strlen(yytext); return AND;}
or		{curPos += strlen(yytext); return OR;}
not		{curPos += strlen(yytext); return NOT;}
true		{curPos += strlen(yytext); return TRUE;}
false		{curPos += strlen(yytext); return FALSE;}
return		{curPos += strlen(yytext); return RETURN;}
for		{curPos += strlen(yytext); return FOR;}

"-"		{curPos += strlen(yytext); return SUB;}
"+"		{curPos += strlen(yytext); return ADD;}
"*"		{curPos += strlen(yytext); return MULT;}
"/"		{curPos += strlen(yytext); return DIV;}
"%"		{curPos += strlen(yytext); return MOD;}


"=="		{curPos += strlen(yytext); return EQ;}
"<>"		{curPos += strlen(yytext); return NEQ;}
"<"		{curPos += strlen(yytext); return LT;}
">"		{curPos += strlen(yytext); return GT;}
"<="		{curPos += strlen(yytext); return LTE;}
">="		{curPos += strlen(yytext); return GTE;}



"##"		curPos=1;/*No need to count curPos in comments, As Single line comments can not be followed by any code*/      
		

		
";"		{curPos += strlen(yytext); return SEMICOLON;}
":"		{curPos += strlen(yytext); return COLON;}
","		{curPos += strlen(yytext); return COMMA;}
"."		{curPos += strlen(yytext); return PERIOD;}
"|"		{curPos += strlen(yytext); return OR;}
"("		{curPos += strlen(yytext); return L_PAREN;}
")"		{curPos += strlen(yytext); return R_PAREN;}
"["		{curPos += strlen(yytext); return L_SQUARE_BRACKET;}
"]"		{curPos += strlen(yytext); return R_SQUARE_BRACKET;}
":="		{curPos += strlen(yytext); return ASSIGN;}


[0-9]+					{curPos += strlen(yytext); return NUMBER;}

[0-9_][a-zA-Z0-9_]*[a-zA-Z0-9_]      {printf("Error at line %d, column %d: Identifier \"%s\" must begin with a letter\n",curLine,curPos,yytext); curPos += strlen(yytext);exit(0);} 
[a-zA-Z][a-zA-Z0-9_]*[_]               {printf("Error at line %d, column %d: Identifier \"%s\" cannot end with an underscore\n",curLine,curPos,yytext); curPos += strlen(yytext);exit(0);} 
[a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9]	{curPos += strlen(yytext); return IDENT;/*Multi letter Identifier*/} 
[a-zA-Z][a-zA-Z0-9]*			{curPos += strlen(yytext); return IDENT;/*Single Letter Identifier and Multi letter Identifier with underscores */}


[ ]         	curPos++; 
[\t]		curPos++;
[\n]		{curLine++; curPos = 1;}

		
.		{printf("Error at line %d, column %d :unrecognized symbol \"%s\"\n",curLine,curPos,yytext);exit(0);}
%%


/*
int main(int argc, char* argv[])
{
    if(argc >= 2)
    {
        yyin = fopen(argv[1],"r");
        if(yyin == NULL) {
                yyin = stdin;
        }
    }
    else {
        yyin = stdin;
    }

    yylex();

    return 1;

}
*/
