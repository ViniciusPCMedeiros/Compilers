import java.io.InputStreamReader;

%%

%public
%class NewLexico
%integer
%unicode
%line

%{

  public static int NUMBER	  = 258;
  public static int ARRAY	    = 265;
  public static int JSON	    = 266;
  public static int OBJECT    = 267;
  public static int MEMBERS   = 268;
  public static int ELEMENTS  = 269;
  public static int VALUE     = 270;
  public static int STRING    = 271;

  public static int DOISPONTOS = 290;
  public static int VIRGULA    = 291;
  public static int LCHAVE     = 292;
  public static int RCHAVE     = 293;
  public static int LCOLCH     = 294;
  public static int RCOLCH     = 295;


  public static void main(String argv[]) {
    NewLexico scanner;
    if (argv.length == 0) {
      try {        
        // scanner = new MeuLexico( System.in );
        scanner = new NewLexico( new InputStreamReader(System.in) );
        while ( !scanner.zzAtEOF ) 
        System.out.println("token: "+scanner.yylex()+"\t<"+scanner.yytext()+">");
      }
      
      catch (Exception e) {
        System.out.println("Unexpected exception:");
        e.printStackTrace();
      }
          
    }
      
    else {
      for (int i = 0; i < argv.length; i++) {
        scanner = null;
        try {
          scanner = new NewLexico( new java.io.FileReader(argv[i]) );
          while ( !scanner.zzAtEOF ){
            token = scanner.yylex();
            System.out.println("token: " + token + "\t<" + scanner.yytext() + ">\tlinha: " + (scanner.yyline + 1));
          }
        }
        catch (java.io.FileNotFoundException e) {
          System.out.println("File not found : \""+argv[i]+"\"");
        }
        catch (java.io.IOException e) {
          System.out.println("IO error scanning file \""+argv[i]+"\"");
          System.out.println(e);
        }
        catch (Exception e) {  
          System.out.println("Unexpected exception:");
          e.printStackTrace();
          
        }    
      }
    }
  }

%}

DIGIT=		[0-9]
LETTER=		[a-zA-Z]
WHITESPACE=	[ \t]
LineTerminator = \r|\n|\r\n 
CHAR = [^\"]

%%

"{" {return LCHAVE;}
"}" {return RCHAVE;}
"[" {return LCOLCH;}
"]" {return RCOLCH;}
":" {return DOISPONTOS;}
"," {return VIRGULA;}

{DIGIT}+(\.{DIGIT}+)?     {return NUMBER;}
\"{CHAR}*\"               {return STRING;}

{WHITESPACE}+               { }
{LineTerminator}		        {}

.               { System.err.println("Caractere inválido: " + yytext() + " na linha " + (yyline + 1)); }