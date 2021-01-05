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
				<div class="market_view_box">
					<div class="market_left">
						<img src="/project2/upload/${DTO.img }" alt="첨부사진" 
			style="width: 300px; height:300px"/>
					</div>
					<div class="market_right">
						<p class="m_title">${DTO.name}
						<p>- ${DTO.name}</p>
						<ul class="m_list">
							<li>
								<dl>
									<dt>가격</dt>
									<dd class="p_style">${DTO.price}</dd>
								</dl>
								<dl>
									<dt>적립금</dt>
									<dd>${DTO.point}</dd>
								</dl>
								<dl>
									<dt>수량</dt>
									<dd><input type="text" name="quantity" value="1" class="n_box" /></dd>
								</dl>
								<dl style="border-bottom:0px;">
									<dt>주문정보</dt>
									<dd><input type="text" name="" class="n_box" style="width:200px;" /></dd>
								</dl>
								<div style="clear:both;"></div>
							</li>
						</ul>
						<p class="btn_box"><a href="javascript:buyFunc(${DTO.num })"><img src="../images/market/m_btn01.gif" alt="바로구매" /></a>&nbsp;&nbsp;
						<a href="javascript:basket(${DTO.num });"><img src="../images/market/m_btn02.gif" alt="장바구니" /></a></p>
					</div>
				</div>
				<img src="/project2/upload/${DTO.img }" alt="첨부사진" 
			style="width: 500px; height:500px"/>

			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
