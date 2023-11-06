<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="shadow-box m-5">
		<div class="d-flex justify-content-center m-5">
			<%-- 키보드 Enter키로 로그인이 될 수 있도록 form 태그를 만들어준다.(submit 타입의 버튼이 동작됨) --%>
			
			<form id="loginForm" action="/user/sign-in" method="post">
				<%-- input-group-prepend: input box 앞에 ID 부분을 회색으로 붙인다. --%>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">ID</span>
					</div>
					<input type="text" class="form-control" name="loginId">
				</div>
				
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">PW</span>
					</div>
					<input type="password" class="form-control" name="password">
				</div>
				
				<%-- btn-block: 로그인 박스 영역에 버튼을 가득 채운다. --%>
				<input type="submit" class="btn btn-block btn-info" value="로그인">
				<a class="btn btn-block btn-dark" href="/user/sign_up_view">회원가입</a>
			</form>
		</div>
	</div>
</div>
<script>
$(document).ready(function() {
	// 로그인 서브밋
	$('#loginForm').submit(function(e) {
		e.preventDefault(); // submit 자동 수행 중단
		
		var loginId = $('input[name=loginId]').val().trim();
		if (loginId == '') {
			alert("아이디를 입력해주세요.");
			return;
		}
		
		var password = $('input[name=password]').val();
		if (password == '') {
			alert("비밀번호를 입력해주세요.");
			return;
		}
		
		// AJAX로 서브밋
		var url = $(this).attr("action");
		var data = $(this).serialize(); // form의 name 속성으로 data를 구성한다.
		
		$.post(url, data)
		.done(function(data) {
			if (data.result == "성공") {
				location.href="/timeline/timeline-view"; 
			} else {
				alert("로그인에 실패했습니다. 다시 시도해주세요.");
			}
		}); 
	});
});
</script>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="login-box">
		<h1 class="mb-3">로그인</h1>
		<form id="loginForm" action="/user/sign-in" method="post">
			<div class="input-group mb-3">
				<div class="input-froup-prepend">
					<span class="input-group-text">ID</span>
				</div>
				<input type="text" class="form-control" id="loginId" name="loginId">

			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">PW</span>
				</div>
				<input type="password" class="form-control" id="password"
					name="password">
			</div>
			<input type="submit" id="loginBtn" class="btn btn-block btn-success"value="로그인"> 
			<a class="btn btn-block btn-dark" href="/user/sign-up-view">회원가입</a>

		</form>
	</div>
</div>

<script>
$(document).ready(function(){
	$("#loginBtn").on("submit", function(e){
		e.preventDefault
		let loginId = $("#loginId").val().trim();
		let password = $("#password").val();
		
		if(loginId = ""){
			alert("아이디를 입력하세요");
			return false;
		}
		if(password = ""){
			alert("비밀번호를 입력하세요");
			return false;
		}
		//ajax
		let url = $(this).attr('action');
		console.log(url);
		let params = $(this).serilalize();
		console.log(params);
		$.post(url, params)// request에 대한 정보
		.done(function(data){//response의 대한 정의
			if(data.code == 200){//성공
				//성공시 글목록으로 이동
				location.href = "/post/post-list-view";
			}else{//로직상 실패
				alert(data.errorMessage);
			}
		});
	});
	})
});

</script> --%>