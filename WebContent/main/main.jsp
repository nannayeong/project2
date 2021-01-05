<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
Calendar c = Calendar.getInstance();
Calendar cal = Calendar.getInstance();

int currMonth = c.get(Calendar.MONTH);
int currYear = c.get(Calendar.YEAR);
cal.set(currYear,currMonth,1);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="../common/jquery/jquery-3.5.1.min.js"></script>
<title>마포구립장애인 직업재활센터</title>
<style type="text/css" media="screen">
@import url("../css/common.css");
@import url("../css/main.css");
@import url("../css/sub.css");
</style>
</head>
<body>
<script>
function loginFunc(fm){
	if(fm.id.value==""){
		alert("아이디를 입력해주세요");
		return false;
	}
	if(fm.pw.value==""){
		alert("비밀번호를 입력해주세요");
		return false;
	}
}

$(function(){
	$.ajax({
		url : "./cal.jsp",
		dataType : "html",
		type : "get",
		contentType : "text/html;charset:utf-8",
		success : sucFunc
	});
});

function sucFunc(resData){
	$('#cal').html(resData);
}

var m = <%=currMonth%>;
var y = <%=currYear%>;

function calUp(){	
	$.ajax({
		url : "./cal.jsp",
		dataType : "html",
		type : "get",
		data: {"month":m,"year":y,"action":1},
		contentType : "text/html;charset:utf-8",
		success : sucFunc
	});
	m+=1;
}

function calDown(){
	$.ajax({
		url : "./cal.jsp",
		dataType : "html",
		type : "get",
		data: {"month":m,"year":y,"action":0},
		contentType : "text/html;charset:utf-8",
		success : sucFunc
	});
	m-=1;
}
</script>
<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>
		
		<div id="main_visual">
		<a href="/product/sub01.jsp"><img src="../images/main_image_01.jpg" /></a><a href="/product/sub01_02.jsp"><img src="../images/main_image_02.jpg" /></a><a href="/product/sub01_03.jsp"><img src="../images/main_image_03.jpg" /></a><a href="/product/sub02.jsp"><img src="../images/main_image_04.jpg" /></a>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title01.gif" alt="로그인 LOGIN" /></p>
				
				<form action="main.do" id="loginFrm" method="post" onsubmit="return loginFunc(this);">
				<div class="login_box">
				<c:choose>
					<c:when test="${empty USER_ID }">
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="45px" />
							<col width="120px" />
							<col width="55px" />
						</colgroup>
						<tr>
							<th><img src="../images/login_tit01.gif" alt="아이디" /></th>
							<td><input type="text" id="id" name="id" value="${cookie.COOKIE_ID!=null?cookie.COOKIE_ID:''}" class="login_input" /></td>
							<td rowspan="2"><input type="image" src="../images/login_btn01.gif" alt="로그인" /></td>
						</tr>
						<tr>
							<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
							<td><input type="text" id="pw" name="pw" value="" class="login_input" /></td>
						</tr>
					</table>
					<p>
						<input type="checkbox" name="cookieId" value="Y" /><img src="../images/login_tit03.gif" alt="저장" />
						<a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>
						<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a>
					</p>
					</c:when>
					<c:otherwise>
					<!-- 로그인 후 -->
					<p style="padding:10px 0px 10px 10px"><span style="font-weight:bold; color:#333;"><strong>${USER_NAME}</strong>님,반갑습니다.<br />로그인 하셨습니다.</p>
					<p style="text-align:right; padding-right:10px;">
						<a href=""><img src="../images/login_btn04.gif" /></a>
						<a href="main.do?logout=Y"><img src="../images/login_btn05.gif" /></a>
					</p>
					</c:otherwise>
			 	</c:choose>
				</div>
				</form>
			</div>
			<div class="main_con_center">
				<p class="main_title"><img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a href="/space/sub01.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
					<c:forEach items="${NOTICELIST }" var="notice" varStatus="status" begin="0" end="4" step="1">
					<li>
						<p><a href='../board/boardView.do?boardName=notice&num=${notice.num }'>
						${fn:length(notice.title)>=20?fn:substring(notice.title,0,20):notice.title}</a>
						<span>${notice.postdate}</span></p>
					</li>
					</c:forEach>
				</ul>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a href="/Project2/space/sub03_list.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
					<c:forEach items="${FREELIST }" var="free" varStatus="status" begin="0" end="4" step="1">
					<li>
						<p><a href='../board/boardView.do?boardName=free&num=${free.num }'>
						${fn:length(free.title)>=20?fn:substring(free.title,0,20):free.title}</a>
						<span>${free.postdate}</span></p>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title"><img src="../images/main_title04.gif" alt="월간일정 CALENDAR" /></p>
				<img src="../images/main_tel.gif" />
			</div>
			<div class="main_con_center">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title05.gif" alt="월간일정 CALENDAR" /></p>
				<div class="cal_top">
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="13px;" />
							<col width="*" />
							<col width="13px;" />
						</colgroup>
						<tr>
							<td><a href="javascript:calDown();"><img src="../images/cal_a01.gif" style="margin-top:3px;" /></a></td>
							<td><img src="../images/calender_2012.gif" />&nbsp;&nbsp;<img src="../images/calender_m1.gif" /></td>
							<td><a href="javascript:calUp();"><img src="../images/cal_a02.gif" style="margin-top:3px;" /></a></td>
						</tr>
					</table>
				</div>
				<div class="cal_bottom">
					<table cellpadding="0" cellspacing="0" border="0" class="calendar" id="cal">
					</table>
				</div>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a href="/space/sub04.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_photo_list">
				<c:forEach items="${PHOTOLIST }" var="photo" varStatus="status" begin="0" end="5" step="1">
					<li>
						<dl style=" text-align:center">
							<dt><a href="../board/boardView.do?boardName=photo&num=${photo.num }">
							<img src="/project2/upload/${photo.attachedfile }" style="width:80px; height:80px;"/></a></dt>
							<dd><a href="../board/boardView.do?boardName=photo&num=${photo.num }">
							${fn:length(photo.title)>=8?fn:substring(photo.title,0,8):photo.title}</a></dd>
						</dl>
					</li>
				</c:forEach>
				</ul>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>

	<%@ include file="../include/footer.jsp"%>
	
</center>
</body>
</html>