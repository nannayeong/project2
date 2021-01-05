package market;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BasketDAO;
import model.BasketDTO;
import model.ProductDAO;
import model.ProductDTO;
import util.PagingUtil;

public class basket02List extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		BasketDAO dao = new BasketDAO();
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		ProductDAO pdao = new ProductDAO();
		ProductDTO pdto = new ProductDTO();
		
		if(session.getAttribute("USER_GRADE")!=null) {
			String id = session.getAttribute("USER_ID").toString();
			String param = req.getParameter("param");
			String num = req.getParameter("num");
			int quantity = 1;
			if(req.getParameter("quantity")!=null) {
			quantity = Integer.parseInt(req.getParameter("quantity"));
			}
			
			if(param.equals("all")) {
				List<BasketDTO> dtoList = dao.selectListId(id);
				
				int sum = 0;
				for(BasketDTO dto : dtoList) {
					sum += dto.getTotal();
				}
				req.setAttribute("DTO_LIST", dtoList);
				req.setAttribute("TOTAL", sum);
				req.setAttribute("PARAM", param);
				req.getRequestDispatcher("../market/basket02.jsp").forward(req, resp);
			}
			else if(param.equals("one")) {
				List<BasketDTO> dtoList = pdao.selectView2(num);
				int sum=0;
				for(BasketDTO a : dtoList) {
					sum = quantity*a.getPrice();
					a.setTotal(quantity*a.getPrice());
					a.setQuantity(quantity);
				}
				req.setAttribute("DTO_LIST", dtoList);
				req.setAttribute("TOTAL", sum);
				req.setAttribute("PARAM", param);
				req.getRequestDispatcher("../market/basket02.jsp").forward(req, resp);
			}
		}			
		else {
			out.print("<script>alert('로그인 후 이용해주세요'); "
					+ "location.href='../member/login.jsp';</script>");
		}
		dao.close();	
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
