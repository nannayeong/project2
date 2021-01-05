
<%@page import="model.MemberDTO"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
	if(request.getParameter("agreement")==null||!request.getParameter("agreement").equals("Y")){
		out.println("<script>alert('약관에 동의해주세요'); location.href='join01.jsp';</script>");
		out.flush();
	}

	if(request.getParameter("id")!=null){
	
		MemberDAO memberDAO = new MemberDAO();
		MemberDTO memberDTO = new MemberDTO();
		
		memberDTO.setId(request.getParameter("id"));
		memberDTO.setPw(request.getParameter("pw"));
		memberDTO.setName(request.getParameter("name"));
		memberDTO.setPhone(request.getParameter("phone"));
		memberDTO.setAddress(request.getParameter("address"));
		memberDTO.setEmail(request.getParameter("email"));
		
		int result = memberDAO.join(memberDTO);
		
		memberDAO.close();
		
		if(result==1){
			out.println("<script>alert('회원가입 완료'); location.href='/Project2/main/main.do';</script>");
			out.flush();
		}
		else{
			out.println("<script>alert('회원가입 실패'); location.href='/Project2/member/join.jsp';</script>");
		}
	}
%>
 <body>
 <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function DaumPostcode() {
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
                    document.getElementById("addr2").value = extraAddr;
                
                } else {
                    document.getElementById("addr2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip1').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addr1").focus();
            }
        }).open();
    }
</script>
 <script>
 	function hiddenFunc(){
 		document.getElementById("hidId").value="";
 	}
 	function id_check_person(){
 		var id = document.getElementById("id").value;
 		var eng = 0;
 		var num = 0;
 		
 		if(id==null||id==""){
 			alert("중복확인할 아이디를 입력해주세요");
 			document.getElementById("id").focus();
 			return;
 		}
 		if(id.length<4||id.length>12){
 			alert("아이디는 4~12자 이내로 입력해주세요");
 			document.getElementById("id").focus();
 			return;
 		}
 		for(var i=0;i<id.length;i++){
 			if(id.charCodeAt(i)>47&&id.charCodeAt(i)<58){
 				num++;
 			}
 			else if(id.charCodeAt(i)>64&&id.charCodeAt(id)<91||id.charCodeAt(i)>96&&id.charCodeAt(i)<123){
 				eng++;
 			}
 		}
 		if(num+eng!=id.length||num==0||eng==0){
				alert("아이디는 영문과 숫자만을 각각 하나이상 조합하여 입력해주세요.");
				document.getElementById("id").focus();
				return;
		}
 		
 		window.open("idCheck.jsp?id="+id, "아이디 중복체크", "width = 500, height = 500, top = 100, left = 200");
 	}
 	function submitFunc(){
 		var pw = document.getElementById("pw").value;
 		var id = document.getElementById("hidId").value;
 		var name = document.getElementById("name").value;
 		var email1 = document.getElementById("email1").value;
 		var email2 = document.getElementById("email2").value;
 		var eng = 0;
 		var num = 0;
 		
 		if(name==""){
 			alert("이름을 입력해주세요");
 			document.getElementById("name").focus();
 			return;
 		}
 		if(id==null||id==""){
 			alert("아이디 중복확인을 해주세요");
 			document.getElementById("id").focus();
 			return;
 		}
 		if(pw!=document.getElementById("pw2").value){
 			alert("비밀번호 확인이 일치하지 않습니다");
 			document.getElementById("pw").focus();
 			return;
 		}
 		if(pw.length<4||pw.length>12){
 			alert("비밀번호는 4~12자 이내로 입력해주세요");
 			document.getElementById("pw").focus();
 			return;
 		}
 		for(var i=0;i<pw.length;i++){
 			if(pw.charCodeAt(i)>47&&pw.charCodeAt(i)<58){
 				num++;
 			}
 			else if(pw.charCodeAt(i)>64&&pw.charCodeAt(id)<91||pw.charCodeAt(i)>96&&pw.charCodeAt(i)<123){
 				eng++;
 			}
 		}
 		if(num+eng!=pw.length||num==0||eng==0){
				alert("비밀번호는 영문과 숫자만을 각각 하나이상 조합하여 입력해주세요.");
				document.getElementById("pw").focus();
				return;
		}
 		if(email1==null||email1==""||email2==null||email1==""){
 			alert("이메일을 입력해주세요");
 		}
 		
 		location.href="join02.jsp?id="+id+"&pw="+pw+"&name="+name+"&email="+email1+"@"+email2;
 	}
 	function email_input(){
 		if($("#last_email_check2 option:selected").val()==1){
 			$("#email2").attr("readonly", false);
 		}
 		else if($("#last_email_check2 option:selected").val()==""){
 			document.getElementById("email2").value = "";
 		}
 		else{
 			document.getElementById("email2").value = $("#last_email_check2 option:selected").text();
 		}
 	}
 </script>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />
		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td>
							<input type="text" id="name" name="name" value="" class="join_input"/>
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" name="id" id="id"  value="" class="join_input" onkeydown="hiddenFunc();"/>&nbsp;
						<input type="hidden" id="hidId" value=""/>
						<a onclick="id_check_person();" style="cursor:hand;">
							<img src="../images/btn_idcheck.gif" alt="중복확인"/>
						</a>&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" id="pw" name="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" id="pw2" name="pass2" value="" class="join_input" /></td>
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
 
					<input type="text" id="email1" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
					<input type="text" id="email2" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
					<select name="last_email_check2" onChange="email_input();" class="pass" id="last_email_check2" >
						<option selected="" value="">선택해주세요</option>
						<option value="1" >직접입력</option>
						<option value="dreamwiz.com" >dreamwiz.com</option>
						<option value="empal.com" >empal.com</option>
						<option value="empas.com" >empas.com</option>
						<option value="freechal.com" >freechal.com</option>
						<option value="hanafos.com" >hanafos.com</option>
						<option value="hanmail.net" >hanmail.net</option>
						<option value="hotmail.com" >hotmail.com</option>
						<option value="intizen.com" >intizen.com</option>
						<option value="korea.com" >korea.com</option>
						<option value="kornet.net" >kornet.net</option>
						<option value="msn.co.kr" >msn.co.kr</option>
						<option value="nate.com" >nate.com</option>
						<option value="naver.com" >naver.com</option>
						<option value="netian.com" >netian.com</option>
						<option value="orgio.co.kr" >orgio.co.kr</option>
						<option value="paran.com" >paran.com</option>
						<option value="sayclub.com" >sayclub.com</option>
						<option value="yahoo.co.kr" >yahoo.co.kr</option>
						<option value="yahoo.com" >yahoo.com</option>
					</select>
	 
						<input type="checkbox" name="open_email" value="1">
						<span>이메일 수신동의</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" id="zip1" name="zip1" value=""  class="join_input" style="width:50px;" readonly/>&nbsp;-&nbsp;
						<a href="javascript:;" title="새 창으로 열림" onclick="DaumPostcode();" onkeypress="">[우편번호검색]</a>
						<br/>
						
						<input type="text" id="addr1" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" id="addr2" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
					</tr>
				</table>

				<p style="text-align:center; margin-bottom:20px"><a href="javascript:submitFunc();"><img src="../images/btn01.gif" /></a>
				&nbsp;&nbsp;<a href="/Project2/main/main.do"><img src="../images/btn02.gif" /></a></p>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
