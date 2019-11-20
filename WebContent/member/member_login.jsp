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
			<div id="member">
				<form name="login" action="login_ok.jsp">
					<div id="inner">
						<img src="/instargram/img/instar_title.png">
					</div>
					<div id="inner">
						<div id="inner_text">
							<input type="text" name="id" placeholder="전화번호, 사용자 이름 또는 이메일">
						</div>
						<div id="inner_text">
							<input type="password" name="pwd" placeholder="비밀번호">
						</div>
					</div>
					<div id="inner">
						<input id="login_button" type="submit" value="로그인">
					</div>
					<div id="inner">
						<a href="member_join.jsp">비밀번호를 잊으셨나요?</a>
					</div>
				</form>
			</div>
<div id="login">
	<span>계정이 없으신가요? <a href="member_join.jsp">회원가입</a></span>
</div>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>