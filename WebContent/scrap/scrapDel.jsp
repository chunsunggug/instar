<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="rdao" class="semi.relike.RelikeDAO"></jsp:useBean>
<<jsp:useBean id="cdao" class="semi.content.ContentDAO"></jsp:useBean>
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
String msg = "";
result = cdao.semiDelScrap(idx,myid);
if(result==1){
	msg="스크랩이 취소 되었습니다.";
	%>
	 <script>
	opener.location.reload();
	window.self.close();
	</script>
	<%
}else{
	msg="오류가 발생하였습니다.";
	%>
	<script>
	opener.location.replace('/instargram/member/member_login.jsp');
	window.self.close();
	</script>
	<%
}
System.out.println("스크랩 에러 현황 확인"+msg);
%>


</html>
