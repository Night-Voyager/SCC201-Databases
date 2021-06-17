import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.regex.Pattern;

public class DbAnswer{
    String dbName;

    DbBasic sourceDb;
    Connection sourceDbCon;
    DbBasic targetDb;
    Connection targetDbCon;

    /*
     A list of numerical types

     **NOTICE**: it has been tested that the type codes in java.sql.Types is not the same as the codes returned by
                 DatabaseMetaData.getColumns(null, null, tableName, null).getInt("DATA_TYPE");

     It is unnecessary to get all numerical types involved, String.contains() can help to do the match.
     */
    String [] numericalTypes = {"INT", "FLOAT", "REAL", "DOUBLE", "NUMERIC", "DECIMAL"};

    public DbAnswer(String dbName) {
        this.dbName = dbName;

        /*
         Initialize database connections
         */
        sourceDb = new DbBasic(dbName + ".db");
        sourceDbCon = sourceDb.con;
        targetDb = new DbBasic(dbName + "_backup.db");
        targetDbCon = targetDb.con;
    }

    public void go() {
        try {
            DatabaseMetaData metaData = sourceDbCon.getMetaData();

            /*
             Generate the target file for backup
             */
            OutputStream file = new FileOutputStream(dbName + "_backup.sql");

            /*
             Generate the header with signature and date
             */
            StringBuffer header = new StringBuffer(
                    "/*\n" +
                    " Data Transfer\n\n" +
                    " Author\t\t: Hao Yukun\n" +
                    " LU ID\t\t: 37532073\n" +
                    " BJTU ID\t: 18722007\n\n" +
                    " Source File: " + dbName + ".db\n"
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
            targetDbCon.createStatement().executeUpdate(foreignKeyConstraints.toString());

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

                    tableStructure
                            .append("\n  \"").append(columnName).append("\" ")
                            .append(dataTypeName)
                            .append(columns.getString("IS_NULLABLE").startsWith("N")? " NOT NULL" : "")  // add "NOT NULL" statement if necessary
                            .append(",");
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

                    // handle delete rule
                    tableStructure.append(" ON DELETE ");
                    switch (foreignKeys.getShort("DELETE_RULE")) {
                        case 0:
                            tableStructure.append("CASCADE");
                            break;
                        case 1:
                            tableStructure.append("RESTRICT");
                            break;
                        case 2:
                            tableStructure.append("SET NULL");
                            break;
                        case 3:
                            tableStructure.append("NO ACTION");
                            break;
                        case 4:
                            tableStructure.append("SET DEFAULT");
                    }

                    // handle update rule
                    tableStructure.append(" ON UPDATE ");
                    switch (foreignKeys.getShort("UPDATE_RULE")) {
                        case 0:
                            tableStructure.append("CASCADE");
                            break;
                        case 1:
                            tableStructure.append("RESTRICT");
                            break;
                        case 2:
                            tableStructure.append("SET NULL");
                            break;
                        case 3:
                            tableStructure.append("NO ACTION");
                            break;
                        case 4:
                            tableStructure.append("SET DEFAULT");
                    }
                }

                tableStructure.append("\n);\n");

                /*
                 Print current result on the console, write it in the backup file, and execute the statements
                 */
                System.out.print(tableStructure);
                file.write(tableStructure.toString().getBytes());
                targetDbCon.createStatement().executeUpdate(tableStructure.toString());

                /*
                 Read records and generate statements
                 */
                StringBuffer records = new StringBuffer(
                        "\n" +
                        "-- ----------------------------\n" +
                        "-- Records of " + tableName + "\n" +
                        "-- ----------------------------\n"
                );

                Statement stmt = sourceDbCon.createStatement();
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

                        // handle values of BLOB or TEXT type
                        //
                        // The getBlob() method is not implemented by the given SQLite JDBC driver,
                        // hence blob is handled as bytes here.
                        if (dataTypeNameArrayList.get(i).contains("BLOB") || dataTypeNameArrayList.get(i).contains("TEXT")) {

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
                 Print generated statements of the records on the console, write them in the backup file, and execute them
                 */
                System.out.print(records);
                file.write(records.toString().getBytes());
                targetDbCon.createStatement().executeUpdate(records.toString());
            }

            /*
             Read indexes structures of the database and generate SQL statements
             */
            // tables.first(); throws java.sql.SQLException: ResultSet is TYPE_FORWARD_ONLY
            tables = metaData.getTables(null, null, null, new String[]{"TABLE"});
            while (tables.next()) {
                String tableName = tables.getString("TABLE_NAME");
                ResultSet indexInfo = metaData.getIndexInfo(null, null, tableName, false, true);

                /*
                 Generate statements only when indexes exist
                 */
                StringBuffer indexesStructure = new StringBuffer(
                        "\n" +
                        "-- ----------------------------\n" +
                        "-- Indexes structure for table " + tableName + "\n" +
                        "-- ----------------------------\n"
                );

                String preIndexName = "";
                while (indexInfo.next()) {
                    String indexName = indexInfo.getString("INDEX_NAME");

                    // ignore invisible indexes
                    if (indexName.contains("sqlite_autoindex")) continue;

                    if (preIndexName.equals("")) {
                        indexesStructure.append("CREATE ");

                        if (!indexInfo.getBoolean("NON_UNIQUE"))
                            indexesStructure.append("UNIQUE ");

                        indexesStructure
                                .append("INDEX \"").append(indexInfo.getString("INDEX_NAME")).append("\"\n")
                                .append("ON \"").append(tableName).append("\" (\n")
                                .append("  \"").append(indexInfo.getString("COLUMN_NAME")).append("\"");
                    }
                    else if (indexName.equals(preIndexName)) {
                        indexesStructure.append(",\n  \"").append(indexInfo.getString("COLUMN_NAME")).append("\"");
                    }
                    else {
                        indexesStructure.append("\n);\nCREATE ");

                        if (!indexInfo.getBoolean("NON_UNIQUE"))
                            indexesStructure.append("UNIQUE ");

                        indexesStructure
                                .append("INDEX \"").append(indexInfo.getString("INDEX_NAME")).append("\"\n")
                                .append("ON \"").append(tableName).append("\" (\n")
                                .append("  \"").append(indexInfo.getString("COLUMN_NAME")).append("\"");
                    }

                    if (indexInfo.getString("ASC_OR_DESC") != null)
                        indexesStructure.append(indexInfo.getString("ASC_OR_DESC").equals("A")? " ASC" : " DESC");

                    preIndexName = indexName;
                }
                indexesStructure.append("\n);\n");

                /*
                 Print generated statements of indexes structures on the console, write them in the backup file, and execute them
                 */
                if (indexesStructure.charAt(indexesStructure.length()-6) != '-') {  // judge whether there are indexes exist
                    System.out.print(indexesStructure);
                    file.write(indexesStructure.toString().getBytes());
                    targetDbCon.createStatement().executeUpdate(indexesStructure.toString());
                }
            }

            /*
             Recover foreign key constraints
             */
            foreignKeyConstraints = new StringBuffer("\nPRAGMA foreign_keys = true;\n");
            System.out.print(foreignKeyConstraints);
            file.write(foreignKeyConstraints.toString().getBytes());
            targetDbCon.createStatement().executeUpdate(foreignKeyConstraints.toString());

            /*
             Close the output stream of the backup file and the connection to the databases before exiting the program
             */
            file.close();
            sourceDb.close();
            targetDb.close();

        } catch (SQLException | IOException exception) {
            /*
             Print message when an exception occurs, and close the connection to the database
             */
            DbBasic.notify(exception.getMessage(), exception);
            sourceDb.close();
            targetDb.close();
        }
    }

    private boolean isTypeContained(String [] typeList, String type) {
        for (String type_in_list : typeList) {
            if (type.contains(type_in_list)) return true;
        }
        return false;
    }
}
