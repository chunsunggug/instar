<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/instargram/css/mainLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/member_joinLayout.css?after">
</head>
<body>
<section>
<article>
<img src="/instargram/img/join/phone.png">
</article>
<article>
			<div id="member">
				<form name="join" action="join_ok.jsp">
					<div id="inner">
						<img src="/instargram/img/instar_title.png">
					</div>
					<div id="inner">
						<p id="top"><span style="font-weight: bold;">친구들의 사진과 동영상을 보려면 가입하세요.</span></p>
					</div>
					<div id="inner">
						<div id="inner_text">
							<input type="text" name="id" placeholder="휴대폰 번호 또는 이메일 주소">
						</div>
						<div id="inner_text">
							<input type="text" name="name" placeholder="성명">
						</div>
						<div id="inner_text">
							<input type="text" name="nick" placeholder="사용자 이름">
						</div>
						<div id="inner_text">
							<input type="password" name="pwd" placeholder="비밀번호">
						</div>
					</div>
					<div id="inner">
						<input id="join_button" type="submit" value="가입">
					</div>
					<div id="inner">
						<p id="bottom">가입하면 instargram의 <span style="font-weight: bold;">약관, 데이터 정책</span> 및 <span style="font-weight: bold;">쿠키 정책</span>에 동의하게 됩니다.</p>
					</div>
				</form>
			</div>
<div id="login">
	<span>계정이 있으신가요? <a href="member_login.jsp">로그인</a></span>
</div>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>