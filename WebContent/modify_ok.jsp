<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="semi.content.*" %>
<jsp:useBean id="cdto" class="semi.content.ContentDTO"/>
<jsp:setProperty property="*" name="cdto"/>
<jsp:useBean id="cdao" class="semi.content.ContentDAO"/>
<%
int idx = Integer.parseInt(request.getParameter("idx"));
String content = (String)request.getParameter("content");
int result = cdao.semiContentModify(content, idx);
String msg = result > 0 ? "수정이 완료되었습니다." : "수정실패";
%>
<script>
window.alert('<%=msg%>');
location.href="/instargram/detail.jsp?idx=<%=idx%>"
</script>