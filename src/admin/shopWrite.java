package admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
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

public class shopWrite extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		BbsDAO bbsDAO = new BbsDAO();
		
		/*로그인확인*/
		if(session.getAttribute("USER_GRADE")!=null&&session.getAttribute("USER_GRADE").equals("manager")) {
			req.getRequestDispatcher("../admin/shopWrite.jsp").forward(req, resp);;
		}
		else {
			out.print("<script>alert('관리자만 진입할 수 있습니다.'); "
					+ "location.href='login.jsp';</script>");
		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		ServletContext application = this.getServletContext();
		HttpSession session = req.getSession();
		
		SimpleDateFormat fm = new SimpleDateFormat("yy-mm-dd");
		/*게시물 업데이트*/
		/*파일 저장경로, 저장최대용량, 인코딩방식, 파일중복처리*/
		MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("/upload"));
		
		if(mr!=null) {
			/*파라미터값*/
			String name = mr.getParameter("name");
			String info = mr.getParameter("info");
			String img = mr.getFilesystemName("img");			
			int price = Integer.parseInt(mr.getParameter("price"));
			int point = Integer.parseInt(mr.getParameter("point"));
			
			ProductDTO dto = new ProductDTO();
			dto.setName(name);
			dto.setInfo(info);
			dto.setPoint(point);
			dto.setPrice(price);
			dto.setImg(img);
			ProductDAO dao = new ProductDAO();
			
			int result = dao.insert(dto);
			
			if(result==1){
				out.print("<script>alert('글쓰기 완료되었습니다.'); location.href='shopList.do';</script>");
			}
			else {
				out.print("<script>alert('글쓰기 실패'); location.href='shopList.do';</script>");
			}
			dao.close();
		}
	}
	
}
