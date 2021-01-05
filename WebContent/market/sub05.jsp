<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script>
	function submitFunc(fm){
		if(fm.name.value==""){
			alert("고객명/회사명을 입력해주세요");
			return false;
		}
		if(fm.address.value==""){
			alert("주소를 입력해주세요");
			return false;
		}
		if(fm.phone1.value==""){
			alert("연락처를 입력해주세요");
			return false;
		}
		if(fm.phone2.value==""){
			alert("연락처를 입력해주세요");
			return false;
		}
		if(fm.phone3.value==""){
			alert("연락처를 입력해주세요");
			return false;
		}
		if(fm.phone1.value==""){
			alert("이메일을 입력해주세요");
			return false;
		}
		if(fm.phone2.value==""){
			alert("이메일을 입력해주세요");
			return false;
		}
		if(fm.req1.value==""){
			alert("케익체험란을 입력해주세요");
			return false;
		}
		if(fm.req2.value==""){
			alert("쿠키체험란을 입력해주세요");
			return false;
		}
		if(fm.reqD.value==""){
			alert("청소 희망날짜를 입력해주세요");
			return false;
		}
		if(fm.reqK.value==""){
			alert("접수종류를 선택해주세요");
			return false;
		}
	}
	
	$(function(){
		 
	    // 라디오버튼 클릭시 이벤트 발생
	    $("input:radio[name=disorderCheck]").click(function(){
	 
	    	if($('input:radio[name=disorderCheck]:checked').val()=="Y"){
	    		$("#disorder").attr("disabled", false);
	    		$('input:radio[name=aidCheck]').attr("disabled", false);
	    	}
	    	else{
	    		$("#disorder").attr("disabled", true);
	    		$('input:radio[name=aidCheck]').attr("disabled", true);
	    		$("#disorder").val("");
	    		$('#aid').val("");
	    	}
	    });
	    
	    $("input:radio[name=aidCheck]").click(function(){
	   	 
	    	if($('input:radio[name=aidCheck]:checked').val()=="Y"){
	    		$("#aid").attr("disabled", false);
	    	}
	    	else{
	    		$("#aid").attr("disabled", true);
	    		$('#aid').val("");
	    	}
	    });
	});

	

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
					<img src="../images/market/sub05_title.gif" alt="체험학습신청" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;체험학습신청<p>
				</div>
				<p class="con_tit"><img src="../images/market/sub05_tit01.gif" /></p>
				<ul class="dot_list">
					<li>무 방부제 • 무첨가제 수제 빵 제작 체험</li>
					<li>사전에 준비된 반죽으로 성형 및 굽기 체험</li>
					<li>참가비 : 일인당 20,000원 (교육비, 재료비 포함)</li>
				</ul>
				<p class="con_tit"><img src="../images/market/sub05_tit02.gif" /></p>
				<ul class="dot_list">
					<li>내가만든 맛있는 쿠키~!</li>
					<li>쿠키의 반죽 ,성형, 굽기 기술 경험의 기회! </li>
					<li>참가비 : 일인당 15,000원 (교육비, 재료비 포함)</li>
				</ul>
				<p class="con_tit"><img src="../images/market/sub05_tit03.gif" /></p>
				<ul class="dot_list">
					<li>만드는 즐거움 받는이에겐 감동을~!</li>
					<li>직접 데코레이션한 세상에서 하나뿐인
케익을 소중한 사람에게 전하세요~!
</li>
					<li>준비된 케익시트에 테코레이션 과정 체험</li>
					<li>참가비 : 일인당 25,000원 (교육비, 재료비 포함)</li>
				</ul>
				<div style="text-align:left">
					<img src="../images/market/sub05_img01.jpg" style="margin-bottom:30px;" />
				</div>
				<c:choose>
				<c:when test="${not empty USER_ID}">
				<form action="../market/reqform.do" method="post" onsubmit="return submitFunc(this);">
				<input type="hidden" name="reqName" value="exper" />
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;">
					<colgroup>
						<col width="25%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>고객명/회사명</th>
							<td style="text-align:left;"><input type="text" name="name"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>장애유무</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td style="border-bottom:0px;">
										<input type="radio" name="disorderCheck"  value="Y"/> 유&nbsp;&nbsp;&nbsp;
										<input type="radio" name="disorderCheck"  value="N" /> 무</td>
										<th style="border-bottom:0px;" width="100px">주요장애유형</th>
										<td style="border-right:0px; border-bottom:0px;"><input type="text" id="disorder" name="disorder"  value="" class="join_input" disabled/></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>보장구 사용유무</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td style="border-bottom:0px;"><input type="radio" name="aidCheck"  value="Y" disabled/> 유&nbsp;&nbsp;&nbsp;
										<input type="radio" name="aidCheck"  value="N" disabled/> 무</td>
										<th style="border-bottom:0px;" width="100px">보장구 명</th>
										<td style="border-right:0px; border-bottom:0px;"><input type="text" id="aid" name="aid"  value="" class="join_input" disabled/></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td style="text-align:left;"><input type="text" name="phone1"  value="" class="join_input" style="width:50px;" /> - 
							<input type="text" name="phone2"  value="" class="join_input" style="width:50px;" /> - 
							<input type="text" name="phone3"  value="" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>담당자 휴대전화</th>
							<td style="text-align:left;"><input type="text" name="phone4"  value="" class="join_input" style="width:50px;" /> - 
							<input type="text" name="phone5"  value="" class="join_input" style="width:50px;" /> - 
							<input type="text" name="phone6"  value="" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td style="text-align:left;"><input type="text" name="email1"  value="" class="join_input" style="width:100px;" /> @ 
							<input type="text" name="email2"  value="" class="join_input" style="width:100px;" /></td>
						</tr>
						<tr>
							<th>체험내용</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td>케익체험</td>
										<td style="border-right:0px;"><input type="text" name="req1"  value="" class="join_input" /></td>
									</tr>
									<tr>
										<td style="border-bottom:0px;">쿠키체험</td>
										<td style="border:0px;"><input type="text" name="req2"  value="" class="join_input" /></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>체험희망날짜</th>
							<td style="text-align:left;"><input type="text" name="reqD"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>접수종류 구분</th>
							<td style="text-align:left;"><input type="radio" name="reqK"  value="1" /> 예약신청
&nbsp;&nbsp;&nbsp;<input type="radio" name="reqK"  value="2" /> 견적문의</td>
						</tr>
						<tr>
							<th>기타특이사항</th>
							<td style="text-align:left;"><input type="text" name="memo"  value="" class="join_input" style="width:400px;" /></td>
						</tr>
					</tbody>
				</table>
				<p style="text-align:center; margin-bottom:40px"><input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;
				<input type="image" src="../images/btn02.gif" /></a></p>
				</form>
				</c:when>
				</c:choose>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
