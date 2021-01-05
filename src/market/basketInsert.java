package market;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BasketDAO;
import model.BasketDTO;
import model.BbsDAO;
import model.BbsDTO;
import model.ProductDAO;
import model.ProductDTO;
import util.PagingUtil;

public class basketInsert extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		ProductDAO dao = new ProductDAO();
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(session.getAttribute("USER_GRADE")!=null) {
			
			String num = req.getParameter("num");
			int quantity = Integer.parseInt(req.getParameter("quantity"));
			String id = session.getAttribute("USER_ID").toString();
			
			ProductDAO pdao = new ProductDAO();
			ProductDTO pdto = pdao.selectView(num);
			int total = pdto.getPrice()*quantity;
			
			BasketDAO bdao = new BasketDAO();
			BasketDTO bdto = new BasketDTO();
			bdto.setId(id);
			bdto.setNum(num);
			bdto.setQuantity(quantity);
			bdto.setTotal(total);
			int result = bdao.insert(bdto);
			
			if(result!=1) {
				out.print("<script>alert('상품 장바구니 실패'); "
						+ "history.go(-1);</script>");
			}
			else {
				resp.sendRedirect("./basketList.do");
			}
		}
		else {
			out.print("<script>alert('로그인 후 이용해주세요'); "
					+ "location.href='../member/login.jsp';</script>");
		}
		
		 
				
		

	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
