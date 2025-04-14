package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

	private static Connection conn;
	 public static Connection getConn() throws SQLException, ClassNotFoundException {
	        if (conn == null || conn.isClosed()) {
	            try {	
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/craftisians","root","root");
	            } catch (ClassNotFoundException | SQLException e) {
	            	throw e;
	            }
	        }
	        return conn;
	    }
	}