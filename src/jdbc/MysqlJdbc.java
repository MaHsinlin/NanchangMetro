package jdbc;

import java.sql.*;

import data.Price;
import done.Sell;

public class MysqlJdbc {
    static Statement stmt;


    public MysqlJdbc() {
        try {
            Class.forName("com.mysql.jdbc.Driver");     //¼ÓÔØMYSQL JDBCÇý¶¯³ÌÐò

//			     System.out.println("Success loading Mysql Driver!");
        } catch (Exception e) {
            System.out.print("Error loading Mysql Driver!");
//			      e.printStackTrace();
        }


    }


    private static Connection connect;

    public Statement createStatement() throws SQLException {
        if (connect == null) {
            connect = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/metro", "root", "123");
        }
        try {


//        System.out.println("Success connect Mysql server!");
            stmt = connect.createStatement();
            return stmt;

        } catch (Exception e) {
            System.out.print("get data error!");
//        e.printStackTrace();
        }
        return null;
    }

}
