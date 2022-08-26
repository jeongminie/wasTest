<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>밍그램 회원가입</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  	
  	<link rel="stylesheet" href="/css/style.css">
</head>
<body>

	<div id="wrap">
		<section class="content d-flex justify-content-center align-items-center">
			<div class="login-box p-4 mt-5">
				<div class="w-100">
					<div class="d-flex justify-content-center align-items-center mb-4">
						<img src="/image/logo.jpg">
					</div>
					<h5 class="text-secondary text-center font-weight-bold">친구들의 사진과 동영상을 보려면 <br> 가입하세요.</h5>
					<form id="signupForm">
						<input id="emailInput" type="text" class="form-control mt-3" placeholder="이메일 주소">
						<input id="nameInput" type="text" class="form-control mt-3" placeholder="성명">
						<div class="d-flex">
							<input id="userNameInput" type="text" class="form-control mt-3" placeholder="사용자 이름">
							<button type="button" class="btn btn-primary mt-3 ml-3" id="checkBtn">중복 확인</button>
						</div>
						<div><small class="text-danger d-none" id="duplicationName">중복된 사용자 이름 입니다.</small></div>
						<div><small class="text-success d-none" id="ableName">사용 가능한 사용자 이름 입니다.</small></div>
						<input type="password" id="passwordInput"  class="form-control mt-3" placeholder="패스워드">
						<input type="password" id="passwordConfirmInput" class="form-control mt-3" placeholder="패스워드 확인">
						<small id="errorPassword" class="text-danger d-none">비밀번호가 일치하지 않습니다.</small>
						<button id="signupBtn" type="submit" class="btn btn-primary btn-block mt-3">가입</button>
					</form>		
				</div>
			</div>
		</section>
		<section class="content d-flex justify-content-center align-items-center">	
			<div class="login-box p-4 mt-2">
				<div>계정이 있으신가요?&nbsp;&nbsp;&nbsp;<a href="/user/signIn_view">로그인</a></div>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var isUserNameCheck = false; //기본값은 통과가 안되도록 하는 조건 - 체크안됨
			var isDuplicateUserName = true; //중복됨
			
			$("#signupForm").on("submit", function(e){
				e.preventDefault();
	
				var name = $("#nameInput").val().trim();
				var userName = $("#userNameInput").val();
				var password = $("#passwordInput").val();
				var passwordConfirm = $("#passwordConfirmInput").val();
				var email = $("#emailInput").val().trim();
				
				if(email == null || email == "") {
					alert("이메일을 입력하세요");
					return false;
				}
				
				if(name == null || name == "") {
					alert("이름 입력하세요");
					return false ;
				}
				
				if(userName == null || userName == "") {
					alert("사용자 이름을 입력하세요");
					return false;
				}
				
				if(password != passwordConfirm) {
					$("#errorPassword").removeClass("d-none");
					return false;
				}
				
				if(isUserNameCheck == false) {
					alert("중복체크를 해주세요.");
					return;
				}
				
				if(isDuplicateUserName == true) {
					alert("아이디가 중복되었습니다.");
					return;
				}
				
				$.ajax({
					type:"post",
					url:"/user/sign_up",
					data:{"name":name, "userName":userName, "password":password, "email":email},
					success:function(data) {
						if(data.result == "success") {
							location.href="/user/signIn_view";
						} else {
							alert("회원가입 실패");
						}
					},
					error:function(e) {
						alert("회원가입 실패");
					}
					
				});
				
				return false;
				
			});
			
			$("#checkBtn").on("click", function(){
				var userName = $("#userNameInput").val();
				
				if(userName == null || userName == "") {
					alert("사용자 이름을 입력하세요");
					return false;
				}
				
				$.ajax({
					type:"get",
					url:"/user/is_duplicate_id",
					data:{"userName":userName},
				success:function(data) {
					isUserNameCheck = true; //체크 함
					
					if(data.duplication) { //true면 중복
						isDuplicateUserName = true;
						$("#duplicationName").removeClass("d-none");
						$("#ableName").addClass("d-none");
					} else {
						isDuplicateUserName = false;
						$("#duplicationName").addClass("d-none");
						$("#ableName").removeClass("d-none");
					}
					
				},
				error:function() {
					alert("중복 조회 실패");
				}
				
				});
				
			});
			
	});
	</script>

</body>
</html>