package market;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.RequestDAO;
import model.RequestDTO;
import smtp.SMTPAuth;

public class reqform extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		
		String reqName = req.getParameter("reqName");
		
		if(reqName.equals("blue")) {
			if(session.getAttribute("USER_ID")!=null) {
				req.getRequestDispatcher("../market/sub03.jsp").forward(req, resp);
			}
			else {
				out.print("<script>alert('로그인 후 이용해주세요'); "
						+ "location.href='../member/login.jsp';</script>");
			}
		}
		else if(reqName.equals("exper")) {
			req.getRequestDispatcher("../market/sub05.jsp").forward(req, resp);
		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		req.setCharacterEncoding("UTF-8"); 
		PrintWriter out = resp.getWriter();
		
		String name = req.getParameter("name");
		String address = req.getParameter("address");
		String phone1 = req.getParameter("phone1")+"-"+req.getParameter("phone2")+"-"+req.getParameter("phone3");
		String phone2 = req.getParameter("phone4")+"-"+req.getParameter("phone5")+"-"+req.getParameter("phone6");
		String email = req.getParameter("email1")+"@"+req.getParameter("email2");
		String req1 = req.getParameter("req1");
		String req2 = req.getParameter("req2");
		String reqD = req.getParameter("reqD");
		String reqK = req.getParameter("reqK");
		String memo = req.getParameter("memo");
		String reqName = req.getParameter("reqName");
		String disorder = req.getParameter("disorder");
		String aid = req.getParameter("aid");
		
		RequestDTO rDTO = new RequestDTO();
		rDTO.setName(name);
		rDTO.setAddress(address);
		rDTO.setPhone1(phone1);
		rDTO.setPhone2(phone2);
		rDTO.setEmail(email);
		rDTO.setReq1(req1);
		rDTO.setReq2(req2);
		rDTO.setReqD(reqD);
		rDTO.setReqK(reqK);
		rDTO.setMemo(memo);
		rDTO.setReqName(reqName);
		rDTO.setDisorder(disorder);
		rDTO.setAid(aid);
		
		RequestDAO rDAO = new RequestDAO();
		int result = rDAO.submitReq(rDTO);
		
		if(result==1) {
			/*이메일*/
			req.setCharacterEncoding("UTF-8");
			//메일발송을 위한 객체생성
			SMTPAuth smtp = new SMTPAuth();
			
			if(reqName.equals("blue")) {
				String mailContents = ""
					+"<table border=1>"
					+"<tr>"
					+"	<td>고객명/회사명</td>"
					+"	<td>"+name+"</td>"
					+"</tr>"
					+"<tr>"
					+"	<td>청소할 곳 주소</td>"
					+"	<td>"+address+"</td>"
					+"</tr>"
					+"<tr>"
					+"	<td>청소의뢰내역</td>"
					+"	<td>"+req1+"/"+req2+"</td>"
					+"</tr>"
					+"<tr>"
					+"	<td>청소희망날짜</td>"
					+"	<td>"+reqD+"</td>"
					+"</tr>"
					+"<tr>"
					+"	<td>접수종류</td>"
					+"	<td>"+reqK+"</td>"
					+"</tr>"
					+"<tr>"
					+"	<td>기타특이사항</td>"
					+"	<td>"+memo+"</td>"
					+"</tr>"
					+"</table>";
				
				//메일을 보내기위한 여러가지 폼값을 Map컬렉션에 저장
				Map<String,String> emailContent = new HashMap<String,String>();
				emailContent.put("from", "nannayeong@gmail.com");
				emailContent.put("to", email);
				emailContent.put("subject", "블루클리닝 의뢰서");
				//emailContent.put("content", request.getParameter("content"));
				emailContent.put("content", mailContents);
	
				boolean emailResult = smtp.emailSending(emailContent);
				if(emailResult==true){
					System.out.println("메일발송성공");
				}
				else{
					System.out.println("메일발송실패");
				}
				
				emailContent.put("from", "nannayeong@gmail.com");
				emailContent.put("to", "nannayeong@gmail.com");
				emailContent.put("subject", "블루클리닝 의뢰서");
				//emailContent.put("content", request.getParameter("content"));
				emailContent.put("content", mailContents);
	
				emailResult = smtp.emailSending(emailContent);
				if(emailResult==true){
					System.out.println("메일발송성공");
				}
				else{
					System.out.println("메일발송실패");
				}
				resp.sendRedirect("./reqform.do?reqName="+reqName);
			}
			else if(reqName.equals("exper")) {
				String mailContents = ""
						+"<table border=1>"
						+"<tr>"
						+"	<td>고객명/회사명</td>"
						+"	<td>"+name+"</td>"
						+"</tr>"
						+"<tr>"
						+"	<td>체험내용</td>"
						+"	<td>"+req1+"/"+req2+"</td>"
						+"</tr>"
						+"<tr>"
						+"	<td>체험희망날짜</td>"
						+"	<td>"+reqD+"</td>"
						+"</tr>"
						+"<tr>"
						+"	<td>접수종류</td>"
						+"	<td>"+reqK+"</td>"
						+"</tr>"
						+"<tr>"
						+"	<td>기타특이사항</td>"
						+"	<td>"+memo+"</td>"
						+"</tr>"
						+"</table>";
					
					//메일을 보내기위한 여러가지 폼값을 Map컬렉션에 저장
					Map<String,String> emailContent = new HashMap<String,String>();
					emailContent.put("from", "nannayeong@naver.com");
					emailContent.put("to", address);
					emailContent.put("subject", "체험학습 의뢰서");
					//emailContent.put("content", request.getParameter("content"));
					emailContent.put("content", mailContents);
		
					boolean emailResult = smtp.emailSending(emailContent);
					if(emailResult==true){
						System.out.println("메일발송성공");
					}
					else{
						System.out.println("메일발송실패");
					}
					
					emailContent.put("from", "nannayeong@gmail.com");
					emailContent.put("to", "nannayeong@gmail.com");
					emailContent.put("subject", "체험학습 의뢰서");
					//emailContent.put("content", request.getParameter("content"));
					emailContent.put("content", mailContents);
		
					emailResult = smtp.emailSending(emailContent);
					if(emailResult==true){
						System.out.println("메일발송성공");

					}
					else{
						System.out.println("메일발송실패");
					}
					resp.sendRedirect("./reqform.do?reqName="+reqName);

			}		
		}
		else {
			out.print("<script>alert('제출 실패'); "
					+ "location.href='../market/reqform.do?reqName="+reqName+"';</script>");
		}
		
		
		
		
		
	}
}
