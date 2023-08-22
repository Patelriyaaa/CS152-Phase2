/* MiniL Compiler - Phase 1 */

%{
    /* Definitions and headers */
    #include "miniL-parser.h"
    int currentLine = 1, currentPos = 0;
%}

DIGIT    [0-9]
ALPHA    [a-zA-Z]
SYMBOL   [!, @, #, $, %, ^, &, *, (, ), -, _, =, +, ,, ., /, ?, ;, :, ', ", |, {, }, <, >, "\", `, ~]

/* Common rules */

%%

/* Lexer rules using regular expressions */
"function"      {currentPos += yyleng; return FUNCTION;}
"beginparams"   {currentPos += yyleng; return BEGIN_PARAMS;}
"endparams"     {currentPos += yyleng; return END_PARAMS;}
"beginlocals"   {currentPos += yyleng; return BEGIN_LOCALS;}
"endlocals"     {currentPos += yyleng; return END_LOCALS;}
"beginbody"     {currentPos += yyleng; return BEGIN_BODY;}
"endbody"       {currentPos += yyleng; return END_BODY;}
"integer"       {currentPos += yyleng; return INTEGER;}
"array"         {currentPos += yyleng; return ARRAY;}
"enum"          {currentPos += yyleng; return ENUM;}
"of"            {currentPos += yyleng; return OF;}
"if"            {currentPos += yyleng; return IF;}
"then"          {currentPos += yyleng; return THEN;}
"endif"         {currentPos += yyleng; return ENDIF;}
"else"          {currentPos += yyleng; return ELSE;}
"for"           {currentPos += yyleng; return FOR;}
"while"         {currentPos += yyleng; return WHILE;}
"do"            {currentPos += yyleng; return DO;}
"beginloop"     {currentPos += yyleng; return BEGINLOOP;}
"endloop"       {currentPos += yyleng; return ENDLOOP;}
"continue"      {currentPos += yyleng; return CONTINUE;}
"read"          {currentPos += yyleng; return READ;}
"write"         {currentPos += yyleng; return WRITE;}
"and"           {currentPos += yyleng; return AND;}
"or"            {currentPos += yyleng; return OR;}
"not"           {currentPos += yyleng; return NOT;}
"true"          {currentPos += yyleng; return TRUE;}
"false"         {currentPos += yyleng; return FALSE;}
"return"        {currentPos += yyleng; return RETURN;}
"-"             {currentPos += yyleng; return SUB;}
"+"             {currentPos += yyleng; return ADD;}
"*"             {currentPos += yyleng; return MULT;}
"/"             {currentPos += yyleng; return DIV;}
"%"             {currentPos += yyleng; return MOD;}
"=="            {currentPos += yyleng; return EQ;}
"<>"            {currentPos += yyleng; return NEQ;}
"<"             {currentPos += yyleng; return LT;}
">"             {currentPos += yyleng; return GT;}
"<="            {currentPos += yyleng; return LTE;}
">="            {currentPos += yyleng; return GTE;}
";"             {currentPos += yyleng; return SEMICOLON;}
":"             {currentPos += yyleng; return COLON;}
","             {currentPos += yyleng; return COMMA;}
"("             {currentPos += yyleng; return L_PAREN;}
")"             {currentPos += yyleng; return R_PAREN;}
"["             {currentPos += yyleng; return L_SQUARE_BRACKET;}
"]"             {currentPos += yyleng; return R_SQUARE_BRACKET;}
":="            {currentPos += yyleng; return ASSIGN;}
"="             {currentPos += yyleng; return EQ_SIGN;}
{DIGIT}+        {currentPos += yyleng; yylval.ival = atoi(yytext); return NUMBER;}

({DIGIT}+({ALPHA}|"_")+({DIGIT}|{ALPHA}|"_")*)   {printf("Error at line %d, column %d: identifier \"%s\" must start with a letter\n", currentLine, currentPos, yytext); exit(0);}

("_"({DIGIT}|{ALPHA}|"_")*) {printf("Error at line %d, column %d: identifier \"%s\" must start with a letter\n", currentLine, currentPos, yytext); exit(0);}
(({DIGIT}|{ALPHA})+"_")     {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", currentLine, currentPos, yytext); exit(0);}

({ALPHA}({ALPHA}|{DIGIT}|"_")*({ALPHA}|{DIGIT})*) {currentPos += yyleng; yylval.str = yytext; return IDENT;}
("##"({ALPHA}|{DIGIT}|{SYMBOL}|"["|"]")*"\n") {currentLine++; currentPos = 0;}

[ \t]+         {/* Ignore spaces */ currentPos += yyleng;}
"\n"           {currentLine++; currentPos = 0;}
.              {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currentLine, currentPos, yytext); exit(0);}

%%

/* C functions for lexer */
/*
int main(int argc, char ** argv)
{
   if(argc >= 2)
   {
      yyin = fopen(argv[1], "r");
      if(yyin == NULL)
      {
         yyin = stdin;
      }
   }
   else
   {
      yyin = stdin;
   }
   yylex();
}
*/
