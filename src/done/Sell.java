package done;

import java.sql.*;

import data.Price;
import jdbc.MysqlJdbc;

public class Sell {//出售单程票
    int SS;
    int ES;
    int value;
    int num;

    public int getSS() {
        return SS;
    }

    public void setSS(String sS) throws SQLException {
        MysqlJdbc th = new MysqlJdbc();
        Statement st = th.createStatement();
        ResultSet as = st.executeQuery("SELECT id FROM ms where sname ='" + sS + "'");
        while (as.next()) {
            SS = as.getInt("id");
        }
        as.close();
        st.close();
    }

    public int getES() {
        return ES;
    }

    public void setES(String eS) throws SQLException {
        MysqlJdbc th = new MysqlJdbc();
        Statement st = th.createStatement();
        ResultSet es = st.executeQuery("SELECT id FROM ms where sname ='" + eS + "'");
        while (es.next()) {
            ES = es.getInt("id");
        }
        es.close();
        st.close();
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public int getNum() {
        return num;
    }
    public void setNum(int num) {
        this.num = num;
    }
}
