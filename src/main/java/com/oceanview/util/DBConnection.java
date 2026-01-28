package com.oceanview.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static DBConnection instance;
    // Singleton connection; use HikariCP for production pooling.
    private Connection connection;
    
    private final String URL = "jdbc:mysql://localhost:3306/ocean_view_resort_db";
    private final String USER = "root";
    private final String PASSWORD = "1H8U@g$&%Y#dg.22As,";

    private DBConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found!");
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return connection;
    }

    // Singleton pattern ensures only one connection instance exists
    public static DBConnection getInstance() throws SQLException {
        if (instance == null) {
            instance = new DBConnection();
        } else if (instance.getConnection().isClosed()) {
            instance = new DBConnection();
        }
        return instance;
    }
}
