import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.regex.Pattern;

public class DbAnswer extends DbBasic{
    /*
     A list of numerical types

     **NOTICE**: it has been tested that the type codes in java.sql.Types is not the same as the codes returned by
                 DatabaseMetaData.getColumns(null, null, tableName, null).getInt("DATA_TYPE");

     It is unnecessary to get all numerical types involved, String.contains() can help to do the match.
     */
    String [] numericalTypes = {"INT", "FLOAT", "REAL", "DOUBLE", "NUMERIC", "DECIMAL"};

    public DbAnswer(String _dbName) {
        super(_dbName);
    }

    public void go() {
        try {
            DatabaseMetaData metaData = con.getMetaData();

            /*
             Generate the target file for backup
             */
            String databaseName = dbName.substring(0, dbName.lastIndexOf('.'));
            OutputStream file = new FileOutputStream(databaseName + "_backup.sql");

            /*
             Generate the header with signature and date
             */
            StringBuffer header = new StringBuffer(
                    "/*\n" +
                    " Data Transfer\n\n" +
                    " Author\t\t: Hao Yukun\n" +
                    " LU ID\t\t: 37532073\n" +
                    " BJTU ID\t: 18722007\n\n" +
                    " Source File: " + dbName + "\n"
            );
            Date date = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
            header.append(" Date: ").append(dateFormat.format(date)).append("\n*/\n");
            file.write(header.toString().getBytes());

            /*
             Remove foreign key constraints
             */
            StringBuffer foreignKeyConstraints = new StringBuffer("\nPRAGMA foreign_keys = false;\n");
            System.out.print(foreignKeyConstraints);
            file.write(foreignKeyConstraints.toString().getBytes());

            /*
             Read data from database and generate SQL statements
             */
            ResultSet tables = metaData.getTables(null, null, null, new String[]{"TABLE"});
            while (tables.next()) {

                /*
                 Get table name and generate comments and statements
                 */
                String tableName = tables.getString("TABLE_NAME");

                StringBuffer tableStructure = new StringBuffer(
                        "\n" +
                        "-- ----------------------------\n" +
                        "-- Table structure for " + tableName + "\n" +
                        "-- ----------------------------\n" +
                        "DROP TABLE IF EXISTS \"" + tableName + "\";\n" +
                        "CREATE TABLE \"" + tableName + "\" ("
                );

                /*
                 Read columns in each table and generate statements
                 */
                ResultSet columns = metaData.getColumns(null, null, tableName, null);
                ArrayList<String> columnNameArrayList = new ArrayList<>();
                ArrayList<String> dataTypeNameArrayList = new ArrayList<>();

                while (columns.next()) {
                    String columnName = columns.getString("COLUMN_NAME");
                    columnNameArrayList.add(columnName);

                    String dataTypeName = columns.getString("TYPE_NAME");
                    dataTypeNameArrayList.add(dataTypeName);

                    tableStructure.append("\n  \"").append(columnName).append("\" ").append(dataTypeName).append(",");
                }

                /*
                 Get primary key for each table and generate statement
                 */
                ResultSet primaryKey = metaData.getPrimaryKeys(null, null, tableName);
                tableStructure.append("\n  PRIMARY KEY (");
                while (primaryKey.next()) {
                    tableStructure.append("\"").append(primaryKey.getString("COLUMN_NAME")).append("\", ");
                }
                tableStructure.delete(tableStructure.length()-2, tableStructure.length()).append(")");

                /*
                 Get foreign keys for each table and generate statement
                 */
                ResultSet foreignKeys = metaData.getImportedKeys(null, null, tableName);
                while (foreignKeys.next()) {
                    tableStructure
                            .append(",\n  FOREIGN KEY ")
                            .append("(\"").append(foreignKeys.getString("FKCOLUMN_NAME")).append("\") ")
                            .append("REFERENCES \"").append(foreignKeys.getString("PKTABLE_NAME")).append("\" ")
                            .append("(\"").append(foreignKeys.getString("PKCOLUMN_NAME")).append("\")")
                    ;
                }

                tableStructure.append("\n);\n");

                /*
                 Print current result on the console and write it in the target file
                 */
                System.out.print(tableStructure);
                file.write(tableStructure.toString().getBytes());

                /*
                 Read records and generate statements
                 */
                StringBuffer records = new StringBuffer(
                        "\n" +
                        "-- ----------------------------\n" +
                        "-- Records of " + tableName + "\n" +
                        "-- ----------------------------\n"
                );

                Statement stmt = con.createStatement();
                ResultSet values = stmt.executeQuery("SELECT * FROM `" + tableName + "`");
                while (values.next()) {
                    records.append("INSERT INTO \"").append(tableName).append("\" VALUES (");

                    for (int i = 0; i < columnNameArrayList.size(); i++) {

                        String value = values.getString(columnNameArrayList.get(i));

                        // handle null values
                        if (value == null) {
                            records.append("NULL").append(", ");
                            continue;
                        }

                        // handle values of numerical type
                        if (isTypeContained(numericalTypes, dataTypeNameArrayList.get(i))) {
                            Pattern pattern = Pattern.compile("(\\-|\\+)?\\d+(\\.\\d+)?");

                            if (pattern.matcher(value).matches())
                                records.append(value);
                            else
                                records.append("'").append(value).append("'"); // handle non-numerical values in numerical type fields

                            records.append(", ");
                            continue;
                        }

                        // handle values of BLOB type
                        //
                        // The getBlob() method is not implemented by the given SQLite JDBC driver,
                        // hence blob is handled as bytes here.
                        if (dataTypeNameArrayList.get(i).contains("BLOB")) {

                            // read data from database as a byte array
                            byte [] byteValue = values.getBytes(columnNameArrayList.get(i));

                            StringBuffer hexValue = new StringBuffer();
                            String temp;

                            // transform the byte array into a string of hexadecimal digits
                            // reference: https://www.cnblogs.com/dbutil/p/9441111.html
                            for (byte b : byteValue) {
                                temp = Integer.toHexString(b & 0xFF);
                                hexValue.append( (temp.length() == 1)? "0" + temp : temp); // Each byte is represented by two bits.
                                                                                           // If the number of bits is not enough,
                                                                                           // then fill the higher bit with "0".
                            }

                            // add the data in the type of the string of hexadecimal digits into the string for output
                            records.append("'").append(hexValue).append("'").append(", ");
                            continue;
                        }

                        // handle the remaining values as strings
                        records.append("'").append(value.replaceAll("'", "''")).append("', ");
                    }

                    records.delete(records.length()-2, records.length()).append(");\n");
                }

                /*
                 Print generated statements of the records on the console and write them in the target file
                 */
                System.out.print(records);
                file.write(records.toString().getBytes());
            }

            /*
             Recover foreign key constraints
             */
            foreignKeyConstraints = new StringBuffer("\nPRAGMA foreign_keys = true;\n");
            System.out.print(foreignKeyConstraints);
            file.write(foreignKeyConstraints.toString().getBytes());

            file.close();

        } catch (SQLException | IOException exception) {
            /*
             Print message when an exception occurs, and close the connection to the database
             */
            notify(exception.getMessage(), exception);
            close();
        }
    }

    private boolean isTypeContained(String [] typeList, String type) {
        for (String type_in_list : typeList) {
            if (type.contains(type_in_list)) return true;
        }
        return false;
    }
}
