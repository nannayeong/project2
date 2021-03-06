package admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BbsDAO;
import model.BbsDTO;

public class boardDelete extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
		HttpSession session = req.getSession();
		BbsDAO bbsDAO = new BbsDAO();
		
		/*로그인확인*/
		if(session.getAttribute("USER_GRADE")!=null&&session.getAttribute("USER_GRADE").equals("manager")) {
			/*삭제*/
			String num = req.getParameter("num");
			
			if(num==null||num.equals("")) {
				out.print("<script>alert('해당 게시물이 존재하지 않습니다.'); location.href='boardList.do'</script>");
			}
			int result = bbsDAO.delete(num);
			bbsDAO.close();
			
			if(result==1) {
				out.print("<script>alert('정상적으로 삭제되었습니다'); location.href='boardList.do'</script>");
			}
			else {
				out.print("<script>alert('해당 게시물이 존재하지 않습니다.'); location.href='boardList.do'</script>");
			}
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
