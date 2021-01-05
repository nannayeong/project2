package board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BbsDAO;
import model.BbsDTO;
import model.MemberDAO;

public class boardView extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		BbsDAO bbsDAO = new BbsDAO();
		MemberDAO memberDAO = new MemberDAO();
		
		String num = req.getParameter("num");
		String boardName = req.getParameter("boardName");
		String nowPage = req.getParameter("nowPage");
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		
		if(boardName.equals("free")||boardName.equals("guardian")||boardName.equals("info")||boardName.equals("photo")||boardName.equals("notice")) {
			/*로그인*/
			if(session.getAttribute("USER_GRADE")!=null) {
				BbsDTO bbsDTO = bbsDAO.selectView(num);
				bbsDAO.updateVisitCount(num);
				
				String paramStr = "boardName="+boardName;
				if(searchWord!=null) {
					paramStr += "&searchColumn="+searchColumn+"&searchWord="+searchWord;
				}
				if(nowPage!=null) {
					paramStr += "&nowPage="+nowPage;
				}
				
				bbsDAO.close();
				req.setAttribute("BBSDTO", bbsDTO);
				req.setAttribute("PARAMSTR", paramStr);
				
				if(boardName.equals("notice")) {
					req.getRequestDispatcher("../space/sub01_view.jsp").forward(req, resp);
				}
				else if(boardName.equals("free")) {
					req.getRequestDispatcher("../space/sub03_view.jsp").forward(req, resp);
				}
				else if(boardName.equals("info")) {
					req.getRequestDispatcher("../space/sub05_view.jsp").forward(req, resp);
				}
				else if(boardName.equals("photo")) {
					req.getRequestDispatcher("../space/sub04_view.jsp").forward(req, resp);
				}
				else if(boardName.equals("guardian")) {
					req.getRequestDispatcher("../community/sub02_view.jsp").forward(req, resp);
				}
			}
			else {
				out.print("<script>alert('회원만 열람 가능합니다.'); "
						+ "location.href='../member/login.jsp';</script>");
			}
		}
		else if(boardName.equals("staff")) {
			/*관리자로그인*/
			try {
				if(session.getAttribute("USER_GRADE").equals("manager")) {
					BbsDTO bbsDTO = bbsDAO.selectView(num);
					bbsDAO.updateVisitCount(num);
					
					String paramStr = "boardName="+boardName;
					if(searchWord!=null) {
						paramStr += "&searchColumn="+searchColumn+"&searchWord="+searchWord;
					}
					if(nowPage!=null) {
						paramStr += "&nowPage="+nowPage;
					}
					
					bbsDAO.close();
					req.setAttribute("BBSDTO", bbsDTO);
					req.setAttribute("PARAMSTR", paramStr);
					
					req.getRequestDispatcher("../community/sub01_view.jsp").forward(req, resp);
				}
			}
			catch(NullPointerException e) {
				out.print("<script>alert('관리자만 열람 가능합니다.'); "
						+ "location.href='../board/boardList.do?boardName=staff';</script>");
			}
		}
		else if(boardName.equals("cal")) {
			BbsDTO bbsDTO = bbsDAO.selectView(num);
			bbsDAO.updateVisitCount(num);
			
			String paramStr = "boardName="+boardName;
			if(searchWord!=null) {
				paramStr += "&searchColumn="+searchColumn+"&searchWord="+searchWord;
			}
			if(nowPage!=null) {
				paramStr += "&nowPage="+nowPage;
			}
			
			bbsDAO.close();
			req.setAttribute("BBSDTO", bbsDTO);
			req.setAttribute("PARAMSTR", paramStr);
			
			req.getRequestDispatcher("../space/sub02_view.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
