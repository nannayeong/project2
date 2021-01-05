package market;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BasketDTO;
import model.OrderingDAO;
import model.OrderingDTO;

public class basket02Insert extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		OrderingDAO dao = new OrderingDAO();
		
		if(session.getAttribute("USER_GRADE")!=null) {
			String id = "";
			String num ="";
			int quantity = 0;
			int total = 0;
			String oname = req.getParameter("oname");
			String oaddress = req.getParameter("oaddress1")+"/"+req.getParameter("oaddress2")+"/"+req.getParameter("oaddress3");
			String ophone = req.getParameter("ophone1")+"-"+req.getParameter("ophone2")+"-"+req.getParameter("ophone3");
			String oemail = req.getParameter("oemail1")+"@"+req.getParameter("oemail2");
			String sname = req.getParameter("sname");
			String saddress = req.getParameter("saddress1")+"/"+req.getParameter("saddress2")+"/"+req.getParameter("saddress3");
			String sphone = req.getParameter("sphone1")+"-"+req.getParameter("sphone2")+"-"+req.getParameter("sphone3");
			String semail = req.getParameter("semail1")+"@"+req.getParameter("semail2");
			String pay = req.getParameter("pay");
			String eq = req.getParameter("eq");
			int result = 0;
			
			if(eq.equals("Y")) {
				sname = oname;
				saddress = oaddress;
				sphone = ophone;
				semail = oemail;
			}
			
			List<BasketDTO> dto = (List)session.getAttribute("orderP");
			for(BasketDTO a : dto) {
				id = session.getAttribute("USER_ID").toString();
				num = a.getNum();
				quantity = a.getQuantity();
				total = a.getTotal();
				
				OrderingDTO odto = new OrderingDTO();
				odto.setId(id);
				odto.setNum(num);
				odto.setOname(oname);
				odto.setOphone(ophone);
				odto.setOaddress(oaddress);
				odto.setOemail(oemail);
				odto.setSname(sname);
				odto.setSemail(semail);
				odto.setSaddress(saddress);
				odto.setSphone(sphone);
				odto.setPay(pay);
				odto.setQuantity(quantity);
				odto.setTotal(total);
				
				result = dao.insert(odto);
			}
			
			if(result==1) {
				resp.sendRedirect("./shopList.do");

			}
			else {
				resp.sendRedirect("./shopList.do");
			}
		}
	}
}
