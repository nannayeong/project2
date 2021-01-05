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

public class basketList extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		BasketDAO dao = new BasketDAO();
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(session.getAttribute("USER_GRADE")!=null) {
			
			String id = session.getAttribute("USER_ID").toString();
			//페이지처리
			int pageSize = 5;//한페이지 게시물 10개
			int blockSize = 5;//한 블럭당 페이지번호 5개
			int nowPage = (req.getParameter("nowPage")==null||req.getParameter("nowPage").equals(""))
				?1:Integer.parseInt(req.getParameter("nowPage"));//현재페이지, 파라미터값이 없는 경우 무조건 1페이지
			int start = (nowPage-1) * pageSize;//BbsDAO에서 select할 게시물수 범위
			param.put("start", start);
			param.put("id", id);
			
			//장바구니 select
			List<BasketDTO> dtoList = dao.selectListParam(param);
			int sum = 0;
			for(BasketDTO dto : dtoList) {
				sum += dto.getTotal();
			}
			
			String paramStr = "nowPage="+nowPage;
			String pagingStr = PagingUtil.pagingBS4(dtoList.size(), pageSize, 
						blockSize, nowPage, "../market/shopList.do?"+paramStr);//하단 페이지번호부분 전체코드
			
			req.setAttribute("DTO_LIST", dtoList);
			req.setAttribute("DTO_LIST_COUNT", dtoList.size());
			req.setAttribute("PAGING", pagingStr);
			req.setAttribute("PARAM", param);
			req.setAttribute("PARAMSTR", paramStr);
			req.setAttribute("TOTAL", sum);
			
			dao.close();

			req.getRequestDispatcher("../market/basket.jsp").forward(req, resp);
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
