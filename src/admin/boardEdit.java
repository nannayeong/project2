package admin;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import model.BbsDAO;
import model.BbsDTO;
import util.FileUtil;

public class boardEdit extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
		HttpSession session = req.getSession();
		BbsDAO bbsDAO = new BbsDAO();
		
		/*로그인 되어있는지 확인*/
		if(session.getAttribute("USER_GRADE")!=null&&session.getAttribute("USER_GRADE").equals("manager")) {
			
			/*게시물 있는지 확인하기*/
			String num = req.getParameter("num");
			
			if(num==null||num.equals("")) {
				out.print("<script>alert('잘못된 접근'); location.href='boardList.do'<script>");
			}
			
			int result = bbsDAO.count(num);
			if(result!=1) {
				out.print("<script>alert('해당 게시물이 존재하지 않습니다.'); location.href='boardList.do'<script>");
			}
			
			/*해당 게시물 불러오기*/
			BbsDTO bbsDTO = bbsDAO.selectView(num);
			bbsDAO.close();
			
			req.setAttribute("BBSDTO", bbsDTO);
			
			req.getRequestDispatcher("boardEdit.jsp").forward(req, resp);
		}
		else {
			out.print("<script>alert('관리자만 진입할 수 있습니다.'); "
					+ "location.href='login.jsp';</script>");
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();	
		ServletContext application = this.getServletContext();
		
		/*게시물 업데이트*/
		/*파일 저장경로, 저장최대용량, 인코딩방식, 파일중복처리*/
		MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("/upload"));
		
		if(mr!=null) {
			/*파라미터값*/
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			String num = mr.getParameter("num");
			String originalfile = mr.getParameter("originalfile");
			
			String attachedfile = mr.getFilesystemName("attachedfile");			
			if(attachedfile==null) {
				attachedfile = originalfile;
			}
			
			BbsDTO bbsDTO = new BbsDTO();
			bbsDTO.setTitle(title);
			bbsDTO.setContent(content);
			bbsDTO.setNum(num);
			bbsDTO.setAttachedfile(attachedfile);
			
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.updateList(bbsDTO);
			
			if(result==1 && mr.getFilesystemName("attachedfile")!=null){
				FileUtil.deleteFile(req, "/upload", originalfile);
				out.print("<script>alert('수정되었습니다.'); location.href='boardView.do?num="+num+"';</script>");
			}
			else if(result==1){
				out.print("<script>alert('수정되었습니다.'); location.href='boardView.do?num="+num+"';</script>");
			}
			else {
				out.print("<script>alert('수정실패'); location.href='boardView.do?num="+num+"';</script>");
			}
			bbsDAO.close();
		}
	}
}
