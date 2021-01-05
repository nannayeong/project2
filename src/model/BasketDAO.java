package model; 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

public class BasketDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public BasketDAO() {
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
	
	public int insert(BasketDTO dto) {
		int result = 0;
		String sql = "insert into shop_basket(num, id, quantity, total) values(?,?,?,?)";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getNum());
			psmt.setString(2, dto.getId());
			psmt.setInt(3, dto.getQuantity());
			psmt.setInt(4, dto.getTotal());
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return result;
	}
	
	public List<BasketDTO> selectListParam(Map<String, Object> param) {
		List<BasketDTO> dtoList = new Vector<BasketDTO>();
		String sql = "select * from shop_basket b inner join shop_products p"
				+ " on b.num=p.num where id=? limit ?,5";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, param.get("id").toString());
			psmt.setInt(2, (Integer)param.get("start"));
			rs = psmt.executeQuery();
			while(rs.next()) {
				BasketDTO dto = new BasketDTO();
				dto.setIdx(rs.getString("idx"));
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getString("num"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setTotal(rs.getInt("total"));
				dto.setImg(rs.getString("img"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getInt("price"));
				dto.setPoint(rs.getInt("point"));
				
				dtoList.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return dtoList;
	}
	
	public List<BasketDTO> selectListId(String id) {
		List<BasketDTO> dtoList = new Vector<BasketDTO>();
		String sql = "select * from shop_basket b inner join shop_products p"
				+ " on b.num=p.num where id=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			while(rs.next()) {
				BasketDTO dto = new BasketDTO();
				dto.setIdx(rs.getString("idx"));
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getString("num"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setTotal(rs.getInt("total"));
				dto.setImg(rs.getString("img"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getInt("price"));
				dto.setPoint(rs.getInt("point"));
				
				dtoList.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return dtoList;
	}
	
	public int updateQuan(String idx, int quantity, int total) {
		String sql = "update shop_basket set quantity="+quantity+",total="+total+
				" where idx="+idx;
		int result = 0;
		try {
			psmt = con.prepareStatement(sql);
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return result;
	}
	
	public void close() {
		try {
			if(con!=null) con.close();
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
		}
		catch(Exception e) {
			System.out.println("close실패");
			System.out.println(e);
		}
	}
}
