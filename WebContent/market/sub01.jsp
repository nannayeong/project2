<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>


 <body>
 
 <script>
	function basket(num){
		var q = $('input[name=quantity]').val();
		location.href="basketInsert.do?num="+num+"&quantity="+q;
	}
	
	 function buyFunc(num){
			location.href="./basket02List.do?num="+num+"&quantity="+$('input[name=quantity]').val()+"&param=one";
		}
</script>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<table cellpadding="0" cellspacing="0" border="0" class="market_board01">
					<colgroup>
						<col width="5%" />
						<col width="20%" />
						<col width="*" />
						<col width="10%" />
						<col width="10%" />
						<col width="15%" />
					</colgroup>
					<tr>
						<th>선택</th>
						<th>상품이미지</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>구매</th>
					</tr>
					<c:choose>
						<c:when test="${empty DTO_LIST }">
						<tr><td colspan="6" align="center" height="100">등록된 게시물이 없습니다.</td></tr>
						</c:when>
						<c:otherwise>
						<c:forEach items="${DTO_LIST}" var="dto" varStatus="status">
					<tr>
						<td><input type="checkbox" name="check" value="Y" /></td>
						<td>
						<a href="shopView.do?num=${dto.num }">
						<img src="/project2/upload/${dto.img }" alt="첨부사진" 
						style="width: 100px; height:100px"/></a></td>
						<td class="t_left">
						<a href="shopView.do?num=${dto.num }">${dto.name }</a></td>
						<td class="p_style">${dto.price }</td>
						<td><input type="text" name="quantity" value="1" class="n_box" /></td>
						<td><a href="javascript:buyFunc(${dto.num })"><img src="../images/market/btn01.gif" style="margin-bottom:5px;" /></a>
						<br /><a href="javascript:basket(${dto.num });"><img src="../images/market/btn02.gif" /></a></td>
					</tr>
						</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
				<div class="row text-center">
						<!-- 페이지번호 부분 -->
						<ul class="pagination">
							${PAGING}
						</ul>	
					</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
