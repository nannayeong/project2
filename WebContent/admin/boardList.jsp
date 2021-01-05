<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<meta charset="UTF-8">

<title>suamil_admin_main</title>

<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
<link href="css/sb-admin.css" rel="stylesheet"/>
<style>
	th{text-align:center;}
</style>
</head>
<script>
function deleteFunc(num){
	var d = confirm("삭제하시겠습니까?");
	if(d==true){
		location.href="boardDelete.do?num="+num;
	}
}
</script>
<body id="page-top">
<%@include file="./include/top.jsp" %>
 
  <div id="wrapper"> 
    <!-- Sidebar -->
    <%@include file="./include/left_side.jsp" %>

    <div id="content-wrapper">

      <div class="container-fluid">
		<div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"><span>boardList</span></i>
            <form action="boardList.do">
           	<select name="boardName" onchange="this.form.submit();">
           		<option value="free" ${BOARD_NAME=="free"?"selected":"" }>free</option>
           		<option value="notice" ${BOARD_NAME=="notice"?"selected":"" }>notice</option>
           		<option value="photo" ${BOARD_NAME=="photo"?"selected":"" }>photo</option>
           		<option value="info" ${BOARD_NAME=="info"?"selected":"" }>info</option>
           		<option value="staff" ${BOARD_NAME=="staff"?"selected":"" }>staff</option>
           		<option value="guardian" ${BOARD_NAME=="guardian"?"selected":"" }>guardian</option>
           		<option value="cal" ${BOARD_NAME=="cal"?"selected":"" }>cal</option>
           	</select>
           	<span>
              	<button type="button" class="btn btn-info" 
							onclick="location.href='boardWrite.do?boardName=${BOARD_NAME}'">글쓰기</button>
			</span>
           	</form>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                    <th>num</th>
                    <th>title</th>
                    <th>postdate</th>
                    <th>id</th>
                    <th>visitcount</th>
                    <th>attachedfile</th>
                    <th>수정</th>
                    <th>삭제</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>num</th>
                    <th>title</th>
                    <th>postdate</th>
                    <th>id</th>
                    <th>visitcount</th>
                    <th>attachedfile</th>
                    <th>수정</th>
                    <th>삭제</th>
                  </tr>
                </tfoot>
                 <tbody>
                <c:choose>
                	<c:when test="${empty BBSDTO_LIST}">
                		<tr>
                			<th colspan="7">검색결과없음</th>
                		</tr>
                	</c:when>
                	<c:otherwise>
                		<c:forEach items="${BBSDTO_LIST}" var="dto" varStatus="status">
                		<tr>
	                	    <th>${BBSDTO_LIST_COUNT - status.index}</th>
		                    <th><a href="boardView.do?num=${dto.num }">${dto.title }</a></th>
		                    <th>${dto.postdate}</th>
		                    <th>${dto.id}</th>
		                    <th>${dto.visitcount}</th>
		                    <th>
		                    <c:if test="${not empty dto.attachedfile }">
								${dto.attachedfile }
								<a href="./download?filename=${dto.attachedfile }">
									[다운로드]
								</a>		
							</c:if>	
							</th>
		                    <th>
		                    	<input type="button" class="btn btn-primary" value="수정" onclick="location.href='boardEdit.do?num=${dto.num}'"/>
		                    </th>
		                    <th>
		                    	<input type="button" class="btn btn-success" value="삭제" onclick="deleteFunc('${dto.num}');"/>
		                    </th>
		                 </tr>
	                    </c:forEach>
                	</c:otherwise>
                </c:choose>
                </tbody>
              </table>              
            </div>
          </div>
        </div>
      </div>
      <!-- /.container-fluid -->

      <!-- Sticky Footer -->
    <%@include file="./include/bottom.jsp" %>
    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">로그아웃하시겠습니까?</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.jsp?logout=Y">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <script src="vendor/chart.js/Chart.min.js"></script>
  <script src="vendor/datatables/jquery.dataTables.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>

  <!-- Demo scripts for this page-->
  <script src="js/demo/datatables-demo.js"></script>
  <script src="js/demo/chart-area-demo.js"></script>

</body>
</html>