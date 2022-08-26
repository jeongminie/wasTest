<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>밍그램 로그인</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  	
  	<link rel="stylesheet" href="/css/style.css">
</head>
<body>
	<div id="wrap">
			<c:if test="${not empty userName }">
				<div class="d-flex justify-content-end">${userName }님&nbsp;&nbsp; <a href="/user/sign_out">로그아웃</a> </div>
			</c:if>

		<section class="content d-flex justify-content-center align-items-center">	
			<div class="login-box p-4 mt-5">
				<div class="w-100">
					<div class="d-flex justify-content-center align-items-center mb-4">
						<img src="/image/logo.jpg">
					</div>
					<form id="loginForm">
						<input id="userNameInput" type="text" class="form-control mt-3" placeholder="사용자이름">
						<input id="passwordInput" type="password" class="form-control mt-3" placeholder="패스워드">
						<button id="loginBtn" type="submit" class="btn btn-primary btn-block mt-3">로그인</button>
						<div class="d-flex justify-content-center align-items-center mt-4">
							<hr class="mr-4 col-3">또는<hr class="ml-4 col-3">
						</div>
						<small class="d-flex justify-content-center align-items-center mt-2">비밀번호를 잊으셨나요?</small>
					</form>
				</div>
			</div>
		</section>
		<section class="content d-flex justify-content-center align-items-center">	
			<div class="login-box p-4 mt-2">
				<div class="text-center w-100" >계정이 없으신가요?&nbsp;&nbsp;&nbsp;<a href="/user/signUp_view">회원가입</a></div>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div>
	
	<script>
	

		$(document).ready(function(){
			$("#loginForm").on("submit", function(e){
				
				e.preventDefault();
				
				var userName = $("#userNameInput").val();
				var password = $("#passwordInput").val();
				
				if(userName == null || userName == ""){
					alert("사용자이름을 입력해주세요");
					return;
				}
				
				if(password == null || password == ""){
					 alert("비멀번호를 입력해주세요");
					 return;
				}
				
				$.ajax({
					type:"post",
					url:"/user/sign_in",
					data:{"userName":userName, "password":password},
					success:function(data){
						if(data.result == "success"){
							location.href="/post/create_view";
						} else {
							alert("아이디 비밀번호를 확인하세요")
						}
					},
					error:function(e){
						alert("로그인 실패");
					}
				});
			});
		});
	
	</script>

</body>
</html>