import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DbAnswer extends DbBasic{

    /**
     * Constructor
     * <p>
     * Records a copy of the database name and
     * opens the database for use
     *
     * @param _dbName String holding the name of the database,
     *                for example, C:/directory/subdir/mydb.db
     */
    public DbAnswer(String _dbName) {
        super(_dbName);
    }

    public void go() {
        try {
            DatabaseMetaData metaData = con.getMetaData();
            ResultSet tables = metaData.getTables(null, null, null, new String[]{"TABLE"});

            while (tables.next()) {
                System.out.println(tables.getString("TABLE_NAME"));
            }
        } catch (SQLException sqlException) {
            notify(sqlException.getMessage(), sqlException);
            close();
        }
    }
}
