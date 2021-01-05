package admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.MemberDAO;
import model.MemberDTO;

public class memberList extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		MemberDAO memberDAO = new MemberDAO();
		
		/*로그인 되어있는지 확인*/
		if(session.getAttribute("USER_GRADE")!=null&&session.getAttribute("USER_GRADE").equals("manager")) {
			/*게시물 가져오기*/
			String memberGrade = req.getParameter("memberGrade");
			
			if(memberGrade==null||memberGrade.equals("")) {
				memberGrade="manager";
			}
			
			List<MemberDTO> dtoList = memberDAO.selectList(memberGrade);
			memberDAO.close();
			int count = dtoList.size();
			
			req.setAttribute("MEMBERDTO_LIST", dtoList);
			req.setAttribute("MEMBERDTO_LIST_COUNT", count);
			req.setAttribute("MEMBER_GRADE", memberGrade);
			
			req.getRequestDispatcher("memberList.jsp").forward(req, resp);
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
