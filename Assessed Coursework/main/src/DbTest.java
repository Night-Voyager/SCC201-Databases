import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbTest extends DbBasic{
    public DbTest() {
        super("LSH.db");

        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM planets;");

            while (rs.next()) {
                System.out.println(rs.getInt("popvalue"));
            }
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new DbTest();
    }
}
