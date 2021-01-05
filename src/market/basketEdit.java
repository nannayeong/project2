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
import model.BbsDAO;
import model.BbsDTO;
import model.ProductDAO;
import model.ProductDTO;
import util.PagingUtil;

public class basketEdit extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		
		ProductDAO pdao = new ProductDAO();
		BasketDAO dao = new BasketDAO();
		
		String num = req.getParameter("num");
		String idx = req.getParameter("idx");
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		String param = req.getParameter("param");
		
		int total = pdao.selectView(num).getPrice()*quantity;
		

		if(param.equals("all")) {
			int result = dao.updateQuan(idx , quantity, total);
			if(result==1) {
				out.print("<script>alert('수정되었습니다.');location.href = document.referrer</script>");
			}
			else {
				out.print("<script>alert('수정실패');location.href = document.referrer</script>");
			}
		}
		else if(param.equals("one")) {
			resp.sendRedirect("basket02List.do?num="+num+"&quantity="+quantity+"&param=one");
//			out.print("<script>alert('수정되었습니다.'); location.href='basket02List.do?num="+num+"&quantity="+quantity+"&param=one'");
		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
