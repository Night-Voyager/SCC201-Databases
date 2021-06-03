import java.sql.Statement;

public class DbAnswer extends DbBasic{
    private Statement stmt;

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

    }
}
