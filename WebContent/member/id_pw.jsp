<%@page import="smtp.SMTPAuth"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%

	/*이메일*/
	request.setCharacterEncoding("UTF-8");
	//메일발송을 위한 객체생성
	SMTPAuth smtp = new SMTPAuth();

	if(request.getParameter("name1")!=null){
		String name = request.getParameter("name1");
		String email = request.getParameter("email1");
		
		MemberDAO dao = new MemberDAO();
		String id = dao.selectId(name, email);
		
		if(id!=null&&!id.equals("")){
			out.println("<script>alert('아이디는 "+id+"입니다'); location.href='login.jsp';</script>");
		}
		else{
			out.println("<script>alert('일치하는 계정이 없습니다.'); location.href='id_pw.jsp';</script>");
		}
	}

	if(request.getParameter("name2")!=null){
		String id = request.getParameter("id");
		String name = request.getParameter("name2");
		String email = request.getParameter("email2");
		
		MemberDAO dao = new MemberDAO();
		String pw = dao.selectPw(name, email, id);
		
		if(id!=null&&!id.equals("")){
			String mailContents = "비밀번호는 "+ pw+"입니다";
			
			//메일을 보내기위한 여러가지 폼값을 Map컬렉션에 저장
			Map<String,String> emailContent = new HashMap<String,String>();
			emailContent.put("from", "nannayeong@gmail.com");
			emailContent.put("to", email);
			emailContent.put("subject", "비밀번호찾기");
			//emailContent.put("content", request.getParameter("content"));
			emailContent.put("content", mailContents);

			boolean emailResult = smtp.emailSending(emailContent);
			if(emailResult==true){
				System.out.println("메일발송성공");
				out.print("<script>alert('비밀번호 이메일을 발송하였습니다.')</script>");
			}
			else{
				System.out.println("메일발송실패");
			}
		}
		else{
			out.println("<script>alert('일치하는 계정이 없습니다.'); location.href='id_pw.jsp';</script>");
		}
	}

%>
<script>
	function selectId(){
		var name = document.getElementById("name1").value;
		var email = document.getElementById("email1").value;
		
		if(name==null||name==""){
			alert("찾으실 이름을 입력하세요");
			return;
		}
		if(email==null||email==""){
			alert("찾으실 이메일을 입력하세요");
			return;
		}
		location.href="id_pw.jsp?name1="+name+"&email1="+email;
	}
	function selectPw(){
		var id = document.getElementById("id").value;
		var name = document.getElementById("name2").value;
		var email = document.getElementById("email2").value;
		
		if(id==null||id==""){
			alert("찾으실 아이디를 입력하세요");
			return;
		}
		if(name==null||name==""){
			alert("찾으실 이름을 입력하세요");
			return;
		}
		if(email==null||email==""){
			alert("찾으실 이메일을 입력하세요");
			return;
		}
		location.href="id_pw.jsp?id="+id+"&name2="+name+"&email2="+email;
	}
</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<div class="idpw_box">
					<div class="id_box">
						<ul>
							<li><input type="text" id="name1" name="name1" value="" class="login_input01" /></li>
							<li><input type="text" id="email1" name="email" value="" class="login_input01" /></li>
						</ul>
						<a href="javascript:selectId();"><img src="../images/member/id_btn01.gif" class="id_btn" /></a>
						<a href="join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
					</div>
					<div class="pw_box">
						<ul>
							<li><input type="text" id="id" name="" value="" class="login_input01" /></li>
							<li><input type="text" id="name2" name="" value="" class="login_input01" /></li>
							<li><input type="text" id="email2" name="" value="" class="login_input01" /></li>
						</ul>
						<a href="javascript:selectPw();"><img src="../images/member/id_btn01.gif" class="pw_btn" /></a>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
	
 </body>
</html>
