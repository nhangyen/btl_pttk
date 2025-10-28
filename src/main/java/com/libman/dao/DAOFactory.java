package com.libman.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAOFactory {
    private static Connection con;

    public static Connection getConnection() {
        if (con == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/btl_pttk?serverTimezone=UTC", "root", "mysql1612");
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
        return con;
    }
}
