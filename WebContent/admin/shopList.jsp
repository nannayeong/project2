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
<body id="page-top">
<%@include file="./include/top.jsp" %>
 
  <div id="wrapper"> 
    <!-- Sidebar -->
    <%@include file="./include/left_side.jsp" %>

    <div id="content-wrapper">

      <div class="container-fluid">
		<div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"><span>shopList</span></i>
            <input type="button" value="상품등록" onclick="location.href='./shopWrite.do'"/>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <thead>
                  <tr>
                  	<th>상품번호</th>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>적립금</th>
                    <th>상품사진</th>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <th>상품번호</th>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>적립금</th>
                    <th>상품사진</th>
                  </tr>
                </tfoot>
                 <tbody>
                <c:choose>
                	<c:when test="${empty DTOLIST}">
                		<tr>
                			<th colspan="6">검색결과없음</th>
                		</tr>
                	</c:when>
                	<c:otherwise>
                		<c:forEach items="${DTOLIST}" var="dto" varStatus="status">
                		<tr>
	                	    <th>${dto.num}</th>
		                    <th><a href="shopView.do?num=${dto.num }">${dto.name}</a></th>
		                    <th>${dto.price}</th>
		                    <th>${dto.point}</th>
		                    <th><img src="/project2/upload/${dto.img }" 
		                    alt="첨부사진" style="width: 100px; height:100px"/></th>
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