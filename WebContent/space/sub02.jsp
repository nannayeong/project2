<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
Calendar c = Calendar.getInstance();
Calendar cal = Calendar.getInstance();

int currMonth = c.get(Calendar.MONTH);
int currYear = c.get(Calendar.YEAR);
cal.set(currYear,currMonth,1);

%>
<script>
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

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub02_title.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
				</div>
				<div>
					<table class="table table-bordered table-hover">
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
				<div>
					<table class="table table-bordered table-hover" id="cal">
					
					</table>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
