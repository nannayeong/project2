<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>


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

<form enctype="multipart/form-data">
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
			${BBSDTO.id}
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>
			${BBSDTO.postdate}
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			${BBSDTO.email}
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>
			${BBSDTO.visitcount}
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			${BBSDTO.title}
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			${BBSDTO.content}
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">일정</th>
		<td colspan="3">
			${BBSDTO.date }
		</td>
    </tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	<button type="button" class="btn btn-warning" 
		onclick="location.href='../board/boardList.do?${PARAMSTR}';">리스트보기</button>
	<c:choose>
		<c:when test="${BBSDTO.id==USER_ID }">
		<button type="button" class="btn btn-primary" 
		onclick="location.href='boardEdit.do?num=${BBSDTO.num}&${PARAMSTR}'">수정하기</button>
		<button type="button" class="btn btn-success" 
		onclick="location.href='boardDelete.do?num=${BBSDTO.num}&${PARAMSTR}'">삭제하기</button>
		</c:when>
	</c:choose>
</div>
</form> 

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>