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

import model.BbsDAO;
import model.BbsDTO;
import model.ProductDAO;
import model.ProductDTO;
import util.PagingUtil;

public class shopList extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		ProductDAO dao = new ProductDAO();
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		Map<String, Object> param = new HashMap<String, Object>();
				
		//페이지처리
		int pageSize = 5;//한페이지 게시물 10개
		int blockSize = 5;//한 블럭당 페이지번호 5개
		int nowPage = (req.getParameter("nowPage")==null||req.getParameter("nowPage").equals(""))
			?1:Integer.parseInt(req.getParameter("nowPage"));//현재페이지, 파라미터값이 없는 경우 무조건 1페이지
		int start = (nowPage-1) * pageSize;//BbsDAO에서 select할 게시물수 범위
		param.put("start", start);
		
		//게시물 리스트
		List<ProductDTO> dtoList = dao.selectListParam(param);
		
		String paramStr = "nowPage="+nowPage;
		String pagingStr = PagingUtil.pagingBS4(dtoList.size(), pageSize, 
					blockSize, nowPage, "../market/shopList.do?"+paramStr);//하단 페이지번호부분 전체코드
		
		req.setAttribute("DTO_LIST", dtoList);
		req.setAttribute("DTO_LIST_COUNT", dtoList.size());
		req.setAttribute("PAGING", pagingStr);
		req.setAttribute("PARAM", param);
		req.setAttribute("PARAMSTR", paramStr);
		
		dao.close();

		req.getRequestDispatcher("../market/sub01.jsp").forward(req, resp);

	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
