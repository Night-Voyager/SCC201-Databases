import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        System.out.println("Please enter the filename of the database without extension.\n" +
                "E.g., University, NOT University.db.");
        String dbName = in.next();

        DbAnswer dbAnswer = new DbAnswer(dbName);
        dbAnswer.go();
    }
}
