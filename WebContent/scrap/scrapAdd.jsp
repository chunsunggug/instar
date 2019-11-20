<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="rdao" class="semi.relike.RelikeDAO"></jsp:useBean>
<jsp:useBean id="cdao" class="semi.content.ContentDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
int idx =Integer.parseInt(request.getParameter("idx"));
String myid= (String) session.getAttribute("sid");
String yid=request.getParameter("yid");
int result = 0;
String msg="";
result = cdao.semiAddScrap(idx,myid,yid);


%>

<script>
opener.location.reload();
window.self.close();
</script>
</html>
