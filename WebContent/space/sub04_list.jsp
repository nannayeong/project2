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
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
				<div>
					<div class="row text-right" style="margin-bottom:20px;
							padding-right:50px;">
					<!-- 검색부분 -->
					<form class="form-inline">	
						<div class="form-group">
							<input type="hidden" name="boardName" value="free" />	
							<select name="searchColumn" class="form-control">
								<option value="title"
								${PARAM.searchColumn!=null && PARAM.searchColumn=="title"?"selected":""} 
								>제목</option>		
							<option value="content" 
								${PARAM.searchColumn!=null && PARAM.searchColumn=="content"?"selected":""} >내용</option>
							<option value="name"
								${PARAM.searchColumn!=null && PARAM.searchColumn=="name"?"selected":""}>작성자</option>
							</select>
						</div>
						<div class="input-group">
							<input type="text" name="searchWord"  class="form-control"/>
							<div class="input-group-btn">
								<button type="submit" class="btn btn-default">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</div>
						</div>
					</form>	
					</div>
					<div class="row">
						<!-- 게시판리스트부분 -->
						<table class="table table-bordered table-hover">
						<colgroup>
							
						</colgroup>
						
						<thead>
						
						</thead>
						
						<tbody>
						<!-- 리스트반복 -->
						 <c:choose>
                			<c:when test="${empty BBSDTO_LIST}">
							<tr><td colspan="6" align="center" height="100">등록된 게시물이 없습니다.</td></tr>
							</c:when>
							<c:otherwise>
							<tr>
							<c:forEach items="${BBSDTO_LIST}" begin="0" end="2" step="1" var="dto" varStatus="status">
								<th style="text-align:center">
									<img src="/project2/upload/${dto.attachedfile }" alt="첨부사진" style="width: 100px; height:100px"/>
									<div><span>제목:</span><a href="boardView.do?num=${dto.num }&${PARAMSTR}">${dto.title }</a></div>
									<div><span>아이디:</span>${dto.id } <span>게시일:</span>${dto.postdate} <span>조회수:</span>${dto.visitcount}</div>
								</th>	
							</c:forEach>
							</tr>
							<tr>
							<c:forEach items="${BBSDTO_LIST}" begin="3" end="5" step="1" var="dto" varStatus="status">
								<th style="text-align:center">
									<img src="/project2/upload/${dto.attachedfile }" alt="첨부사진" style="width: 100px; height:100px"/>
									<div><span>제목:</span><a href="boardView.do?num=${dto.num }&${PARAMSTR}">${dto.title }</a></div>
									<div><span>아이디:</span>${dto.id } <span>게시일:</span>${dto.postdate} <span>조회수:</span>${dto.visitcount}</div>
								</th>	
							</c:forEach>
							</tr>
							<tr>
							<c:forEach items="${BBSDTO_LIST}" begin="6" end="8" step="1" var="dto" varStatus="status">
								<th style="text-align:center">
									<img src="/project2/upload/${dto.attachedfile }" alt="첨부사진" style="width: 100px; height:100px"/>
									<div><span>제목:</span><a href="boardView.do?num=${dto.num }&${PARAMSTR}">${dto.title }</a></div>
									<div><span>아이디:</span>${dto.id } <span>게시일:</span>${dto.postdate} <span>조회수:</span>${dto.visitcount}</div>
								</th>	
							</c:forEach>
							</tr>
							</c:otherwise>
		                	
		                </c:choose>
						</tbody>
						</table>
					</div>
					<div class="row text-right" style="padding-right:50px;">
						<!-- 각종 버튼 부분 -->
						<!-- <button type="reset" class="btn">Reset</button> -->
						<c:choose>
							<c:when test="${USER_GRADE!=null }">
								<button type="button" class="btn btn-primary" 
									onclick="location.href='boardWrite.do?boardName=${PARAM.boardName}';">글쓰기</button>
							</c:when>
						</c:choose>
						<!-- <button type="button" class="btn btn-primary">수정하기</button>
						<button type="button" class="btn btn-success">삭제하기</button>
						<button type="button" class="btn btn-info">답글쓰기</button>
						<button type="button" class="btn btn-warning">리스트보기</button>
						<button type="submit" class="btn btn-danger">전송하기</button> -->
					</div>
					<div class="row text-center">
						<!-- 페이지번호 부분 -->
						<ul class="pagination">
							${PAGING}
						</ul>	
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