<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="member.MemberDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/instargram/css/mainLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/history_modalLayout.css?after">
</head>
<style>
#myImfo{
	margin: 20px auto;
}
tr{
	height: 40px;
}

td:first-child {
	text-align: right;
	font-weight: bolder;
}
td:last-child {
	text-align: left;
}
td input{
height: 25px;
width: 300px;
font-size: 18px;
}
#profile_img{
	width: 150px;
	color: blue;
	border: none;
	background-color: white;
	
}
#submitCol{
	text-align: center;
}
#submitBtn{
	height:40px;
	width: 200px;
	font-size: 15px;
	margin-top: 10px;
	border: none;
	background-color: #1a75ff;
	color: white;
	border-radius: 5px;
	font-weight: bold;
	cursor: pointer;
}

label { 
display: inline-block; 
padding: .5em .75em; 
color: #999; 
font-size: inherit; 
line-height: normal; 
vertical-align: middle; 
background-color: #fdfdfd; 
cursor: pointer; 
border: 1px solid #ebebeb; 
border-bottom-color: #e2e2e2; 
border-radius: .25em;
} 
#profile_img[type="file"]{
position: absolute;
width: 1px;
height: 1px;
padding: 0;
margin: -1px; 
overflow: hidden; 
clip:rect(0,0,0,0); 
border: 0;
}
#profimg{
border-radius: 30px;
}

</style>
<%
String myid=(String)session.getAttribute("sid");
ArrayList<MemberDTO> user = mdao.mypage(myid);
String profImg = user.get(0).getImg();
%>
<body>
<%@include file="/header.jsp" %>
<section>
<article>
	<form method="post" action="myProfile_m_ok.jsp" enctype="multipart/form-data">
	<table id="myImfo">
		<tr id="1">
 			<td>
				<%
				if(profImg=="0"||user.get(0).getImg()==null||user.get(0).getImg()=="null"){
					%>
					<img src="/instargram/icon/nobody.jpg" id="profimg" width="50" height="50">
					<%
				}else{
					%>
					<img src="../img/profile/<%=profImg %>" id="profimg" width="50" height="50">
					<%
				}
				%>
				
			</td>
			<td>&nbsp;&nbsp;
				<input type="text" name="my_name" value="<%=user.get(0).getId()%>" readonly="readonly">
				<label for="profile_img">프로필 사진 변경</label>
				<input id="profile_img" name="profile_img" type="file">
				<input type="hidden" name="my_fakeimg" value="<%=user.get(0).getImg()%>">
			</td>		
		</tr>
		<tr>
			<td>이름</td>
			<td>&nbsp;&nbsp;&nbsp;<input type="text" name="my_name" value="<%=user.get(0).getName()%>"></td>		
		</tr>		
		<tr>
			<td>닉네임</td>
			<td>&nbsp;&nbsp;&nbsp;<input type="text" name="my_nick" value="<%=user.get(0).getNickname()%>"></td>		
		</tr>		
		<tr>
			<td>웹사이트</td>
			<td>&nbsp;&nbsp;&nbsp;<input type="text" name="my_web" value="<%=user.get(0).getHomepage()%>"></td>		
		</tr>		
		<tr>
			<td>소개</td>
			<td>&nbsp;&nbsp;&nbsp;<input type="text" name="my_intro" value="<%=user.get(0).getGuide()%>"></td>		
		</tr>		
		<tr>
			<td>현재 비밀번호</td>
			<td>&nbsp;&nbsp;&nbsp;<input type="password" name="my_pwd"></td>		
		</tr>		
		<tr>
			<td>변경할 비밀번호</td>
			<td>&nbsp;&nbsp;&nbsp;<input type="password" name="c_pwd"></td>		
		</tr>
		<tr>
			<td id="submitCol" colspan="2"><input id="submitBtn" type="submit" value="변경"></td>
		</tr>		
	</table>
	</form>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>