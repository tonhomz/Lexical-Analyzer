import java.util.Scanner;
import java.io.FileReader;

class LexerMain {

	public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
        System.out.println("Start");

//        System.out.print("Enter file path: ");
//        String fileName = sc.nextLine();

        String fileName = "C:\\Users\\Prueksa\\Documents\\KMITL\\AT\\Project\\input.txt";
        System.out.println();

        Lexer l = new Lexer(new FileReader(fileName)); 
        l.yylex();
           
        }
}