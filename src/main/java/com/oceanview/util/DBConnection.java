package com.oceanview.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static DBConnection instance;
    private Connection connection;
    
    // SMART CONFIGURATION: Checks Environment Variables first (for GitHub Actions)
    // If not found, falls back to your local settings.
    private final String URL = System.getenv("DB_URL") != null ? 
                        System.getenv("DB_URL") : "jdbc:mysql://localhost:3306/ocean_view_resort_db";
    
    private final String USER = System.getenv("DB_USER") != null ? 
                         System.getenv("DB_USER") : "root";
    
    private final String PASSWORD = System.getenv("DB_PASSWORD") != null ? 
                             System.getenv("DB_PASSWORD") : "1H8U@g$&%Y#dg.22As,";

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

    public static DBConnection getInstance() throws SQLException {
        if (instance == null) {
            instance = new DBConnection();
        } else if (instance.getConnection().isClosed()) {
            instance = new DBConnection();
        }
        return instance;
    }
}