package jdbc;

import java.sql.*;

import data.MOS;

public class SInfo {// ·ç¾°ÐÅÏ¢
	static Statement stmt;

	public static void main(String args[]) throws SQLException {
		MysqlJdbc b = new MysqlJdbc();
		stmt = b.createStatement();
		MOS get = new MOS();
		String name = get.getName();
		SInfo a = new SInfo();
		ResultSet r1s = a.c(stmt, name);
		get.setPath(r1s.getString("path"));
		get.setPrice(r1s.getString("Price"));
		get.setStation(r1s.getString("station"));
		get.setTime(r1s.getString("Time"));
		get.setMemo(r1s.getString("intro"));
	}

	public ResultSet c(Statement stmt, String name) throws SQLException {
		ResultSet rs=null;
		try {
			 rs = stmt.executeQuery("select * from sc where name =" + name);
		} catch (Exception e) {
			System.out.print("get data error!");
			e.printStackTrace();
		}finally {
			if(rs!=null){
				rs.close();
			}
		}
		return rs;

	}

}
