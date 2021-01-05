package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

public class ProductDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public ProductDAO() {
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
	
	public List<ProductDTO> selectList(){
		List<ProductDTO> dtoList = new Vector<ProductDTO>();
		String sql = "select * from shop_products order by num desc";
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getInt("price"));
				dto.setPoint(rs.getInt("point"));
				dto.setInfo(rs.getString("info"));
				dto.setImg(rs.getString("img"));
				dtoList.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return dtoList;
	}
	
	/*게시물출력*/
	public List<ProductDTO> selectListParam(Map<String, Object> map) {
		List<ProductDTO> dtoList = new Vector<ProductDTO>();
		String sql = "SELECT * FROM shop_products ";
	
		if(map.get("searchWord")!=null) {//검색어 있을 때
			sql += "and "+map.get("searchColumn")+" like '%"+map.get("searchWord")+"%' ";
		}
		
		sql += " order by num desc LIMIT ?, 10";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, (Integer)map.get("start"));
			rs = psmt.executeQuery();
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getInt("price"));
				dto.setPoint(rs.getInt("point"));
				dto.setInfo(rs.getString("info"));
				dto.setImg(rs.getString("img"));
				dtoList.add(dto);

				
				dtoList.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("select실패");
			e.printStackTrace();
		}
		return dtoList;
	}
	public ProductDTO selectView(String num){
		ProductDTO dto = new ProductDTO();
		String sql = "select * from shop_products where num="+num;
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getInt("price"));
				dto.setPoint(rs.getInt("point"));
				dto.setInfo(rs.getString("info"));
				dto.setImg(rs.getString("img"));
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return dto;
	}
	
	public List<BasketDTO> selectView2(String num){
		List<BasketDTO> dtoList = new Vector<BasketDTO>();
		String sql = "select * from shop_products where num="+num;
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()) {
				BasketDTO dto = new BasketDTO();
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getInt("price"));
				dto.setPoint(rs.getInt("point"));
				dto.setImg(rs.getString("img"));
				dtoList.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		return dtoList;
	}
	
	public int insert(ProductDTO dto) {
		int result = 0;
		String sql = "insert into shop_products(name, price, point, info, img) values(?,?,?,?,?)";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getName());
			psmt.setInt(2, dto.getPrice());
			psmt.setInt(3, dto.getPoint());
			psmt.setString(4, dto.getInfo());
			psmt.setString(5, dto.getImg());
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
