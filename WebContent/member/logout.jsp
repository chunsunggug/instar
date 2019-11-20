<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
session.invalidate();
%>
<script>
	window.alert('로그아웃이 완료되었습니다.');
	location.reload();
	window.self.close();
	location.replace('/instargram/member/member_login.jsp');
</script>