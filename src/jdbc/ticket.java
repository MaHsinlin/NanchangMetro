package jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ticket {
    public static void main(String[] args) {
        ticket ths = new ticket();
        ths.settic("d", "d", "d", "d");
    }

    public String[][] gettic()  {// 得到所有票的数据

        MysqlJdbc ths = new MysqlJdbc();
        try {
            Statement stmt = ths.createStatement();

            int i = 0;
            ResultSet es = stmt.executeQuery("select * from ticket");
            while (es.next()) {
                i++;
            }
            es.first();
            String[][] info = new String[i][5];
            System.out.println(i);
            i = 0;
            while (es.next()) {

                info[i][0] = es.getString("ID");
                info[i][1] = es.getString("SS");
                info[i][2] = es.getString("ES");
                info[i][3] = es.getString("price");
                info[i][4] = es.getString("time");
                i++;
            }

            es.close();
            stmt.close();
            return info;

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;



    }

    public void settic(String SS, String ES, String price, String time) {
        MysqlJdbc ths = new MysqlJdbc();

        String sql = "INSERT INTO ticket(SS,ES,price,time) VALUES (' " + SS + " ', '" + ES + "', '" + price + "', '"
                + time + "')";

        try {

            Statement stmt = ths.createStatement();
            boolean es = stmt.execute(sql);
            System.out.println(es);
            stmt.close();

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
}
