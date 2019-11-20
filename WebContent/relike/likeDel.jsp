<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="rdao" class="semi.relike.RelikeDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
int idx =Integer.parseInt(request.getParameter("idx"));
String myid= (String) session.getAttribute("sid");
int result = 0;
String msg = "";
result = rdao.deleteLike(idx, myid);
if(result==1){
	msg="좋아요가 취소 되셨습니다.";
	%>
	 <script>
	window.alert('<%=msg%>');
	opener.location.reload();
	window.self.close();
	</script>
	<%
}else{
	msg="오류가 발생하였습니다.";
	%>
	<script>
	window.alert('<%=msg%>');
	opener.location.replace('/instargram/member/member_login.jsp');
	window.self.close();
	</script>
	<%
}

%>


</html>
