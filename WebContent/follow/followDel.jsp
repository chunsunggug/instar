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
String yid=request.getParameter("foff");
String myid= (String) session.getAttribute("sid");
int result = fdao.delFollow(myid,yid);
String msg = "";
if(result==1){
	msg="팔로잉이 취소 되셨습니다.";
}else{
	msg="오류가 발생하였습니다.";
}

%>

<script>
window.alert('<%=msg%>');
location.href='/instargram/fPage/fPage.jsp?yid=<%=yid%>';
</script>
</html>
