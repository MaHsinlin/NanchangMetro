package data;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import done.Sell;
import jdbc.MysqlJdbc;

public class Price {// 计算票价

    Sell ticket = new Sell();
    public int ssline(int SS) throws SQLException {//启示车站的线路
        MysqlJdbc ths = new MysqlJdbc();
        Statement stmt = ths.createStatement();
        ResultSet es = stmt.executeQuery("select line from ms where id=" + SS);
        while (es.next()) {
            return es.getInt("line");
        }
        es.close();
        stmt.close();
        return 0;
    }

    public int sslinenum(int SS) throws SQLException {//起始车站的线路编号
        MysqlJdbc ths = new MysqlJdbc();
        Statement stmt = ths.createStatement();
        ResultSet es = stmt.executeQuery("select linenum from ms where id=" + SS);
        while (es.next()) {
            return es.getInt("linenum");
        }
        es.close();
        stmt.close();
        return 0;
    }

    public int cal(int line, int num, int ES) throws SQLException {
        MysqlJdbc ths = new MysqlJdbc();
        Statement stmt = ths.createStatement();
        Statement stt = ths.createStatement();
        Statement st = ths.createStatement();
        int[] a = new int[9];
        int i = 0;
        int esline;
        int eslinenum;
        ResultSet es = stmt.executeQuery("select * from ms where id =" + ES);
        while (es.next()) {
            esline = es.getInt("line");
            eslinenum = es.getInt("linenum");
            System.out.println("起点位于线路"+line);
            System.out.println("终点位于线路"+esline);
            if (line == esline) {
                a[i] = Math.abs(eslinenum - num);
                i++;
                return a[i - 1];
            } else {
                ResultSet as = st.executeQuery("select * from ms where line = " + line + " AND flag like '%" + line + "%'");
                while (as.next()) {
                    ResultSet abs = stt.executeQuery("select * from ms where line = " + es.getInt("line") + " AND flag like '%" + line + "%'  AND id=" + as.getInt("id"));
                    while (abs.next()) {
                        a[i] = Math.abs(as.getInt("linenum") - num) + cal(abs.getInt("line"), abs.getInt("linenum"), ES);
                    }
                    abs.close();
                    i++;
                }
                as.close();
            }
        }
        es.close();
        int z = 99;
        for (int j = 0; j < a.length; j++) {
            if (z > a[j] && a[j] != 0) {
                z = a[j];
            }
        }
        System.out.println("最短站数为"+z);
        return z;
    }

    public int CalP(int a) {// 计算票价
        switch (a) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
                return 2;
            case 6:
            case 7:
            case 8:
            case 9:
                return 3;
            case 10:
            case 11:
            case 12:
            case 13:
                return 4;
            case 14:
            case 15:
            case 16:
            case 17:
                return 5;
            case 18:
            case 19:
            case 20:
            case 21:
                return 6;
            case 22:
            case 23:
            case 24:
            case 25:
                return 7;
            case 26:
            case 27:
            case 28:
            case 29:
                return 8;
            case 30:
            case 31:
            case 32:
            case 33:
                return 9;
            case 34:
            case 35:
            case 36:
            case 37:
                return 10;
            case 38:
            case 39:
            case 40:
            case 41:
                return 11;
            default:
                return 2;
        }
    }
}
