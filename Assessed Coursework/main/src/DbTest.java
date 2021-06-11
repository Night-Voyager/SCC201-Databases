import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbTest extends DbBasic{
    public DbTest() {
        super("Northwind.db");

        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Customers;");

            while (rs.next()) {
                System.out.println(rs.getString("Region"));
            }
        } catch (SQLException sqlException) {
            sqlException.printStackTrace();
        }
    }

    public static void main(String[] args) {
        new DbTest();
    }
}
