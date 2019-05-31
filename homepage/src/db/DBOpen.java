package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBOpen {
	public static Connection open() {
		Connection con = null;
		
		try {
			Class.forName(Constant.DRIVER);
			con = DriverManager.getConnection(Constant.URL, Constant.USER, Constant.PASSWORD);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
}
