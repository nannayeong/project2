<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<% session.setAttribute("orderP" ,request.getAttribute("DTO_LIST"));%>
 <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function DaumPostcode1() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    $('input[name=oaddress2]').val(extraAddr);
                
                } else {
                	$('input[name=oaddress2]').val('');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('input[name=oaddress1]').val(data.zonecode);
                $('input[name=oaddress2]').val(addr);
                // 커서를 상세주소 필드로 이동한다.
                $('input[name=oaddress2]').focus();
            }
        }).open();
    }
    
    function DaumPostcode2() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    $('input[name=saddress2]').val(extraAddr);
                
                } else {
                	$('input[name=saddress2]').val('');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('input[name=saddress1]').val(data.zonecode);
                $('input[name=saddress2]').val(addr);
                // 커서를 상세주소 필드로 이동한다.
                $('input[name=saddress2]').focus();
            }
        }).open();
    }
    
    $(function(){
    	$('input:radio[name=eq]').click(function(){
    		if($('input:radio[name=eq]:checked').val()=="Y"){
    			$('input[name=sname]').val($('input[name=oname]').val());
    			$('input[name=saddress1]').val($('input[name=oaddress1]').val());
    			$('input[name=saddress2]').val($('input[name=oaddress2]').val());
    			$('input[name=saddress3]').val($('input[name=oaddress3]').val());
    			$('input[name=sphone1]').val($('input[name=ophone1]').val());
    			$('input[name=sphone2]').val($('input[name=ophone2]').val());
    			$('input[name=sphone3]').val($('input[name=ophone3]').val());
    			$('input[name=semail1]').val($('input[name=oemail1]').val());
    			$('input[name=semail2]').val($('input[name=oemail2]').val());
    			
    			$('input[name=sname]').attr("readonly", true);
    			$('input[name=saddress1]').attr("readonly", true);
    			$('input[name=saddress2]').attr("readonly", true);
    			$('input[name=saddress3]').attr("readonly", true);
    			$('input[name=sphone1]').attr("readonly", true);
    			$('input[name=sphone2]').attr("readonly", true);
    			$('input[name=sphone3]').attr("readonly", true);
    			$('input[name=semail1]').attr("readonly", true);
    			$('input[name=semail2]').attr("readonly", true);
    		}
    		else if($('input:radio[name=eq]:checked').val()=="N"){
    			$('input[name=sname]').attr("readonly", false);
    			$('input[name=saddress1]').attr("readonly", false);
    			$('input[name=saddress2]').attr("readonly",false);
    			$('input[name=saddress3]').attr("readonly", false);
    			$('input[name=sphone1]').attr("readonly",false);
    			$('input[name=sphone2]').attr("readonly",false);
    			$('input[name=sphone3]').attr("readonly", false);
    			$('input[name=semail1]').attr("readonly", false);
    			$('input[name=semail2]').attr("readonly", false);
    		}
    	});
    	
    	
    });
    
    function submitFunc(){
    	if($('input[name=sname]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=saddress1]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=saddress2]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=saddress3]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=sphone1]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=sphone2]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=sphone3]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=semail1]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=semail2]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=oaddress1]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=oaddress2]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=oaddress3]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=ophone1]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=ophone2]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=ophone3]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=oemail1]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=oemail2]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    	if($('input[name=pay]').val()==""){
    		alert('모든 항목을 작성해주세요');
    		return false;
    	}
    }
    
    function quanFunc(idx, num){
   	 location.href="./basketEdit.do?idx="+idx+"&num="+num+"&quantity="+$('input[name=quantity]').val()+"&param="+$('input:hidden').val();
    }
</script>

 <body>
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
				<p class="con_tit"><img src="../images/market/basket_title01.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list" style="margin-bottom:50px;">
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
						<tr><td colspan="6" align="center" height="100">상품이 없습니다.</td></tr>
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
							<a href="javascript:quanFunc(${dto.idx==null?1:dto.idx}, ${dto.num});">
							<img src="../images/market/m_btn.gif" /></a></td>
							<td>무료배송</td>
							<td>[조건]</td>
							<td><span>${dto.total }원<span></td>
							<input type="hidden" value="${PARAM }" />
						</tr>
						</c:forEach>
						</c:otherwise>
						</c:choose>
						
				</table>
				<form action="basket02Insert.do" method="post" onsubmit="return submitFunc();">
				<p class="con_tit"><img src="../images/market/basket_title02.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;"><input type="text" name="oname"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;"><input type="text" name="oaddress1"  value="" class="join_input" style="width:50px; margin-bottom:5px;" readonly/>
							<a href="javascript:DaumPostcode1();"><img src="../images/market/basket_btn03.gif" style="margin-bottom:5px;" /></a><br />
							<input type="text" name="oaddress2"  value="" class="join_input" style="width:300px; margin-bottom:5px;" /> 기본주소<br />
							<input type="text" name="oaddress3"  value="" class="join_input" style="width:300px;" /> 나머지주소</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="ophone1"  value="" class="join_input" style="width:50px;" /> - 
							<input type="text" name="ophone2"  value="" class="join_input" style="width:50px;" /> - 
							<input type="text" name="ophone3"  value="" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" name="oemail1"  value="" class="join_input" style="width:100px;" /> @ 
							<input type="text" name="oemail2"  value="" class="join_input" style="width:100px;" /></td>
						</tr>
					</tbody>
				</table>

				<p class="con_tit"><img src="../images/market/basket_title03.gif" /></p>
				<p style="text-align:right">배송지 정보가 주문자 정보와 동일합니까? 
				예<input type="radio" name="eq" value="Y"/> 아니오<input type="radio" name="eq" value="N"/></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;"><input type="text" name="sname"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;"><input type="text" name="saddress1"  value="" class="join_input" style="width:50px; margin-bottom:5px;" readonly/>
							<a href="javascript:DaumPostcode2();"><img src="../images/market/basket_btn03.gif" style="margin-bottom:5px;" /></a><br />
							<input type="text" name="saddress2"  value="" class="join_input" style="width:300px; margin-bottom:5px;" /> 기본주소<br />
							<input type="text" name="saddress3"  value="" class="join_input" style="width:300px;" /> 나머지주소</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="sphone1"  value="" class="join_input" style="width:50px;" /> - 
							<input type="text" name="sphone2"  value="" class="join_input" style="width:50px;" /> - 
							<input type="text" name="sphone3"  value="" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" name="semail1"  value="" class="join_input" style="width:100px;" /> @ 
							<input type="text" name="semail2"  value="" class="join_input" style="width:100px;" /></td>
						</tr>
						<tr>
							<th>배송메세지</th>
							<td style="text-align:left;"><input type="text" name="msg"  value="경비실에 맡겨주세요.." class="join_input" style="width:500px;" /></td>
						</tr>
					</tbody>
				</table>

				<p class="con_tit"><img src="../images/market/basket_title04.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:30px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>결제금액</th>
							<td style="text-align:left;"><span class="money">${TOTAL }원</span></td>
							<input type="hidden" value="${TOTAL }" name="money"/>
						</tr>
						<tr>
							<th>결제방식선택</th>
							<td style="text-align:left;">
							<input type="radio" name="pay" value="credit"/> 카드결제&nbsp;&nbsp;&nbsp;
							<input type="radio" name="pay" value="nopassbook" /> 무통장입금&nbsp;&nbsp;&nbsp;
							<input type="radio" name="pay" value="passbook"/> 실시간 계좌이체</td>
						</tr>
					</tbody>
				</table>
				<p style="text-align:right;"><input type=image src="../images/market/basket_btn04.gif" /></p>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
