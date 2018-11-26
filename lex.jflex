import java.io.*;

%%

%byaccj

%{

  // Armazena uma referencia para o parser
  private Parser yyparser;

  // Construtor recebendo o parser como parametro adicional
  public Yylex(Reader r, Parser yyparser){
    this(r);
    this.yyparser = yyparser;
  }

%}

NL = \n | \r | \r\n

%%

incluir { return Parser.INCLUIR; }
funcao_principal { return Parser.PRINCIPAL; }
funcao { return Parser.FUNCAO; }
imprima { return Parser.IMPRIMA; }

\<.*\>  {
  yyparser.yylval = new ParserVal(yytext());
  return Parser.LIB;
}

\/\/.*  {
  yyparser.yylval = new ParserVal(yytext());
  return Parser.COMENTARIO;
}

\/\*.*\*\/  {
  yyparser.yylval = new ParserVal(yytext());
  return Parser.COMENTARIO;
}

inteiro { return Parser.INTEIRO; }
real { return Parser.REAL; }
caracter { return Parser.CARACTER; }

enquanto { return Parser.ENQUANTO; }
faca { return Parser.FACA; }
ate { return Parser.ATE; }
para { return Parser.PARA; }
se { return Parser.SE; }
senao { return Parser.SENAO; }
caso { return Parser.CASO; }
opcao { return Parser.OPCAO; }
fim_opcao { return Parser.FIM_OPCAO; }
retornar { return Parser.RETORNAR; }

":" { return Parser.DOIS_PONTOS; }
";" { return Parser.PONTO_VIRGULA; }
"," { return Parser.VIRGULA; }

[a-zA-Z][a-zA-Z0-9]*  {
  yyparser.yylval = new ParserVal(yytext());
  return Parser.ID;
}

[-]?[0-9]+ {
  yyparser.yylval = new ParserVal(yytext());
  return Parser.VALOR_INTEIRO;
}

[-]?[0-9]*\.?[0-9]+ {
  yyparser.yylval = new ParserVal(yytext());
  return Parser.VALOR_REAL;
}

\".*\"|\'.*\' {
  yyparser.yylval = new ParserVal(yytext());
  return Parser.VALOR_CARACTERE;
}

":="   { yyparser.yylval = new ParserVal(yytext()); return Parser.IGUAL; }
"("   { yyparser.yylval = new ParserVal(yytext()); return Parser.ABRE_PARENTESE; }
")"   { yyparser.yylval = new ParserVal(yytext()); return Parser.FECHA_PARENTESE; }
"{"   { yyparser.yylval = new ParserVal(yytext()); return Parser.ABRE_CHAVES; }
"}"   { yyparser.yylval = new ParserVal(yytext()); return Parser.FECHA_CHAVES; }
"["   { yyparser.yylval = new ParserVal(yytext()); return Parser.ABRE_COLCHETES; }
"]"   { yyparser.yylval = new ParserVal(yytext()); return Parser.FECHA_COLCHETES; }
"++"   { yyparser.yylval = new ParserVal(yytext()); return Parser.INCREMENTA; }
"--"   { yyparser.yylval = new ParserVal(yytext()); return Parser.DECREMENTA; }

"&&"  { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_AND; }
"||"  { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_OR; }
"<="  { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_LE; }
">="  { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_GE; }
"=="  { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_EQ; }
"!="  { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_NE; }
"-"   { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_SUB; }
"+"   { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_SUM; }
"*"   { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_MUL; }
"/"   { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_DIV; }
"%"   { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_PER; }
"<"   { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_LT; }
">"   { yyparser.yylval = new ParserVal(yytext()); return Parser.OP_GT; }

{NL}|" "|\t {  }