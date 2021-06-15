import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;

public class DbBasic {
	/**
	 * Set to true to enable debug messages
	 */
	boolean	debug	= false;

	/**
	 * Name of database driver
	 *
	 * @see Class#forName( )
	 */
	private static final String JDBC_DRIVER		= "org.sqlite.JDBC";

	/**
	 * URI prefix for database location
	 *
	 * @see DriverManager#getConnection( )
	 */
	private static final String DATABASE_LOCATION	= "jdbc:sqlite:";

	/**
	 * {@link Connection} for the database
	 *
	 * @see #getConnection( )
	 */
	protected Connection	con	= null;

	/**
	 * Filesystem path to database
	 *
	 * @see #DbBasic(String)
	 */
	public    String	dbName	= null;

	/**
	 * Outputs a stacktrace for debugging and exits
	 * <p>
	 * To be called following an {@link Exception}
	 *
	 * @param message	informational String to display
	 * @param e		the Exception
	 */
	public static void notify( String message, Exception e ) {
		System.out.println( message + " : " + e );
		e.printStackTrace ( );
		System.exit( 0 );
	}

	/**
	 * Establish JDBC connection with database
	 * <p>
	 * Autocommit is turned off delaying updates
	 * until commit( ) is called
	 */
	private void getConnection( ) {
		try {
			con = DriverManager.getConnection(
					  DATABASE_LOCATION
					+ dbName);

			/*
			 * Turn off AutoCommit:
			 * delay updates until commit( ) called
			 */
			con.setAutoCommit(false);
		}
		catch ( SQLException sqle ) {
			notify( "Db.getConnection database location ["
					+ DATABASE_LOCATION
					+ "] db name["
					+ dbName
					+ "]", sqle);
			close( );
		}
	}

	/**
	 * Opens database
	 * <p>
	 * Confirms database file exists and if so,
	 * loads JDBC driver and establishes JDBC connection to database
	 */
	private void open( ) {
		File dbf = new File( dbName );

		if ( dbf.exists( ) == false ) {
			System.out.println(
				 "SQLite database file ["
				+ dbName
				+ "] does not exist");

			System.out.println(
					"Create SQLite database file ["
					+ dbName
					+ "]? (y/n)"
			);

			String in = new Scanner(System.in).next();
			if (in.equalsIgnoreCase("y")) getConnection();
			else System.exit( 0 );
		}

		try {
			Class.forName( JDBC_DRIVER );
			getConnection( );
		}
		catch ( ClassNotFoundException cnfe ) {
			notify( "Db.Open", cnfe );
		}

		if ( debug )
			System.out.println( "Db.Open : leaving" );
	}

	/**
	 * Close database
	 * <p>
	 * Commits any remaining updates to database and
	 * closes connection
	 */
	public final void close( ) {
		try {
			con.commit( ); // Commit any updates
			con.close ( );
		}
		catch ( Exception e ) {
			notify( "Db.close", e );
		};
	}

	/**
	 * Constructor
	 * <p>
	 * Records a copy of the database name and
	 * opens the database for use
	 *
	 * @param _dbName	String holding the name of the database,
	 * 			for example, C:/directory/subdir/mydb.db
	 */
	public DbBasic(String _dbName ) {
		dbName = _dbName;

		if ( debug )
			System.out.println(
				  "Db.constructor ["
				+ dbName
				+ "]");

		open( );
	}
}
