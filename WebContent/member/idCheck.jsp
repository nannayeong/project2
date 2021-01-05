<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	
	MemberDAO dao = new MemberDAO();
	int duple = dao.joinCheckId(id);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../common/bootstrap-4.5.3/css/bootstrap-grid.css" />
<script src="../common/jquery/jquery-3.5.1.min.js"></script>
</head>
<body>
<script>
	function yFunc(){
		opener.document.getElementById("hidId").value=document.getElementById("checkId").innerHTML;
		window.close();
	}
	function nFunc(){
		opener.document.getElementById("id").value="";
		window.close();
	}
</script>
	<form>
		<span id="checkId"><%=id %></span>
	<!-- 사용가능 -->
	<%if(duple==0){ %>
		<span>는 사용할 수 있는 아이디입니다.</span>
		<br />
		<button type="button" onclick="yFunc();">확인</button>
		<button type="button" onclick="nFunc();">취소</button>
	<%
	}
	else{
	%>
	<!-- 사용불가능 -->
		<span>는 사용할 수 없는 아이디입니다.</span>
		<div>
			<input type="text" name="id"/>
			<input type="submit" value="중복확인" />
		</div>
	<%
	}
	%>
	</form>
</body>
</html>