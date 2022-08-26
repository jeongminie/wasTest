<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>    
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  	
  	 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
  	<link rel="stylesheet" href="/css/style.css">
<title>타임라인</title>
</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />	
			<section>
				<div class="d-flex justify-content-center align-items-center p-4">
				
					<div class="text-box rounded">
						<div class="userNameInfo mt-2 mb-2">
							<i class="bi bi-person-circle mr-2"></i>
							<c:if test="${not empty userName}">
								${userName }
							</c:if>
						</div>
						<div class="d-flex justify-content-center align-items-center">
							<textarea class="form-control col-10 border-0 non-resize" rows="5" placeholder="내용을 입력해주세요 ..." id="contentInput"></textarea>
						</div>	
						<div class="d-flex justify-content-between align-items-center m-2">
							<input type="file" accept="image/*" id="fileInput" class="col-10 mb-2 d-none">
							<a href="#" id="imageUploadBtn"><i class="bi bi-card-image mr-2 text-dark"></i><span class="text-dark">파일 첨부하기</span></a>
							<button type="button" class="btn btn-info btn-sm mb-2" id="saveBtn">업로드</button>
						</div>
					</div>
				</div>
				
				<c:forEach var="postWithComments" items="${post }" varStatus="status">
					<div class="d-flex justify-content-center align-items-center p-4">
						<div class="timeLine rounded">
							<div class="userNameInfo mt-2 mb-2 d-flex justify-content-between">
								<div>
									<i class="bi bi-person-circle mr-2"></i>
									<span>${postWithComments.post.userName }</span>
								</div>

								<!-- 글의 userId와 세션의 userId가 일치하면 더보기 버튼 노출 세션에 있는거 불러올땐 그냥 쓰면됨-->
								<c:if test="${postWithComments.post.userId eq userId}">
									<div class="more-icon" >
										<a href="#" class="text-dark moreBtn" data-toggle="modal" data-target="#deleteModal" data-post-id="${postWithComments.post.id }">
											<i class="bi bi-three-dots mr-2"></i>
										</a>
									</div>
								</c:if>
							</div>
							
							<div>
								<c:if test="${not empty postWithComments.post.imagePath }">
									<img src="${postWithComments.post.imagePath }" class="imagePath-size w-100 imageClick" data-post-id="${ postWithComments.post.id }">
								</c:if>
							</div>
							<div class="mt-2">
								<c:choose>
									<c:when test="${postWithComments.existLike eq false}">
										<a href="#" class="likeBtn" data-post-id="${postWithComments.post.id }">
											<i id="heartIcon-${postWithComments.post.id }" class="bi bi-heart text-dark ml-2"></i>
										</a>	
									</c:when>
									<c:otherwise>
										<a href="#" class="likeBtn" data-post-id="${postWithComments.post.id }">
											<i id="heartIcon-${postWithComments.post.id }" class="heartIcon bi bi-heart-fill ml-2 text-danger"></i>
										</a>	
									</c:otherwise>
								</c:choose>
								<i class="bi bi-chat ml-2"></i>
								<br>
									<c:choose>
										<c:when test="${postWithComments.likesCount > 1 }">
											<div class="mt-1 ml-2"> <b>${postWithComments.likeUser.userName }</b>님 <b>외 ${postWithComments.likesCount -1}명</b>이 좋아합니다</div>
										</c:when>
										<c:when test="${postWithComments.likesCount eq 1}">
											<div class="mt-1 ml-2"> <b>${postWithComments.likeUser.userName }</b>님이 좋아합니다</div>
										</c:when>
									</c:choose>	
							</div>
							
							<div class="ml-2">
								<b class="mr-2">${postWithComments.post.userName }</b>
								${postWithComments.post.content }
							</div>
							<div>
								<div>
									<div class="ml-2 text-secondary">댓글 보기</div>
									<c:forEach var="comment" items="${ postWithComments.commentList}">
										<div class="ml-2">
											<b>${comment.userName }</b> ${comment.comment }
										</div>
									</c:forEach>						
								</div>
								<div class="comment-box w-100 d-flex justify-content-center align-items-center" >
									<input type="text" class="form-control col-10 mt-2" id="commentInput-${postWithComments.post.id }" style="border:none" placeholder="댓글 달기...">
									<button class="btn btn-link btn-sm commentBtn" data-post-id="${postWithComments.post.id }">게시</button> 
								</div>
							</div>
						</div>			
					</div>
				</c:forEach>
			</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
	
	<!-- 모달의 a태그에 data-post-id의 값을 더보기 클릭시 마다 바꿔준다. -->
	<!-- 모달의 a태그의 클릭 이벤트를 만들고 그안에서 post-id로 삭제를 진행-->
	
	<!-- Modal -->
	<!-- 삭제 될 대상의 정보를 가지고 있어야함  -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-body text-center">
	        <a href="#" id="deleteBtn">삭제 하기</a> <!-- 객체화 -->
	      </div>
	    </div>
	  </div>
	</div>

	
	<script>
	//함수 바꾸는것은 밖에서
	function processLike(postId) { //변수 필요 없음
		$.ajax({
			type:"get",
			url:"/post/like",
			data:{"postId":postId},
			success:function(data){
				if(data.like) {
					$("#heartIcon-" + postId).removeClass("bi-heart");
					$("#heartIcon-" + postId).addClass("bi-heart-fill");
					
					$("#heartIcon-" + postId).removeClass("text-dark");
					$("#heartIcon-" + postId).addClass("text-danger");
				} else { //anlike
					$("#heartIcon-" + postId).addClass("bi-heart");
					$("#heartIcon-" + postId).removeClass("bi-heart-fill");
					
					$("#heartIcon-" + postId).addClass("text-dark");
					$("#heartIcon-" + postId).removeClass("text-danger");
				}
				location.reload();
			},
			error:function(e) {
				alert("error");
			}
				
		});	
	}

		$(document).ready(function(){
			$("#saveBtn").on("click", function(){
				var content = $("#contentInput").val().trim();
				
				if(content == null || content == "") {
					alert("내용을 입력하세요");
					return ;
				}
				
				if($("#fileInput")[0].files.length ==0) {
					alert("파일을 추가하세요");
					return ;
				}
				
				var formData = new FormData();
				formData.append("content", content);
				formData.append("file", $("#fileInput")[0].files[0]);
				
				
				$.ajax({
					enctype:"multipart/form-data",
					type:"post",
					url:"/post/create",
					processData:false,
					contentType:false,
					data:formData,
					success:function(data){
						if(data.result == "success") {
							alert("업로드 성공");
							 location.href="/post/create_view";
						} else {
							alert("업로드 실패");
						}
					},
					error:function(e) {
						alert("error");
					}
				});
				
			});
			
			$("#imageUploadBtn").on("click", function(){
				$("#fileInput").click();
			});
			
			$(".commentBtn").on("click", function(){
				//           버튼에 대한 정보를 가져옴 
				var postId = $(this).data("post-id");
				var comment = $("#commentInput-" + postId).val().trim();
				
				if(comment == null || comment == "") {
					alert("댓글을 입력하세요");
					return ;
				}
				
				$.ajax({
					type:"post",
					url:"/post/comment/create",
					data:{"postId":postId, "comment":comment},
					success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("댓글 작성 실패");
						}
					},
					error:function(e) {
						alert("error");
					}	
				});
			});
			
			$(".likeBtn").on("click", function(e){
				e.preventDefault();
				var postId = $(this).data("post-id");
				//a태그 기본 기능이 스크롤을 맨위로 이동시킴 이 기능을 삭제		
				
				processLike(postId);
				
			});
			
			$("#logoClick").on("click", function(){
				location.reload();
			});
			
			$("#userClick").on("click", function(){
				$(".userName_dropbox").removeClass("d-none");
				
			});
			
			$(".imageClick").on("dblclick", function(){
				var postId = $(this).data("post-id");
				processLike(postId);
					
			});
			
			$(".moreBtn").on("click", function(){
				//postId를 모델에 삭제버튼에 주입한다
				var postId = $(this).data("post-id");
				//객체 가져옴 데이타 주입 data-post-id  주입
				$("#deleteBtn").data("post-id", postId);
				
			});
			
			$("#deleteBtn").on("click", function(e){
				e.preventDefault();
				var postId = $(this).data("post-id");

				$.ajax({
					type:"get",
					url:"/post/delete",
					/* ""안에 있는게 중요! 여기는 위에 var postId랑 동일 */
					data:{"postId":postId}, 
					success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("실패");
						}
					},
					error:function(e) {
						alert("error");
					}	
					
				});
				
			});
		});

	
	
	</script>
	
</body>
</html>