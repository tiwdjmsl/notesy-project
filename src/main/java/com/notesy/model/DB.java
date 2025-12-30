package com.notesy.model;

import java.sql.*;

public class DB {

    private static final String URL =
            "jdbc:mysql://localhost:3306/notesydb?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "root";
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
