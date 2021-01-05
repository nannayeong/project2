package board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import model.BbsDAO;
import model.BbsDTO;
import util.FileUtil;

public class boardEdit extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		BbsDAO bbsDAO = new BbsDAO();
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		
		String num = req.getParameter("num");
		
		BbsDTO bbsDTO = bbsDAO.selectView(num);
		/*로그인*/
		if(session.getAttribute("USER_ID").equals(bbsDTO.getId())) {
			String boardName = req.getParameter("boardName");
			String boardType = bbsDAO.selectBoardList(boardName);
			req.setAttribute("BOARD_NAME",boardName);
			req.setAttribute("BOARD_TYPE", boardType);
			req.setAttribute("BBSDTO", bbsDTO);
			
			if(boardName.equals("free")) {
				req.getRequestDispatcher("../space/sub03_edit.jsp").forward(req, resp);
			}
			else if(boardName.equals("info")){
				req.getRequestDispatcher("../space/sub05_edit.jsp").forward(req, resp);
			}
			else if(boardName.equals("photo")) {
				req.getRequestDispatcher("../space/sub04_edit.jsp").forward(req, resp);
			}
			else if(boardName.equals("guardian")) {
				req.getRequestDispatcher("../community/sub02_edit.jsp").forward(req, resp);
			}
			else {
				out.print("<script>alert('작성하실 수 없습니다.'); "
						+ "location.href='../main/main.do';</script>");
			}
		}
		else {
			out.print("<script>alert('회원만 작성할 수 있습니다.'); "
					+ "location.href='../member/login.jsp';</script>");
		}
	}
	@Override
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
			String boardName = mr.getParameter("boardName");
			
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
				out.print("<script>alert('수정되었습니다.'); location.href='boardView.do?num="+num+"&boardName="+boardName+"';</script>");
			}
			else if(result==1){
				out.print("<script>alert('수정되었습니다.'); location.href='boardView.do?num="+num+"&boardName="+boardName+"';</script>");
			}
			else {
				out.print("<script>alert('수정실패'); location.href='boardView.do?num="+num+"&boardName="+boardName+"';</script>");
			}
			bbsDAO.close();
		}
	}
}
