<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
    <!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

<!-- 내가 만든 스타일시트 -->
<link rel="stylesheet" type="text/css" href="/static/css/style.css">
</head>
<body>
				<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
				<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
				<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
			</div>
			
			<span class="sign-up-subject">Password</span>
			<div class="m-3">
				<input type="password" name="password" class="form-control col-6" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Confirm password</span>
			<div class="m-3">
				<input type="password" name="confirmPassword" class="form-control col-6" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Name</span>
			<div class="m-3">
				<input type="text" name="name" class="form-control col-6" placeholder="이름을 입력하세요">
			</div>

			<span class="sign-up-subject">이메일</span>
			<div class="m-3">
				<input type="text" name="email" class="form-control col-6" placeholder="이메일을 입력하세요">
			</div>
			
			<br>
			<div class="d-flex justify-content-center m-3">
				<button type="submit" id="signUpBtn" class="btn btn-info">가입하기</button>
			</div>
		</form>
	</div>
<script>
$(document).ready(function() {
	// 중복확인 버튼 클릭
	$("#loginIdCheckBtn").on('click', function() {
		//alert("클릭");
		
		// 경고 문구 초기화
		$('#idCheckLength').addClass('d-none');
		$('#idCheckDuplicated').addClass('d-none');
		$('#idCheckOk').addClass('d-none');
		
		let loginId = $('#loginId').val().trim();
		if (loginId.length < 4) {
			$('#idCheckLength').removeClass('d-none');
			return;
		}
		
		// AJAX 통신 - 중복확인
		$.ajax({
			// request
			url:"/user/is-duplicated-id"
			, data: {"loginId":loginId}
			
			// response
			, success: function(data) {
				if (data.isDuplicatedId) {
					// 중복
					$('#idCheckDuplicated').removeClass('d-none');
				} else {
					// 중복 아님 => 사용 가능
					$('#idCheckOk').removeClass('d-none');
				}
			}
			, error: function(request, status, error) {
				alert("중복확인에 실패했습니다.");
			}
		});
	});
	
	// 회원가입
	$('#signUpForm').on('submit', function(e) {
		e.preventDefault(); // 서브밋 기능 중단
		
		// validation
		let loginId = $('input[name=loginId]').val().trim();
		let password = $("input[name=password]").val();
		let confirmPassword = $('input[name=confirmPassword]').val();
		let name = $('input[name=name]').val().trim();
		let email = $('input[name=email]').val().trim();
		
		if (!loginId) {
			alert("아이디를 입력하세요");
			return false;
		}
		if (!password || !confirmPassword) {
			alert("비밀번호를 입력하세요");
			return false;
		}
		if (password != confirmPassword) {
			alert("비밀번호가 일치하지 않습니다");
			return false;
		}
		if (!name) {
			alert("이름을 입력하세요");
			return false;
		}
		if (!email) {
			alert("이메일을 입력하세요");
			return false;
		}
		// 아이디 중복확인 완료 됐는지 확인 -> idCheckOk d-none이 있으면 얼럿을 띄워야함
		if ($('#idCheckOk').hasClass('d-none')) {
			alert("아이디 중복확인을 다시 해주세요");
			return false;
		}
		
		let url = $(this).attr('action');
		console.log(url);
		let params = $(this).serialize(); // 폼태그에 있는 name 속성-값들로 파라미터 구성
		console.log(params);
		
		$.post(url, params)   // request
		.done(function(data) {
			// response
			if (data.code == 200) {
				alert("가입을 환영합니다! 로그인을 해주세요.");
				location.href = "/user/sign-in-view"; // 로그인 화면으로 이동
			} else {
				// 로직 실패
				alert(data.errorMessage);
			}
		});
	});
});
</script>
</div>

</body>
</html>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

<!-- 내가 만든 스타일시트 -->
<!-- <link rel="stylesheet" type="text/css" href="/static/css/style.css"> -->
<title>회원가입</title>
</head>
<body>
<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<h1 class="m-4 font-weight-bold">회원가입</h1>
		<form id="signUpForm" method="post" action="">
			<span class="sign-up-subject">ID</span>
			인풋 옆에 중복확인 버튼을 옆에 붙이기 위해 div 만들고 d-flex
			<div class="d-flex ml-3 mt-3">
				<input type="text" id="loginId" name="loginId" class="form-control col-8" placeholder="ID를 입력해주세요">
				<button type="button" id="loginIdCheckBtn" class="btn btn-success">중복확인</button>
			</div>
			
			아이디 체크 결과
			<div class="ml-4 mb-3">
				<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
				<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
				<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
			</div>
			
			<span class="sign-up-subject">Password</span>
			<div class="m-3">
				<input type="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Confirm password</span>
			<div class="m-3">
				<input type="password" name="confirmPassword" class="form-control" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Name</span>
			<div class="m-3">
				<input type="text" name="name" class="form-control" placeholder="이름을 입력하세요">
			</div>

			<span class="sign-up-subject">이메일</span>
			<div class="m-3">
				<input type="text" name="email" class="form-control" placeholder="이메일을 입력하세요">
			</div>
			
			<br>
			<div class="d-flex justify-content-center m-3">
				<button type="submit" id="signUpBtn" class="btn btn-info">가입하기</button>
			</div>
		</form>
	</div>
