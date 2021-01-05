package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

public class BbsDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public BbsDAO() {
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
	
	public List<BbsDTO> selectListMain(String board){
		List<BbsDTO> dtoList = new Vector<BbsDTO>();
		String sql = "select num, title, postdate,attachedfile from multiboard where boardname=?"
				+ "order by num desc limit 0,4";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, board);
			rs = psmt.executeQuery();
			while(rs.next()) {
				BbsDTO dto = new BbsDTO();
				dto.setNum(rs.getString("num"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setTitle(rs.getString("title"));
				dto.setAttachedfile(rs.getString("attachedfile"));
				
				dtoList.add(dto);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return dtoList;
	}
	
	/*파라미터 boardName 받아와서 게시판에 맞는 게시물 select*/
	public List<BbsDTO> selectList(String boardName){
		List<BbsDTO> dtoList = new Vector<BbsDTO>();
		String sql = "SELECT * from multiboard WHERE boardname=?;";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, boardName);
			rs = psmt.executeQuery();
			while(rs.next()) {
				BbsDTO bbsDTO = new BbsDTO();
				bbsDTO.setNum(rs.getString("num"));
				bbsDTO.setTitle(rs.getString("title"));
				bbsDTO.setContent(rs.getString("content"));
				bbsDTO.setPostdate(rs.getDate("postdate"));
				bbsDTO.setId(rs.getString("id"));
				bbsDTO.setVisitcount(rs.getString("visitcount"));
				bbsDTO.setBoardname(rs.getString("boardname"));
				bbsDTO.setAttachedfile(rs.getString("attachedfile"));
				bbsDTO.setDate(rs.getString("date"));
				
				System.out.println("Date"+rs.getDate("date"));

				dtoList.add(bbsDTO);
			}
		}
		catch(Exception e) {
			System.out.println("selectList실패");
			System.out.println(e);
		}
		
		return dtoList;
	}
	
	/*게시물출력*/
	public List<BbsDTO> selectListParam(Map<String, Object> map) {
		List<BbsDTO> dtoList = new Vector<BbsDTO>();
		String sql = "SELECT num, title, visitcount, content, postdate, attachedfile, b.id, m.name, m.email "
				+ "FROM multiboard b INNER JOIN membership m ON b.id=m.id WHERE boardname=? ";
	
		if(map.get("searchWord")!=null) {//검색어 있을 때
			sql += "and "+map.get("searchColumn")+" like '%"+map.get("searchWord")+"%' ";
		}
		
		sql += " order by num desc LIMIT ?, 10";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, map.get("boardName").toString());
			psmt.setInt(2, (Integer)map.get("start"));
			rs = psmt.executeQuery();
			while(rs.next()) {
				BbsDTO dto = new BbsDTO();
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getString("num"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setTitle(rs.getString("title"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setAttachedfile(rs.getString("attachedfile"));
				
				dtoList.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("select실패");
			e.printStackTrace();
		}
		return dtoList;
	}
	
	/*파라미터 num 받아와서 게시판에 맞는 게시물 select*/
	public BbsDTO selectView(String num) {
		BbsDTO bbsDTO = new BbsDTO();
		String sql = "select * from multiboard mb inner join membership m on mb.id=m.id where num=?";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			if(rs.next()) {
				bbsDTO.setNum(rs.getString("num"));
				bbsDTO.setTitle(rs.getString("title"));
				bbsDTO.setContent(rs.getString("content"));
				bbsDTO.setPostdate(rs.getDate("postdate"));
				bbsDTO.setId(rs.getString("id"));
				bbsDTO.setVisitcount(rs.getString("visitcount"));
				bbsDTO.setAttachedfile(rs.getString("attachedfile"));
				bbsDTO.setEmail(rs.getString("email"));
				bbsDTO.setDate(rs.getString("date"));
				bbsDTO.setBoardname(rs.getString("boardName"));
			}
		}
		catch(Exception e) {
			System.out.println("selectView실패");
			System.out.println(e);
		}
		return bbsDTO;
	}
	
	public int delete(String num) {
		String sql = "delete from multiboard where num=?";
		int result = 0;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("delete실패");
			System.out.println(e);
		}
		return result;
	}
	
	public int count(String num) {
		String sql = "select count(*) from multiboard where num=?";
		int result = 0;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
		}
		catch(Exception e) {
			System.out.println("count실패");
			System.out.println(e);
		}
		return result;
	}
	
	public int updateList(BbsDTO bbsDTO) {
		String sql = "update multiboard set title=?, content=?, attachedfile=? where num=? ";
		int result = 0;

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, bbsDTO.getTitle());
			psmt.setString(2, bbsDTO.getContent());
			psmt.setString(3, bbsDTO.getAttachedfile());
			psmt.setString(4, bbsDTO.getNum());
			result = psmt.executeUpdate();
			System.out.println(result);
		}
		catch(Exception e) {
			System.out.println("updateList실패");
			System.out.println(e);
		}
		return result;
	}
	
	public int insertList(BbsDTO bbsDTO) {
		String sql = "insert into multiboard(title, content, id, boardName, attachedFile, date)"
				+ "values (?,?,?,?,?,?);";
		int result = 0;
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, bbsDTO.getTitle());
			psmt.setString(2, bbsDTO.getContent());
			psmt.setString(3, bbsDTO.getId());
			psmt.setString(4,bbsDTO.getBoardname());
			psmt.setString(5, bbsDTO.getAttachedfile());
			psmt.setString(6, bbsDTO.getDate());
			
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("insertList실패");
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
	
	public String selectBoardList(String boardName){
		String sql = "select * from boardlist where boardName=?";
		String boardType = "";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, boardName);
			rs= psmt.executeQuery();
			if(rs.next()) {
				boardType = rs.getString("boardtype");
			}
		}
		catch(Exception e) {
			System.out.println("selectBoardList실패");
			System.out.println(e);
		}
		return boardType;
	}
	
	public void updateVisitCount(String num) {
		String sql = "update multiboard set visitcount=visitcount+1 where num="+num;
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("updatevistcount실패");
			e.printStackTrace();
		}
	}
}
