%{
#include <stdio.h>
extern FILE * yyin;
extern int curLine;
void yyerror(const char *msg);
%}

%union{ char *cVal; int iVal;}

%token <iVal> NUMBER
%token <cVal> IDENT

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY
%token INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE
%token READ WRITE AND OR NOT TRUE FALSE RETURN FOR

%token SUB ADD MULT DIV MOD

%token EQ NEQ LT GT LTE GTE 

%token SEMICOLON COLON COMMA PERIOD L_PAREN R_PAREN  L_SQUARE_BRACKET
%token R_SQUARE_BRACKET ASSIGN

%start program

%%
program : functions
	  {printf("program -> functions\n");}
	;

functions : /*epsilon*/ 
            {printf("functions -> epsilon\n");}
	  | function functions
            {printf("functions -> function functions\n");}
	  ;

function : FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY
	   {printf("function -> FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY\n");}
	 ;

declarations : /*epsilon*/
               {printf("declarations -> epsilon\n");}
	     | declaration SEMICOLON declarations
	       {printf("declarations -> declaration SEMICOLON declarations\n");}
	     ;

declaration : identifier COLON INTEGER
	      {printf("declaration -> identifier COLON INTEGER\n");}
	    | identifier COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET array2 OF INTEGER
	      {printf("declaration -> identifier COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET array2 OF INTEGER\n");}
	    ;

identifier : ident
	     {printf("identifier -> ident\n");}
	   |  ident COMMA identifier
	     {printf("identifier -> ident COMMA identifier\n");}
	   ;

array2 : /*epsilon*/
	 {printf("array2 -> epsilon\n");}
       | L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET
	 {printf("array2 -> L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET\n");}
       ;

statements : statement SEMICOLON statements
	   {printf("statements -> statement SEMICOLON statements\n");}
	   | statement SEMICOLON
	   {printf("statements -> statement SEMICOLON\n");}
           ;

statement : var ASSIGN expression
	    {printf("statement -> var ASSIGN expression\n");}
	  | IF bool_expr THEN statements else ENDIF
            {printf("statement -> IF bool_expr THEN statements else ENDIF\n");}
	  | WHILE bool_expr BEGINLOOP statements ENDLOOP
	    {printf("statement -> WHILE bool_expr BEGINLOOP statements ENDLOOP\n");}
	  | DO BEGINLOOP statements ENDLOOP WHILE bool_expr 
	    {printf("statement -> DO BEGINLOOP statements ENDLOOP WHILE bool_expr \n");}
	  | FOR var ASSIGN NUMBER SEMICOLON bool_expr SEMICOLON var ASSIGN expression BEGINLOOP statements SEMICOLON ENDLOOP 
	    {printf("statement -> FOR var ASSIGN NUMBER SEMICOLON bool_expr SEMICOLON var ASSIGN expression BEGINLOOP statements SEMICOLON ENDLOOP\n");}
	  | READ vars 
	    {printf("statement -> READ vars\n");}
	  | WRITE vars
	    {printf("statement -> WRITE vars\n");}
	  | CONTINUE 
	    {printf("statement -> CONTINUE\n");}
	  | RETURN expression
	    {printf("statement -> RETURN expression\n");}
	  ;

else : /*epsilon*/
       {printf("else -> epsilon\n");}
     | ELSE statements
       {printf("else -> ELSE statements\n");}
     ;

vars: var
      {printf("vars -> var\n");}
    | var COMMA vars
      {printf("vars -> var COMMA vars\n");}
    ;

var : ident
      {printf("var -> ident\n");}
    | ident L_SQUARE_BRACKET expression R_SQUARE_BRACKET brack_exp
      {printf("var -> ident L_SQUARE_BRACKET expression R_SQUARE_BRACKET brack_exp\n");}
    ;

brack_exp : /*epsilon*/
	    {printf("brack_exp -> epsilon\n");}
          | L_SQUARE_BRACKET expression R_SQUARE_BRACKET
	    {printf("brack_exp -> L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");}
          ;

expressions : /*epsilon*/
	      {printf("expressions -> epsilon\n");}
            | expression COMMA expressions
	      {printf("expressions -> expression COMMA expressions\n");}
            | expression
	      {printf("expressions -> expression\n");}
	    ;

expression : mult_expr
	     {printf("expression -> mult_expr\n");}
	   | mult_expr ADD expression
	     {printf("expression -> mult_expr ADD expression\n");}
	   | mult_expr SUB expression
	     {printf("expression -> mult_expr SUB expression\n");}
           ;

mult_expr : term
            {printf("mult_expr ->  term\n");}
          | term MULT mult_expr
	    {printf("mult_expr -> term MULT mult_expr\n");}
	  | term DIV mult_expr
	    {printf("mult_expr -> term DIV mult_expr\n");}
	  | term MOD mult_expr
	    {printf("mult_expr -> term MOD mult_expr\n");}
          ;

term : var
       {printf("term -> var\n");}
     | SUB var
       {printf("term -> SUB var\n");}
     | NUMBER
       {printf("term -> NUMBER %d\n", $1);}
     | SUB NUMBER
       {printf("term -> SUB NUMBER %d\n", $2);}
     | L_PAREN expression R_PAREN
       {printf("term -> L_PAREN expression R_PAREN\n");}
     | SUB L_PAREN expression R_PAREN
       {printf("term -> neg L_PAREN expression R_PAREN\n");}
     | ident L_PAREN expressions R_PAREN
       {printf("term -> ident L_PAREN expressions R_PAREN\n");}
     ;
bool_expr : relation_and_expr
	    {printf("bool_expr -> relation_and_expr\n");}
	  | relation_and_expr OR bool_expr
	    {printf("bool_expr -> relation_and_expr OR bool_expr\n");}
          ;

relation_and_expr : relation_expr
	            {printf("relation_and_expr -> relation_expr\n");}
	          | relation_expr AND relation_and_expr
	            {printf("relation_and_expr -> relation_expr AND relation_and_expr\n");}
                  ;

relation_expr : NOT relation_expr2
		{printf("relation_expr -> NOT relation_expr2\n");}
              | relation_expr2
		{printf("relation_expr -> relation_expr2\n");}
              ;

relation_expr2 : expression comp expression
		 {printf("relation_expr2 -> expression comp expression\n");}
	       | TRUE
		 {printf("relation_expr2 -> TRUE\n");}
	       | FALSE
		 {printf("relation_expr2 -> FALSE\n");}
	       | L_PAREN bool_expr R_PAREN
		 {printf("relation_expr2 -> L_PAREN bool_expr R_PAREN\n");}
	       ;

comp : EQ
      {printf("comp -> EQ\n");}
    | NEQ
      {printf("comp -> NEQ\n");}
    | LT
      {printf("comp -> LT\n");}
    | GT
      {printf("comp -> GT\n");}
    | LTE
      {printf("comp -> LTE\n");}
    | GTE
      {printf("comp -> GTE\n");}
    ;

ident:      IDENT
	    {printf("ident -> IDENT %s \n", $1);}

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

