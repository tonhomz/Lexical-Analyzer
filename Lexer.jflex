//user code

%%

//options and declairations

%class Lexer
%public
%unicode
%int

%{
    String []symbolTable = new String [100];
    int countIdentifier = 0;
%}

LineTerminator = \r | \n | \r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "*/"  
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}
Comment = {TraditionalComment} | {EndOfLineComment}
Identifier = [A-Za-z][A-Za-z0-9]*
DecIntegerLiteral = 0 | [1-9][0-9]*

%% 

//Lexical Rules
 
<YYINITIAL>
{
    "+" | "-" | "*" | "/" | "=" | ">" | ">=" | "<" | "<=" | "==" | "++" | "--"
    {
        System.out.println("operator: " + yytext());
    }

    "(" | ")" | ";"
    {
    if(yytext().equals(";")) 
        System.out.println("semicolon: "+ yytext());
    else
        System.out.println("parentheses: " + yytext());
    }

    "if" | "then" | "else" | "endif" | "while" | "do" | "endwhile" | "print" | "newline" | "read"
    {
        System.out.println("keyword: " + yytext());
    }

    {DecIntegerLiteral}
    {
        System.out.println("integer: " + yytext());
    }

    {Identifier}
    {
        String newIdentifier = yytext();
        if(countIdentifier == 0)
        {
            System.out.println("new identifier: " + newIdentifier);
            symbolTable[countIdentifier] = newIdentifier;
            countIdentifier++;
        }
        else
        {   
            boolean check = true;
            int count = 0;
            for(int i = 0; i < 100; i++) {
                if(symbolTable[i] != null) count++;
            }
            for(int j = 0; j < count; j++) {
                if(symbolTable[j].equals(newIdentifier))
                check = false;
            }

            if(check)
            {
                System.out.println("new identifier: " + newIdentifier);
                symbolTable[countIdentifier] = newIdentifier;
                countIdentifier++;
            } 
            else 
                System.out.println("identifier " + "\"" + newIdentifier + "\"" + " already in symbol table");       
        }
    }
    
    {DecIntegerLiteral}{Identifier}                                 
    { 
        System.out.println("error : " + yytext()); 
        System.exit(0); 
    }

    \"{InputCharacter}*\"                                           
    {
        System.out.println("string: " + yytext());
    }

    {Comment}
    { }

    {WhiteSpace}
    { }

}

[^]|\n
    { 
        System.out.println("error: " + yytext());
        System.exit(0);
    } 