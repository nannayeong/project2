package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class OrderingDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public OrderingDAO() {
		String mDriver = "org.mariadb.jdbc.Driver";
		String mUrl = "jdbc:mariadb://127.0.0.1:3306/suamil_db";
		String mId = "suamil_user";
		String mPw = "1234";
		
		try {
			Class.forName(mDriver);
			con = DriverManager.getConnection(mUrl,mId,mPw);
			System.out.println("mariaDB연결성공");
		}
		catch(Exception e) {
			System.out.println("DB연결실패");
			e.printStackTrace();
		}
	}
	
	public int insert(OrderingDTO dto) {
		int result = 0;
		String sql = "insert into shop_ordering(id, num, quantity, total, oname, oaddress, ophone, oemail,"
				+" sphone, sname, saddress, semail, pay) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getNum());
			psmt.setInt(3, dto.getQuantity());
			psmt.setInt(4, dto.getTotal());
			psmt.setString(5, dto.getOname());
			psmt.setString(6, dto.getOaddress());
			psmt.setString(7, dto.getOphone());
			psmt.setString(8, dto.getOemail());
			psmt.setString(9, dto.getSphone());
			psmt.setString(10, dto.getSname());
			psmt.setString(11, dto.getSaddress());
			psmt.setString(12, dto.getSemail());
			psmt.setString(13, dto.getPay());
			result=psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return result;
	}
}
