<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdto" class="member.MemberDTO"></jsp:useBean>
<jsp:useBean id="mdao" class="member.MemberDAO"></jsp:useBean>
<%
String id=request.getParameter("id");
String pwd=request.getParameter("pwd");
String name=request.getParameter("name");
String nick=request.getParameter("nick");
boolean res = mdao.idCheck(id);
System.out.println("불린 레스"+res);
if(res==true){
	%>
	<script>
	window.alert('이미 가입된 계정입니다.');
	location.href='/instargram/member/member_join.jsp';
	</script>	
	<%
	
	return;
}
int result = mdao.memberJoin(id, pwd, name, nick);
String msg=result>0?"회원가입 완료":"회원가입 실패";
%>
<script>
window.alert('<%=msg%>');
location.href='/instargram/member/member_login.jsp';
</script>