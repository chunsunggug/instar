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
String msg="";
result = rdao.insertLike(idx, myid);

if(result==1){
	msg="좋아요~";
}else{
	msg="오류가 발생하였습니다.";
}

%>

<script>
window.alert('<%=msg%>');
opener.location.reload();
window.self.close();
</script>
</html>
