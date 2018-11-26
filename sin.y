%{
  import java.io.*;
  import java.util.*;
%}


/* BYACC Declarations */
%token <sval> ID
%token <sval> LIB
%token <sval> COMENTARIO
%token <sval> VALOR_INTEIRO
%token <sval> VALOR_CARACTERE
%token <sval> VALOR_REAL

%token CARACTER
%token CASO
%token OPCAO
%token FIM_OPCAO
%token DECREMENTA
%token DOIS_PONTOS
%token FUNCAO
%token IMPRIMA
%token INCLUIR
%token INCREMENTA
%token INTEIRO
%token IGUAL
%token PRINCIPAL
%token PONTO_VIRGULA
%token REAL
%token RETORNAR
%token SE
%token SENAO
%token VIRGULA
%token OP_AND
%token OP_OR
%token OP_LE
%token OP_GE
%token OP_LT
%token OP_GT
%token OP_EQ
%token OP_NE
%token OP_SUB
%token OP_SUM
%token OP_MUL
%token OP_DIV
%token OP_PER

%token ENQUANTO
%token FACA
%token ATE
%token PARA

%token ABRE_COLCHETES
%token FECHA_COLCHETES
%token ABRE_CHAVES
%token FECHA_CHAVES
%token ABRE_PARENTESE
%token FECHA_PARENTESE

%type <sval> argumentos
%type <sval> array
%type <sval> atribuicao
%type <sval> caso
%type <sval> chamada_funcao
%type <sval> comentario
%type <sval> declaracao
%type <sval> enquanto
%type <sval> expressao
%type <sval> facaate
%type <sval> funcao
%type <sval> imprima
%type <sval> incluir
%type <sval> incrementa
%type <sval> opcao
%type <sval> operador
%type <sval> para
%type <sval> parametros
%type <sval> principal
%type <sval> programa
%type <sval> retornar
%type <sval> se
%type <sval> senao
%type <sval> tipo
%type <sval> tipo_funcao
%type <sval> valor
%type <sval> variavel


%%

init
  : programa { System.out.println($1); }

programa
  :   { $$ = ""; }
  | incluir programa { $$ = $1 + "\n" + $2; }
  | principal programa { $$ = $1 + "\n" + $2; }
  | comentario programa { $$ = $1 + "\n" + $2; }
  | retornar programa { $$ = $1 + "\n" + $2; }
  | funcao programa { $$ = $1 + "\n" + $2; }
  | declaracao programa { $$ = $1 + "\n" + $2; }
  | atribuicao programa { $$ = $1 + "\n" + $2; }
  | imprima programa { $$ = $1 + "\n" + $2; }
  | enquanto programa { $$ = $1 + "\n" + $2; }
  | facaate programa { $$ = $1 + "\n" + $2; }
  | para programa { $$ = $1 + "\n" + $2; }
  | se programa { $$ = $1 + "\n" + $2; }
  | caso programa { $$ = $1 + "\n" + $2; }

funcao
  : FUNCAO tipo_funcao ID ABRE_PARENTESE parametros FECHA_PARENTESE ABRE_CHAVES programa FECHA_CHAVES { $$ = $2 + $3 + "(" + $5 + "){\n" + $8 + "\n}"; }

parametros
  : { $$ = ""; }
  | tipo ID array { $$ = $1 + $2 + $3; }

imprima
  : IMPRIMA ABRE_PARENTESE VALOR_CARACTERE VIRGULA valor FECHA_PARENTESE { $$ = " printf(" + $3 + ", " + $5 + ");"; }

atribuicao
  : incrementa { $$ = $1 + ";"; }
  | variavel IGUAL expressao { $$ = " " + $1 + " = " + $3 + ";";}
  | tipo ID array IGUAL expressao { $$ = $1 +$2 + $3 + " = " + $5 + ";"; }

incrementa
  : variavel DECREMENTA { $$ = " " + $1 + "--"; }
  | variavel INCREMENTA { $$ = " " + $1 + "++"; }

expressao
  : valor { $$ = $1; }
  | valor operador expressao { $$ = $1 + " " + $2 + " " + $3; }
  | ABRE_PARENTESE expressao FECHA_PARENTESE { $$ = "(" + $2 + ")"; }

valor
  : variavel { $$ = $1; }
  | VALOR_INTEIRO { $$ = $1; }
  | VALOR_CARACTERE { $$ = $1; }
  | VALOR_REAL { $$ = $1; }
  | chamada_funcao

