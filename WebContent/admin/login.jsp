<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Login</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet" href="../common/bootstrap-4.5.3/css/bootstrap-grid.css">
<script src="../common/jquery/jquery-3.5.1.min.js"></script>
</head>

<body class="bg-dark">
<script>
function loginNullCheck(){
	if($("#id").val()==""){
		alert("아이디를 입력해주세요");
		return;
	}
	if($("#pw").val()==""){
		alert("패스워드를 입력해주세요");
		return;
	}
	$("#loginFrm").submit();
}
</script>
<div class="container">
  <div class="card card-login mx-auto mt-5">
    <div class="card-header">Login</div>
    <div class="card-body">
      <form action="login.do" method="post" id="loginFrm">
        <div class="form-group">
          <div>
            <div>id</div>
            <input type="text" id="id" name="id" value="${cookie.COOKIE_ID}" class="form-control" placeholder="Id" required="required" autofocus="autofocus">
          </div>
        </div>
        <div>
          <div>
            <div>password</div>
            <input type="password" id="pw" name="pw" value="" class="form-control" placeholder="Password" required="required">
          </div>
        </div>
        <div class="form-group">
          <div class="checkbox">
            <label>
              <input type="checkbox" name="cookieId" value="Y">
              Remember Id
            </label>
          </div>
        </div>
        <a class="btn btn-primary btn-block" href="javascript:loginNullCheck();">Login</a>
      </form>
    </div>
  </div>
</div>

<!-- Bootstrap core JavaScript-->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

</body>
</html>