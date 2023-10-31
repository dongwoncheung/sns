<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

<!-- 내가 만든 스타일시트 -->
<!-- <link rel="stylesheet" type="text/css" href="/static/css/style.css"> -->
</head>
<body>
	<div class="container">
		<h1>로그인</h1>
		 
	<form method="post" id="signUp">
			<!-- 아이디 입력하는 부분 -->
			<div class="d-flex icon-cell" id="id_cell">
				<input type="text" id="id" name="id" placeholder="Username" class="input" value="" maxlength="20" autocapitalize="off">
			</div>
			<div class="input_row" id="pw_line">
				<div>
				 	<input type="text" id="id" name="id" placeholder="Password" class="input mt-2" value="" maxlength="20" autocapitalize="off">
				</div>
				
			</div>
				
				</span>
			</div>
		</form>
	</div>
</body>
</html>