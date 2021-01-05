package admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.MemberDAO;

public class memberEdit extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = resp.getWriter();
		HttpSession session = req.getSession();
		MemberDAO memberDAO = new MemberDAO();
		
		/*로그인 되어있는지 확인*/
		if(session.getAttribute("USER_GRADE")!=null&&session.getAttribute("USER_GRADE").equals("manager")) {
			
			/*권한수정*/
			String memberGrade = req.getParameter("memberGrade");
			String id = req.getParameter("id");
			
			int result = memberDAO.updateGrade(id, memberGrade);
			if(result==1) {
				//out.print("<script>alert('수정되었습니다.'); location.href='memberList.do';<script>"); ->왜 안될까?
				resp.sendRedirect("memberList.do");
			}
			else {
				resp.sendRedirect("memberList.do");
				//out.print("<script>alert('해당 회원이 존재하지 않습니다.'); location.href='memberList.do';<script>");
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
