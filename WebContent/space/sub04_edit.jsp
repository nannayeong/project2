<%@page import="model.BbsDAO"%>
<%@page import="model.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

 <body>
 <script>
	function checkValidate(fm){
		if(fm.title.value==""){
			alert("제목을 입력하세요."); 
			fm.title.focus(); 
			return false; 
		}
		if(fm.content.value==""){
			alert("내용을 입력하세요."); 
			fm.content.focus(); 
			return false;
		}
	}
</script>
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
				<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
			</div>
			<div>
				<form enctype="multipart/form-data" name="writeFrm" method="post"
					onsubmit="return checkValidate(this);" >
					<input type="hidden" name="boardName" value="${BOARD_NAME }" />
					<input type="hidden" name="originalfile" value="${BBSDTO.attachedfile }"/>
					<table class="table table-bordered">
						<colgroup>
							<col width="20%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
							<tr>
								<th class="text-center" 
									style="vertical-align:middle;">제목</th>
								<td>
									<input type="text" class="form-control" name="title" value="${BBSDTO.title }"/>
								</td>
							</tr>
							<tr>
								<th class="text-center" 
									style="vertical-align:middle;">내용</th>
								<td>
									<textarea rows="10" class="form-control" name="content">${BBSDTO.content }</textarea>
								</td>
							</tr>
							<c:choose>
			      				<c:when test="${BOARD_TYPE=='file'||BOARD_TYPE=='photo'}">
			                  <tr>
			                    <th class="text-center" style="vertical-align:middle;">첨부파일</th>
								<td>
									<input type="file" class="form-control" name="attachedfile"/>
								</td>
			                  </tr>
			                  	</c:when>
			                 </c:choose>
						</tbody>
					</table>
					<div class="row text-center" style="">
						<!-- 각종 버튼 부분 -->
						<button type="submit" class="btn btn-danger">전송하기</button>
						<button type="reset" class="btn">Reset</button>
						<button type="button" class="btn btn-warning" 
						onclick="location.href='../board/boardList.do?boardName=${BOARD_NAME}';">리스트보기</button>
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