<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String myid = (String)session.getAttribute("sid");
session.invalidate();
%>
<script>
	window.alert('로그아웃 되었습니다.');
	location.reload();
	window.self.close();
	location.replace('/instargram/member/member_login.jsp');
	
</script>