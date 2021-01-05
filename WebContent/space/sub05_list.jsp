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
					<img src="../images/space/sub05_title.gif" alt="정보자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;정보자료실<p>
				</div>
				<div>
					<div class="row text-right" style="margin-bottom:20px;
							padding-right:50px;">
					<!-- 검색부분 -->
					<form class="form-inline">	
						<div class="form-group">
							<input type="hidden" name="boardName" value="info" />
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
							<input type="text" name="serachWord"  class="form-control"/>
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
							<col width="80px"/>
							<col width="250px"/>
							<col width="80px"/>
							<col width="80px"/>
							<col width="80px"/>
							<col width="*"/>
						</colgroup>
						
						<thead>
						<tr class="success">
							<th class="text-center">번호</th>
							<th class="text-center">제목</th>
							<th class="text-center">작성자</th>
							<th class="text-center">작성일</th>
							<th class="text-center">조회수</th>
							<th class="text-center">첨부</th>
						</tr>
						</thead>
						
						<tbody>
						<!-- 리스트반복 -->
						 <c:choose>
                			<c:when test="${empty BBSDTO_LIST}">
							<tr><td colspan="6" align="center" height="100">등록된 게시물이 없습니다.</td></tr>
							</c:when>
                			<c:otherwise>
								<c:forEach items="${BBSDTO_LIST}" var="dto" varStatus="status">
						<tr>
							<th>${BBSDTO_LIST_COUNT - status.index}</th>
		                    <th><a href="boardView.do?num=${dto.num }&${PARAMSTR}">${dto.title }</a></th>
		                    <th>${dto.id}</th>
		                    <th>${dto.postdate}</th>
		                    <th>${dto.visitcount}</th>
		                    <td>
							<c:if test="${not empty dto.attachedfile }">
								${dto.attachedfile }	
							</c:if>	
							</td>
						</tr>	
								</c:forEach>
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