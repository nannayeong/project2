package admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import model.BbsDAO;
import model.BbsDTO;
import model.RequestDAO;
import model.RequestDTO;
import util.FileUtil;

public class reqView extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
	
		/*로그인되어있는지 확인*/
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		RequestDAO rDAO = new RequestDAO();
		
		if(session.getAttribute("USER_GRADE")!=null&&session.getAttribute("USER_GRADE").equals("manager")) {
			String num = req.getParameter("num");
			
			RequestDTO rDTO = rDAO.selectView(num);
			rDAO.close();
			req.setAttribute("rDTO", rDTO);
			
			if(rDTO.getReqName().equals("blue")) {
				req.getRequestDispatcher("reqView_sub03.jsp").forward(req, resp);
			}
			else if(rDTO.getReqName().equals("exper")) {
				req.getRequestDispatcher("reqView_sub05.jsp").forward(req, resp);
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
