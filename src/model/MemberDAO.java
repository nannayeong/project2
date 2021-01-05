package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

public class MemberDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public MemberDAO() {
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
			e.printStackTrace();
		}
	}
	
	public MemberDTO login(String id, String pw) {
		MemberDTO memberDTO = new MemberDTO();
		String sql = "select * from membership where id=? and pw=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pw);
			rs=psmt.executeQuery();
			
			if(rs.next()) {
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPw(rs.getString("pw"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setMembergrade(rs.getString("membergrade"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return memberDTO;
	}
	
	public List<MemberDTO> selectList(String memberGrade){
		List<MemberDTO> dtoList = new Vector<MemberDTO>();
		String sql = "select * from membership where membergrade=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, memberGrade);
			rs=psmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO memberDTO = new MemberDTO();
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPw(rs.getString("pw"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setRegidate(rs.getString("regidate"));
				memberDTO.setMembergrade(rs.getString("membergrade"));
				
				dtoList.add(memberDTO);
			}
		}
		catch(Exception e) {
			System.out.println("selectList실패");
			e.printStackTrace();
		}
		return dtoList;
	}
	
	public int updateGrade(String id, String memberGrade) {
		int result = 0;
		String sql = "update membership set membergrade=? where id=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, memberGrade);
			psmt.setString(2, id);
			result=psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("selectList실패");
			e.printStackTrace();
		}
		return result;
	}
	
	public int join(MemberDTO memberDTO) {
		int result = 0;
		String sql = "insert into membership values(?,?,?,?,?,?,'normal',now())";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, memberDTO.getId());
			psmt.setString(2, memberDTO.getPw());
			psmt.setString(3, memberDTO.getName());
			psmt.setString(4, memberDTO.getPhone());
			psmt.setString(5, memberDTO.getAddress());
			psmt.setString(6, memberDTO.getEmail());
			result=psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("join실패");
			e.printStackTrace();
		}
		return result;
	}
	
	public int joinCheckId(String id) {
		int result = 0;
		String sql = "select count(*) from membership where id=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs=psmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public String selectId(String name, String email) {
		String sql = "select id from membership where name=? and email=?";
		String id = "";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, name);
			psmt.setString(2, email);
			rs= psmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return id;
	}
	
	public String selectPw(String name, String email, String id) {
		String sql = "select pw from membership where name=? and email=? and id=?";
		String pw = "";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, name);
			psmt.setString(2, email);
			psmt.setString(3, id);
			rs= psmt.executeQuery();
			if(rs.next()) {
				pw = rs.getString(1);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return pw;
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
