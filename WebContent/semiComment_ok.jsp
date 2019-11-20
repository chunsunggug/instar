<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="semi.comment.*" %>
<jsp:useBean id="cmdto" class="semi.comment.CommentDTO"></jsp:useBean>
<jsp:setProperty property="*" name="cmdto"/>
<jsp:useBean id="cmdao" class="semi.comment.CommentDAO"></jsp:useBean>

<%
int result = cmdao.semiInsertComment(cmdto);
String msg = result > 0 ? "댓글이 입력되었습니다!" : "댓글입력 실패";
%>
<script>
window.alert('<%=msg%>');
location.href="/instargram/detail.jsp?idx=<%=cmdto.getIdx()%>";
</script>