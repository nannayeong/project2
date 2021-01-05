package admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BbsDAO;
import model.BbsDTO;

public class boardList extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		BbsDAO bbsDAO = new BbsDAO();
		
		/*로그인 되어있는지 확인*/
		if(session.getAttribute("USER_GRADE")!=null&&session.getAttribute("USER_GRADE").equals("manager")) {
			/*게시물 가져오기*/
			String boardName = req.getParameter("boardName");
			
			if(boardName==null||boardName.equals("")) {
				boardName="free";
			}
			
			List<BbsDTO> dtoList = bbsDAO.selectList(boardName);
			bbsDAO.close();
			int count = dtoList.size();
			req.setAttribute("BBSDTO_LIST", dtoList);
			req.setAttribute("BBSDTO_LIST_COUNT", count);
			req.setAttribute("BOARD_NAME", boardName);
			
			req.getRequestDispatcher("boardList.jsp").forward(req, resp);
		}
		else {
			out.print("<script>alert('관리자만 진입할 수 있습니다.'); "
					+ "location.href='login.jsp';</script>");
		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
