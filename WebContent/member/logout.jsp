<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
session.invalidate();
%>
<script>
	window.alert('�α׾ƿ��� �Ϸ�Ǿ����ϴ�.');
	location.reload();
	window.self.close();
	location.replace('/instargram/member/member_login.jsp');
</script>