%{
#include <stdio.h>
extern FILE * yyin;
extern int curLine;
void yyerror(const char *msg);
%}

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY
%token INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE
%token READ WRITE AND OR NOT TRUE FALSE

%token SUB ADD MULT DIV MOD

%token EQ NEQ LT GT LTE GTE 

%token SEMICOLON COLON COMMA PERIOD OR L_PAREN R_PAREN  L_SQUARE_BRACKET
%token R_SQUARE_BRACKET ASSIGN

%token IDENT NUMBER

%start program

%%
program : functions
	  {printf("program -> functions\n");}
	;

functions : /*epsilon*/
            {printf("functions -> epsilon\n");}
	  | function functions
            {printf("functions -> function Functions\n");}
	  ;

function : FUNCTION IDENT SEMICOLON
	   {printf("function -> FUNCTION IDENT SEMICOLON\n");}
	 ;


%%

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
    
    yyparse(); //calls yylex() 

    return 1;
    
}

void yyerror(const char *msg) {
	printf("Error in line %d : %s", curLine, msg);
}
