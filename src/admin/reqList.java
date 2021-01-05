package admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.RequestDAO;
import model.RequestDTO;

public class reqList extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		RequestDAO rDAO = new RequestDAO();
		
		/*로그인 되어있는지 확인*/
		if(session.getAttribute("USER_GRADE")!=null&&session.getAttribute("USER_GRADE").equals("manager")) {
			/*게시물 가져오기*/
			String reqName = req.getParameter("reqName");
			
			if(reqName==null||reqName.equals("")) {
				reqName="blue";
			}
			
			List<RequestDTO> dtoList = rDAO.selectRequest(reqName);
			rDAO.close();
			int count = dtoList.size();
			req.setAttribute("REQDTO_LIST", dtoList);
			req.setAttribute("REQDTO_LIST_COUNT", count);
			req.setAttribute("REQ_NAME", reqName);
			
			req.getRequestDispatcher("reqList.jsp").forward(req, resp);
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
