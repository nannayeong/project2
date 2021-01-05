package admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BbsDAO;
import model.MemberDAO;
import model.MemberDTO;

public class login extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		
		/*브라우저에서 쿠키 받아오기*/
		if(req.getCookies()!=null) {
			Cookie[] cookies = req.getCookies();
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("COOKIE_ID")) {
					session.setAttribute("COOKIE_ID", cookie.getValue());
				}
			}
		}
		
		/*로그아웃*/
		if(req.getParameter("logout")!=null&&req.getParameter("logout").equals("Y")) {
			session.invalidate();
		}
		
		req.getRequestDispatcher("login.jsp").forward(req, resp);	
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");

		/*쿠키 설정하기*/
		String cookieId = req.getParameter("cookieId");
		
		if(cookieId!=null&&cookieId.equals("Y")) {
			Cookie cookie = new Cookie("COOKIE_ID", cookieId);
			cookie.setMaxAge(365*24*60*60);
			cookie.setPath("/"); 
			resp.addCookie(cookie);
		}
		
		/*로그인*/
		MemberDAO memberDAO = new MemberDAO();
		MemberDTO memberDTO = memberDAO.login(id, pw);
		
		if(memberDTO.getMembergrade()!=null&&memberDTO.getMembergrade().equals("manager")) {
			session.setAttribute("USER_ID", memberDTO.getId());
			session.setAttribute("USER_NAME", memberDTO.getName());
			session.setAttribute("USER_GRADE", memberDTO.getMembergrade());
			
			resp.sendRedirect("main.do");
		}
		else {
			out.print("<script>alert('해당하는 관리자 계정이 없습니다.'); "
					+ "location.href='login.jsp';</script>");
		}
	}
}