</div>
<!-- 	<div class="container sign-up-box">
		<h1>회원가입</h1>
		<form method="post" id="signUpForm" action="">
		<div class="subject-text my-2">ID</div>
                    <input type="text" id="id" class="form-control" placeholder="ID를 입력하세요">
                    <input type="submit" id="duplicatedId" class="btn btn-info ml-3" value="중복확인"> 
                    <small id="idLengthWarn" class="text-info d-none"></small>

                    <div class="subject-text my-2">password</div>
                    <input id="password" type="password" id="password" class="form-control">

                    <div class="subject-text my-2">confirm password</div>
                    <input  id="confirmPassword" type="password" id="confirmPassword" class="form-control">

                    <div class="subject-text my-2">이름</div>
                    <input  id="name" type="text" id="name" class="form-control" placeholder="이름을 입력하세요">

                    <div class="subject-text my-2">이메일</div>
                    <input  id="email" type="text" class="form-control" placeholder="이메일을 입력하세요">
		
			<button type="submit" id="signUp" class="btn btn-primary float-right">회원가입</button>
		</form>
	</div> -->

</body>
<script>
	$(document).ready(function(){
		$("#loginIdCheckBtn").on("click", function(){
			//alert("클릭");
			$("#idCheckLength").addClass("d-none");
			$("#idCheckDuplicated").addClass("d-none");
			$("#idCheckOk").addClass("d-none");
			let loginId = $("#loginId").val;
			if(loginId.length < 4){
				$("#idCheckLength").removeClass('d-none');
				return;
			}
			//ajax - 중복확인
			$.ajax({
				//request
				
				url:"/user/sign-in"
				, data:{"loginId" : loginId}
				
				//response
				,success:function(data){
					//{"code":200, "isDuplicated":true} 중복이면 true
					if(data.isDuplicated){//중복
						$("#idCheckDuplicated").removeClass("d-none");
					}else{//중복 아님 사용 가능하다는 의미
						$("#idCheckOk").removeClass("d-none");
					}
				}
				,error:function(request, status, error){
					alert("중복확인에 실패했습니다");
				}
			});
			//회원가입 submit(form태그 id를 사용)
			$("#signUpForm").on("submit", function(e){
				e.preventDefault();//submit기능을 막아준다
				
				//alert("클릭");
				//validation
				let loginId = $("#loginId").val;
				let password = $("#password").val();
				let confirmPassword = $("#confirmPassword").val();
				let name = $("#name").val();
				let email = $("#email").val();
				//아이디를 입력하세요 않나오니 다시 보기
				
				if (loginId == '') {
					alert("아이디를 입력하세요");//submit으로 했으니 
					return false;
				}
				if(!password|| !confirmPassword){
					alert("비밀번호를 입력하세요");
					return false;
				}
				
				if(password != confirmPassword){
					alert("비밀번호가 일치하지 않습니다");
					return false;
				}
				if(!name){
					alert("이름을 입력하세요");
					return false;
				}
				if(!email){
					alert("이메일을 입력하세요");
					return false;
				}
				
				//중복확인후 사용가능한지 확인하기 =>idCheckOk가 d-none있을때 alert을 띄운다
				if($("#idCheckOk").hasClass('d-none')){
					alert("아이디 중복확인을 다시해주세요.");
					return false;
				}
				//2) ajax - 응답값jason
				let url = $(this).attr("action"); // form태그의 action주소 가 나왔다
				//alert(url);
				let params = $(this).serialize();// form태그에 있는 name 속성과 값으로 파라미터 구성
				console.log(params);
				
				//ajax의 다른 방식 post의 method을 이용해서 해보기
				$.post(url, params) // request
				.done(function(data){// response
					//{"code":200, "result": "성공"}
				if(data.code == 200){//성공
					alert("가입을 환영합니다 로그인을 해주세요");
					location.href = "/user/sign-in-view";//로그인 화면으로 이동하는 주소를 입력을한다
				}else{//로직 실패
					alert(data.errorMessage);
				}
				});
		})
	});
</script>
</html>
 --%>