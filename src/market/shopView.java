package market;

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
import model.ProductDAO;
import model.ProductDTO;
import util.FileUtil;

public class shopView extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
	
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		
		String num = req.getParameter("num");
		
		ProductDAO dao = new ProductDAO();
		ProductDTO dto = dao.selectView(num);
		req.setAttribute("DTO", dto);
		
		req.getRequestDispatcher("market_view.jsp").forward(req, resp);

	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
