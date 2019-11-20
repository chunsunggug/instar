<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.MemberDTO"%>    
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="mdto" class="member.MemberDTO"></jsp:useBean>
<jsp:useBean id="mdao" class="member.MemberDAO"></jsp:useBean>
<%
String id=request.getParameter("id");
String pwd=request.getParameter("pwd");
mdto.setId(id);
mdto.setPwd(pwd);

int result = mdao.loginCheck(id, pwd);
String msg="";
String url="";
if(result==3){
	ArrayList<MemberDTO> userInfo=mdao.getUserInfo(mdto);
	session.setAttribute("sid", id);
	session.setAttribute("sname", userInfo.get(0).getName());
	session.setAttribute("snick", userInfo.get(0).getNickname());
	session.setAttribute("sprof", userInfo.get(0).getImg());
	
	msg=userInfo.get(0).getNickname()+"님 환영합니다!";
	url="/instargram/home.jsp";
}else{
	msg="아이디와 비밀번호를 다시한번 확인해 주세요";
	url="/instargram/member/member_login.jsp";
}
%>
<script>
window.alert('<%=msg%>');
location.href='<%=url%>';
</script>