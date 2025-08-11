import java.io.InputStreamReader;
%%


%public
%class NewLexico
%integer
%unicode
%line


%{


public static int NUM			= 258;

public static int ARRAY	= 265;
public static int JSON	= 266;
public static int OBJECT = 267;
public static int MEMBERS = 268;
public static int ELEMENTS = 269;
public static int VALUE = 270;
public static int STRING = 271;

/**
   * Runs the scanner on input files.
   *
   * This is a standalone scanner, it will print any unmatched
   * text to System.out unchanged.
   *
   * @param argv   the command line, contains the filenames to run
   *               the scanner on.
   */
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
          while ( !scanner.zzAtEOF ) 	
                System.out.println("token: "+scanner.yylex()+"\t<"+scanner.yytext()+">");
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

 
NUMBER=		[0-9]
LETTER=		[a-zA-Z]
WHITESPACE=	[ \t]
LineTerminator = \r|\n|\r\n 
FLOAT= [.]
   


%%



{NUMBER}+(\.{NUMBER}+)?                {return NUM;}

\"[^\"]*\"                  {return STRING;}



{WHITESPACE}+               { }
{LineTerminator}		{}
.          {System.out.println(yyline+1 + ": caracter invalido: "+yytext());}
