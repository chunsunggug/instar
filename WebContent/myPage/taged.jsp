<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
<link rel="stylesheet" type="text/css" href="/instargram/css/font_color.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/mainLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/myPageLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/history_modalLayout.css?after">
<link rel="stylesheet" href="/instargram/css/fPage.css?after">
<style>
a{
	text-decoration: none;
}

#myPage_bar_content{
	opacity: 0.5;
}

#myPage_bar_saved{
	opacity: 0.5;
}

#myPage_bar_taged{
	border-top: 0.5px solid #6E6E6E;
}

#container{
	width: 680px;
	height: 330px;
}
#container div{
	display: inline-block;
	float: left;
	width: 330px;
	height: 330px;
}

#content_img img{
	width:330px;
}
#content_text{
	text-align: center;
}

</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/myPage/myProfile.jsp" %>
<div id="list">
				<img src="../img/sampleImg.jpg">
			</div>
	<div id="content_text">
		<div id=wrap_text>
			<p style="font-weight: bold; font-size: 15px;">소중한 순간을 포착하여 공유해보세요.</p>
			<p style="font-size: 12px;">앱을 다운로드하고 첫 사진이나 동영상을 공유해보세요.</p>
		</div>
	</div>
<%@include file="/footer.jsp" %>
</body>
</html>