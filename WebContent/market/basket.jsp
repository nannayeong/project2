<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>


 <body>
 <script>
 function quanFunc(idx, price, num){
	 location.href="./basketEdit.do?idx="+idx+"&quantity="+$('input[name=quantity]').val()+"&num="+num+"&param=all";
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
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="8%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="8%" />
					</colgroup>
					<thead>
						<tr>
							<th>선택</th>
							<th>이미지</th>
							<th>상품명</th>
							<th>판매가</th>
							<th>적립금</th>
							<th>수량</th>
							<th>배송구분</th>
							<th>배송비</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
						<c:when test="${empty DTO_LIST }">
						<tr><td colspan="6" align="center" height="100">장바구니에 상품이 없습니다.</td></tr>
						</c:when>
						<c:otherwise>
						<c:forEach items="${DTO_LIST}" var="dto" varStatus="status">
						<tr>
							<td><input type="checkbox" name="" value="" /></td>
							<td><a href="shopView.do?num=${dto.num }">
						<img src="/project2/upload/${dto.img }" alt="첨부사진" 
						style="width: 100px; height:100px"/></a></td>
							<td>${dto.name }</td>
							<td>${dto.price }원</td>
							<td><img src="../images/market/j_icon.gif" />&nbsp;${dto.point }원</td>
							<td><input type="text" name="quantity" value="${dto.quantity }" class="basket_num" />&nbsp;
							<a href="javascript:quanFunc(${dto.idx}, ${dto.price },${dto.num });"><img src="../images/market/m_btn.gif" /></a></td>
							<td>무료배송</td>
							<td>[조건]</td>
							<td><span>${dto.total }원<span></td>
						</tr>
						</c:forEach>
						</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<p class="basket_text">[ 기본 배송 ] <span>상품구매금액</span>
				 ${TOTAL } + <span>배송비</span> 0 = 합계 : <span class="money"> ${TOTAL }원</span><br /><br />
				 <a href="./shopList.do"><img src="../images/market/basket_btn01.gif" /></a>&nbsp;
				 <a href="basket02List.do?param=all"><img src="../images/market/basket_btn02.gif" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
