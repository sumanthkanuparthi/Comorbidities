package comorb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;

public class DBConn {
	//
	// If you want to use you ODBC DSN
	//
	// private static final String URL = "jdbc:odbc:TestDB";

	public DBConn dataObject = null;
	public Connection dbConnection = null;

	public DBConn() {

	}

	// Get one global instance
	public DBConn getInstance() {
		if (dataObject == null)
			dataObject = new DBConn();
		return dataObject;
	}

	public Connection getConnection() throws IOException,
			ClassNotFoundException, SQLException {

		// Check if the database connection is null or not
		if (dbConnection != null)
			return dbConnection;

		String USERNAME = "iramak";
		String PASSWORD = "iramak";
		String DRIVER = "sun.jdbc.odbc.JdbcOdbcDriver";
		String URL = "jdbc:odbc:CernerC159";
		System.out.println(URL);

		// Connection connection = null;
		try {

			Class.forName(DRIVER);
			System.out.println("Before DBCONN");
			dbConnection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			System.out.println("After DBCONN");
			System.out.println(dbConnection);

		}

		catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e);
		}

		return dbConnection;
	}

	public static void closeConnection(Connection conn) {
		try {
			// Check of connection is null or not
			if (conn != null) {
				// If connection is not null, then commit the changes and cloase
				// the connection
				conn.commit();
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	} // end closeConnection

}
