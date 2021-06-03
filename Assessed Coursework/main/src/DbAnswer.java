import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
            OutputStream file = new FileOutputStream("backup.sql");

            /*
             Generate the header with signature and date
             */
            String header = "" +
                    "/*\n" +
                    " Data Transfer\n\n" +
                    " Author\t\t: Hao Yukun\n" +
                    " LU ID\t\t: 37532073\n" +
                    " BJTU ID\t: 18722007\n\n"
                    ;
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
            header += " Date: " + dateFormat.format(date) + "\n*/\n";
            file.write(header.getBytes());

            /*
             Read data from database and generate SQL statements
             */
            ResultSet tables = metaData.getTables(null, null, null, new String[]{"TABLE"});
            while (tables.next()) {

                /*
                 Get table name and generate comments and statements
                 */
                String tableName = tables.getString("TABLE_NAME");

                String tableStructure = "\n" +
                        "-- ----------------------------\n" +
                        "-- Table structure for " + tableName + "\n" +
                        "-- ----------------------------\n" +
                        "DROP TABLE IF EXISTS `" + tableName + "`;\n" +
                        "CREATE TABLE `" + tableName + "` (\n"
                        ;

                /*
                 Read columns in each table and generate statements
                 */
                ResultSet columns = metaData.getColumns(null, null, tableName, null);
                while (columns.next()) {
                    String columnName = columns.getString("COLUMN_NAME");
                    String dataTypeName = columns.getString("TYPE_NAME");
                    tableStructure += "  `" + columnName + "` " + dataTypeName + ",\n";
                }
                tableStructure += ");\n";

                /*
                 Print current result on the console and write it in the target file
                 */
                System.out.print(tableStructure);
                file.write(tableStructure.getBytes());
            }
            file.close();

        } catch (SQLException | IOException exception) {
            /*
             Print message when an exception occurs, and close the connect to the database
             */
            notify(exception.getMessage(), exception);
            close();
        }
    }
}
