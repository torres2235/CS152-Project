%{
#include <stdio.h>
extern FILE * yyin;
extern int curLine;
void yyerror(const char *msg);
%}

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY
%token INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE
%token READ WRITE AND OR NOT TRUE FALSE RETURN FOR

%token SUB ADD MULT DIV MOD

%token EQ NEQ LT GT LTE GTE 

%token SEMICOLON COLON COMMA PERIOD L_PAREN R_PAREN  L_SQUARE_BRACKET
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

function : FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statement END_BODY
	   {printf("function -> FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statement END_BODY\n");}
	 ;

declarations : /*epsilon*/
               {printf("declarations -> epsilon\n");}
	     | declaration
	       {printf("declarations -> declaration");}
	     ;

declaration : identifier COLON array INTEGER
	      {printf("declaration -> identifier COLON array INTEGER");}
	    ;
identifier : IDENT comma
	     {printf("identifier -> IDENT comma");}
	   ;

comma : /*epsilon*/
	{printf("comma -> epsilon");}
      | COMMA identifier
	{printf("comma -> COMMA identifier");}
      ;

array : /*epsilon*/
	{printf("array -> epsilon");}
      | ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET array2 OF
	{printf("array -> ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET array2 OF");}
      ;

array2 : /*epsilon*/
	 {printf("array2 -> epsilon");}
       | L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET
	 {printf("array2 -> L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET");}
       ;

statement : var ASSIGN expression
	    {printf("statement -> var ASSIGN expression");}
	  | IF bool_expr THEN statement SEMICOLON state_recurse ENDIF
            {printf("statement -> IF bool_expr THEN statement SEMICOLON state_recurse ENDIF");}
	  | WHILE bool_expr BEGINLOOP statement SEMICOLON state_recurse ENDLOOP 
	    {printf("statement -> WHILE bool_expr BEGINLOOP statement SEMICOLON state_recurse END_LOOP");}
	  | DO BEGINLOOP statement SEMICOLON state_recurse ENDLOOP WHILE bool_expr 
	    {printf("statement -> DO BEGINLOOP statement SEMICOLON state_recurse ENDLOOP WHILE bool_expr");}
	  | FOR var ASSIGN NUMBER SEMICOLON bool_expr SEMICOLON var ASSIGN expression BEGINLOOP statement SEMICOLON state_recurse ENDLOOP 
	    {printf("statement -> FOR var ASSIGN NUMBER SEMICOLON bool_expr SEMICOLON var ASSIGN expression BEGIN_LOOP statement SEMICOLON state_recurse END_LOOP");}
	  | READ var comma3 
	    {printf("statement -> READ var comma3");}
	  | WRITE var comma3 
	    {printf("statement -> WRITE var comma3");}
	  | CONTINUE 
	    {printf("statement -> CONTINUE ");}
	  | RETURN expression
	    {printf("statement -> RETURN expression");}
	  ;

state_recurse : /*epsilon*/
	        {printf("state_recurse -> epsilon");}
	      | statement SEMICOLON state_recurse
                {printf("state_recurse -> statement SEMICOLON state_recurse");}
	      | ELSE state_recurse
                {printf("state_recurse -> ELSE state_recurse");}
	      ;

bool_expr : relation_and_expr or
	        {printf("bool_expr -> relation_and_expr or");}
	  ;

or : /*epsilon*/
     {printf("or -> epsilon");}
   | OR bool_expr
     {printf("or -> epsilon");}
   ;

and : /*epsilon*/
     {printf("and -> epsilon");}
   | AND relation_and_expr
     {printf("and -> AND relation_and_expr");}
   ;

relation_and_expr : relation_expr and
     {printf("relation_and_expr -> relation_expr and");}
   ;

relation_expr : not expression comp expression
                {printf("relation_expr -> not expression comp expression");}
              | not TRUE
     	        {printf("relation_expr -> not TRUE");}
              | not FALSE
     	        {printf("relation_expr -> not FALSE");}
              | not L_PAREN bool_expr R_PAREN
     	        {printf("relation_expr -> not L_PAREN bool_expr R_PAREN");}
              ;

not : /*epsilon*/
      {printf("not -> epsilon");}
    | NOT
      {printf("not -> not NOT");}
    ;

comp : EQ
      {printf("comp -> EQ");}
    | NEQ
      {printf("comp -> NEQ");}
    | LT
      {printf("comp -> LT");}
    | GT
      {printf("comp -> GT");}
    | LTE
      {printf("comp -> LTE");}
    | GTE
      {printf("comp -> GTE");}
    ;

var : IDENT
      {printf("var -> IDENT");}
    | IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET brack_exp
      {printf("var -> IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET brack_exp");}
    ;

brack_exp : /*epsilon*/
	    {printf("brack_exp -> epsilon");}
          | L_SQUARE_BRACKET expression R_SQUARE_BRACKET
	    {printf("brack_exp -> L_SQUARE_BRACKET expression R_SQUARE_BRACKET");}
          ;

expression : mult_expr add sub
	    {printf("expression -> mult_expr add sub");}
           ;

add : /*epsilon*/
      {printf("add -> epsilon");}
    | ADD expression
      {printf("add -> ADD expression");}
    ;

sub : /*epsilon*/
      {printf("sub -> epsilon");}
    | ADD expression
      {printf("sub -> SUB expression");}
    ;

mult_expr : term mult div mod
            {printf("mult_expr ->  term mult div mod");}
          ;

mult : /*epsilon*/
       {printf("mult -> epsilon");}
     | MULT mult_expr
       {printf("mult -> MULT mult_expr");}
     ;

div : /*epsilon*/
       {printf("div -> epsilon");}
     | DIV mult_expr
       {printf("div -> DIV mult_expr");}
     ;

mod : /*epsilon*/
       {printf("mod -> epsilon");}
     | DIV mult_expr
       {printf("mod -> MOD mult_expr");}
     ;

term : neg var
       {printf("term -> epsilon");}
     | neg NUMBER
       {printf("term -> neg NUMBER");}
     | neg L_PAREN expression R_PAREN
       {printf("term -> neg L_PAREN expression R_PAREN");}
     | IDENT L_PAREN expr R_PAREN
       {printf("term -> IDENT L_PAREN expr R_PAREN");}
     ;

neg : /*epsilon*/
       {printf("neg -> epsilon");}
     | SUB
       {printf("neg -> SUB");}
     ;

expr : /*epsilon*/
       {printf("expr -> epsilon");}
     | expression comma2
       {printf("expr -> expression comma2");}
     ;

comma2 : expr
         {printf("comma2 -> expr");}
       ;

comma3 : /*epsilon*/
         {printf("comma2 -> epsilon");}
       | var comma3
         {printf("var comma3");}
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

