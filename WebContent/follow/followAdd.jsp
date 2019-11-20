<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="fdto" class="semi.follow.FollowDTO"></jsp:useBean>
    <jsp:useBean id="fdao" class="semi.follow.FollowDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
String yid=request.getParameter("fon");
String myid= (String) session.getAttribute("sid");
int result = 0;
result = fdao.addFollow(myid,yid);

String msg = "";

if(result==1){
	msg="팔로잉하셨습니다.";
}else{
	msg="로그인을 해주세요.";
}

%>

<script>
window.alert('<%=msg%>');
location.href='/instargram/fPage/fPage.jsp?yid=<%=yid%>';
</script>
</html>
