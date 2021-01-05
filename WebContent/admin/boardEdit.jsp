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

</head>
<style>
	th{text-align:center;}
</style>
<body id="page-top">

<script>
function editFunc(fm){
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
	var e = confirm("수정하시겠습니까?");
	if(e==true){
		return true
	}
	return false;
}
</script>

<%@include file="./include/top.jsp" %>
 
  <div id="wrapper"> 
    <!-- Sidebar -->
    <%@include file="./include/left_side.jsp" %>

    <div id="content-wrapper">

      <div class="container-fluid">
		<div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            </div>
          <div class="card-body">
            <div class="table-responsive">
             <form enctype="multipart/form-data" action="boardEdit.do" id="editFrm" 
              onsubmit="return editFunc(this);" method="post">
              <input type="hidden" name="num" value="${BBSDTO.num }"/>
              <input type="hidden" name="originalfile" value="${BBSDTO.attachedfile }" />
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
              	<colgroup>
					<col width="20%"/>
					<col width="*"/>
				</colgroup>
                <tbody>
                  <tr>
                    <th class="text-center" style="vertical-align:middle;">title</th>
                    <td><input type="text" class="form-control" name="title" value="${BBSDTO.title }"/></td>              
                  </tr>
                  <tr>
                  	<th class="text-center" style="vertical-align:middle;">content</th>
                    <td><textarea rows="10" class="form-control" name="content">${BBSDTO.content }</textarea></td>
                  </tr>
                  <c:choose>
      				<c:when test="${BBSDTO.boardtype=='file'||BOARD_TYPE=='photo'}">
                  <tr>
                    <th class="text-center" style="vertical-align:middle;">첨부파일</th>
					<td>
						<input type="file" class="form-control" name="attachedfile"/>
					</td>
                  </tr>
                  	</c:when>
                  	<c:when test="${BOARD_TYPE=='cal'}">
                  <tr>
                    <th class="text-center" style="vertical-align:middle;">일정</th>
					<td>
						<input type="date" name="date" name="date">
					</td>
                  </tr>
                  	</c:when>
                  </c:choose>
                </tbody>
              </table>
              <div style="text-align:right">
              <button type="submit" class="btn btn-danger">전송하기</button>
              </div>
              </form>
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