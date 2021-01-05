package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

public class RequestDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public RequestDAO() {
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
	
	public int submitReq(RequestDTO rDTO) {
		int result = 0;
		String sql = "insert into request_form(name, address, phone1, phone2, "
				+ "req1, req2, reqD, reqK, memo, email, reqName, disorder, aid) "
				+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, rDTO.getName());
			psmt.setString(2, rDTO.getAddress());
			psmt.setString(3, rDTO.getPhone1());
			psmt.setString(4, rDTO.getPhone2());
			psmt.setString(5, rDTO.getReq1());
			psmt.setString(6, rDTO.getReq2());
			psmt.setString(7, rDTO.getReqD());
			psmt.setString(8, rDTO.getReqK());
			psmt.setString(9, rDTO.getMemo());
			psmt.setString(10, rDTO.getEmail());
			psmt.setString(11, rDTO.getReqName());
			psmt.setString(12, rDTO.getDisorder());
			psmt.setString(13, rDTO.getAid());
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public List<RequestDTO> selectRequest(String reqName) {
		List<RequestDTO> dtoList = new Vector<RequestDTO>();
		String sql = "select * "
				+ "from request_form where reqName=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, reqName);
			rs = psmt.executeQuery();
			while(rs.next()) {
				RequestDTO rDTO = new RequestDTO();
				rDTO.setName(rs.getString("name"));
				rDTO.setAddress(rs.getString("address"));
				rDTO.setPhone1(rs.getString("phone1"));
				rDTO.setPhone2(rs.getString("phone2"));
				rDTO.setReq1(rs.getString("req1"));
				rDTO.setReq2(rs.getString("req2"));
				rDTO.setReqD(rs.getString("reqd"));
				rDTO.setReqK(rs.getString("reqk"));
				rDTO.setMemo(rs.getString("memo"));
				rDTO.setReqName(rs.getString("reqname"));
				rDTO.setAid(rs.getString("aid"));
				rDTO.setDisorder(rs.getString("disorder"));
				rDTO.setNum(rs.getString("num"));
				dtoList.add(rDTO);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return dtoList;
		
	}
	
	public RequestDTO selectView(String num) {
		RequestDTO rDTO = new RequestDTO();
		String sql = "select * "
				+ "from request_form where num=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			while(rs.next()) {
				rDTO.setName(rs.getString("name"));
				rDTO.setAddress(rs.getString("address"));
				rDTO.setPhone1(rs.getString("phone1"));
				rDTO.setPhone2(rs.getString("phone2"));
				rDTO.setReq1(rs.getString("req1"));
				rDTO.setReq2(rs.getString("req2"));
				rDTO.setReqD(rs.getString("reqd"));
				rDTO.setReqK(rs.getString("reqk"));
				rDTO.setMemo(rs.getString("memo"));
				rDTO.setEmail(rs.getString("email"));
				rDTO.setReqName(rs.getString("reqname"));
				rDTO.setAid(rs.getString("aid"));
				rDTO.setDisorder(rs.getString("disorder"));
				rDTO.setNum(rs.getString("num"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return rDTO;
		
	}
}