argumentos
  : { $$ = ""; }
  | valor { $$ = $1; }

chamada_funcao
  : ID ABRE_PARENTESE argumentos FECHA_PARENTESE{ $$ = $1 + "(" + $3 + ")";}

retornar
  :   { $$ = ""; }
  | RETORNAR expressao { $$ = " return " + $2 + ";"; }

operador
  : OP_AND { $$ = "&&"; }
  | OP_OR { $$ = "||"; }
  | OP_LE { $$ = "<="; }
  | OP_GE { $$ = ">="; }
  | OP_LT { $$ = "<"; }
  | OP_GT { $$ = ">"; }
  | OP_EQ { $$ = "=="; }
  | OP_NE { $$ = "!="; }
  | OP_SUB { $$ = "-"; }
  | OP_SUM { $$ = "+"; }
  | OP_MUL { $$ = "*"; }
  | OP_DIV { $$ = "/"; }
  | OP_PER { $$ = "%"; }

variavel
  : ID array { $$ = $1 + $2; }

incluir
  : INCLUIR LIB { $$ = "#include " + $2; }

principal 
  : PRINCIPAL ABRE_CHAVES programa FECHA_CHAVES { $$ = "int main() {\n" + $3 + "}"; }

comentario
  : COMENTARIO { $$ =  ""; }

declaracao
  : tipo ID array { $$ = $1 + $2 + $3 + ";"; }

tipo
  : INTEIRO { $$ = " int "; }
  | REAL { $$ = " float "; }
  | CARACTER { $$ = " char "; }

tipo_funcao
  : INTEIRO { $$ = "int "; }
  | REAL { $$ = "float "; }
  | CARACTER { $$ = "char "; }

array
  :   { $$ = ""; }
  | ABRE_COLCHETES valor FECHA_COLCHETES {$$ = "["+ $2 +"]";}

enquanto
  : ENQUANTO ABRE_PARENTESE expressao FECHA_PARENTESE ABRE_CHAVES programa FECHA_CHAVES { $$ = "while (" + $3 + ") {\n" + $6 + "}"; }

facaate
  : FACA ABRE_CHAVES programa FECHA_CHAVES ATE ABRE_PARENTESE expressao FECHA_PARENTESE { $$ = "do {\n" + $3 + "} while(" + $7 + ");"; }

para
  : PARA ABRE_PARENTESE atribuicao PONTO_VIRGULA expressao PONTO_VIRGULA incrementa FECHA_PARENTESE ABRE_CHAVES programa FECHA_CHAVES { $$ = "for (" + $3 + $5 + ";" + $7 + ") {\n" + $10 + "}"; }

se 
  : SE ABRE_PARENTESE expressao FECHA_PARENTESE ABRE_CHAVES programa FECHA_CHAVES senao { $$ = "if (" + $3 + ") {\n" + $6 + "}" + $8; }
  | SE ABRE_PARENTESE expressao FECHA_PARENTESE { $$ = "if (" + $3 + ")"; }

senao
  :   { $$ = ""; }
  | SENAO ABRE_CHAVES programa FECHA_CHAVES { $$ = " else {\n" + $3 + "}"; }

caso 
  : CASO ABRE_PARENTESE variavel FECHA_PARENTESE ABRE_CHAVES opcao FECHA_CHAVES { $$ = "switch(" + $3 + "){\n" + $6 + "}"; }

opcao
  :   { $$ = ""; }
  | OPCAO valor DOIS_PONTOS programa FIM_OPCAO opcao { $$ = " case " + $2 + ":\n" + $4 + " break;\n" + $6; }
%%

  // Referencia ao JFlex
  private Yylex lexer;

  /* Interface com o JFlex */
  private int yylex(){
    int yyl_return = -1;
    try {
      yyl_return = lexer.yylex();
    } catch (IOException e) {
      System.err.println("Erro de IO: " + e);
    }
    return yyl_return;
  }

  /* Reporte de erro */
  public void yyerror(String error){
    System.err.println("Error: " + error);
  }

  // Interface com o JFlex eh criado no construtor
  public Parser(Reader r){
    lexer = new Yylex(r, this);
  }

  // Main
  public static void main(String[] args){
    try{
      Parser yyparser = new Parser(new FileReader(args[0]));
      yyparser.yyparse();
      } catch (IOException ex) {
        System.err.println("Error: " + ex);
      }
  }
