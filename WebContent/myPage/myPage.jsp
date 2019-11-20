<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
<link rel="stylesheet" type="text/css" href="/instargram/css/mainLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/myPageLayout.css?after">
<!-- <link rel="stylesheet" type="text/css" href="/instargram/css/myPageLayout_check.css?after"> -->
<style>
article{
	margin-top:80px;
}

#myPage_bar{
	text-align: center;
	border-top: 1px solid #E6E6E6;
}

#myPage_bar_tab{
	display: inline-block;
	margin-left:40px;
	margin-right:40px;
	padding-top: 25px;
	padding-bottom: 25px;
	border-top: 1px solid black;
}

#myPage_bar_tab img{
	width:15px;
} 
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/myPage/myProfile.jsp" %>

<%@include file="/footer.jsp" %>
</body>
</html>