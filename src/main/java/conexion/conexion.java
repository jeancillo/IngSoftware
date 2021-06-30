package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class conexion {
<<<<<<< HEAD
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bd_arapa1";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";
    private static final String DB_Driver="com.mysql.cj.jdbc.Driver";
=======

    private static final String DB_URL = "jdbc:mysql://localhost:3307/bd_villa_flash";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    private static final String DB_Driver = "com.mysql.cj.jdbc.Driver";
>>>>>>> upstream/master
    private static Connection cn;

    public static Connection abrir() {

        try {
            Class.forName(DB_Driver);
            cn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Conectado");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("No conectado");
        }
        return cn;
    }

    public static void close(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException ex) {
                ex.printStackTrace(System.out);
            }
        }
    }

    public static void close(PreparedStatement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException ex) {
                ex.printStackTrace(System.out);
            }
        }
    }

    public static void close(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace(System.out);
            }
        }
    }
}
