package board;

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
import util.PagingUtil;

public class boardList extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		BbsDAO bbsDAO = new BbsDAO();
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		Map<String, Object> param = new HashMap<String, Object>();
		
		String boardName = req.getParameter("boardName");
		String paramStr = "boardName="+boardName;
		param.put("boardName",boardName);
		
		//검색어처리
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		if(searchWord!=null){//검색어가 있을때만 map에 파라미터 저장, paramStr에 추가
			param.put("searchColumn", searchColumn);
			param.put("searchWord", searchWord);
			paramStr = "&searchColumn="+searchColumn+"&searchWord="+searchWord;
		}
				
		//페이지처리
		int pageSize = 10;//한페이지 게시물 10개
		if(boardName.equals("photo")) {pageSize = 9;}
		int blockSize = 5;//한 블럭당 페이지번호 5개
		int nowPage = (req.getParameter("nowPage")==null||req.getParameter("nowPage").equals(""))
			?1:Integer.parseInt(req.getParameter("nowPage"));//현재페이지, 파라미터값이 없는 경우 무조건 1페이지
		int start = (nowPage-1) * pageSize;//BbsDAO에서 select할 게시물수 범위
		param.put("start", start);
		
		//게시물 리스트
		List<BbsDTO> bbsDTOList = bbsDAO.selectListParam(param);
		
		paramStr += "&nowPage="+nowPage;
		String pagingStr = PagingUtil.pagingBS4(bbsDTOList.size(), pageSize, 
					blockSize, nowPage, "../board/boardList.do?"+paramStr);//하단 페이지번호부분 전체코드
		
		req.setAttribute("BBSDTO_LIST", bbsDTOList);
		req.setAttribute("BBSDTO_LIST_COUNT", bbsDTOList.size());
		req.setAttribute("PAGING", pagingStr);
		req.setAttribute("PARAM", param);
		req.setAttribute("PARAMSTR", paramStr);
		
		bbsDAO.close();
		
		if(boardName.equals("notice")) {
			req.getRequestDispatcher("../space/sub01_list.jsp").forward(req, resp);
		}
		else if(boardName.equals("free")) {
			req.getRequestDispatcher("../space/sub03_list.jsp").forward(req, resp);
		}
		else if(boardName.equals("info")) {
			req.getRequestDispatcher("../space/sub05_list.jsp").forward(req, resp);
		}
		else if(boardName.equals("photo")) {
			req.getRequestDispatcher("../space/sub04_list.jsp").forward(req, resp);
		}
		else if(boardName.equals("staff")) {
			req.getRequestDispatcher("../community/sub01_list.jsp").forward(req, resp);
		}
		else if(boardName.equals("guardian")) {
			req.getRequestDispatcher("../community/sub02_list.jsp").forward(req, resp);
		}
		else {
			out.print("<script>alert('해당 게시판이 존재하지 않습니다'); location.href='../main/main.do'</script>");
		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}
