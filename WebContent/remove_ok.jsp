<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.*" %>
<%@ page import="semi.content.*" %>
<%@ page import="semi.comment.*" %>

<jsp:useBean id="cdto" class="semi.content.ContentDTO"></jsp:useBean>
<jsp:setProperty property="*" name="cdto"/>
<jsp:useBean id="cdao" class="semi.content.ContentDAO"></jsp:useBean>
<jsp:useBean id="rdto" class="semi.relike.RelikeDTO"></jsp:useBean>
<jsp:setProperty property="*" name="rdto"/>
<jsp:useBean id="rdao" class="semi.relike.RelikeDAO"></jsp:useBean>
<jsp:useBean id="cmdto" class="semi.comment.CommentDTO"></jsp:useBean>
<jsp:setProperty property="*" name="cmdto"/>
<jsp:useBean id="cmdao" class="semi.comment.CommentDAO"></jsp:useBean>

<%

int idx = Integer.parseInt(request.getParameter("idx"));
ArrayList<ContentDTO> arr = cdao.semiFileFind(idx);
String mainimg = "";
String subimg1 = "";
String subimg2 = "";
String subimg3 = "";
String realFilePath1 = "";
String realFilePath2 = "";
String realFilePath3 = "";
String realFilePath4 = "";
File realFile1 = null;
File realFile2 = null;
File realFile3 = null;
File realFile4 = null;


if(arr.get(0).getMainimg() != null){
	mainimg = arr.get(0).getMainimg();
	subimg1 = arr.get(0).getSubimg1();
	subimg2 = arr.get(0).getSubimg2();
	subimg3 = arr.get(0).getSubimg3();
	realFilePath1 = request.getServletContext().getRealPath("/img/upload/")+mainimg;
	realFilePath2= request.getServletContext().getRealPath("/img/upload/")+subimg1;
	realFilePath3 = request.getServletContext().getRealPath("/img/upload/")+subimg2;
	realFilePath4 = request.getServletContext().getRealPath("/img/upload/")+subimg3;
	System.out.println("main >>> "+ mainimg);
	realFile1 = new File(realFilePath1);
	realFile2 = new File(realFilePath2);
	realFile3 = new File(realFilePath3);
	realFile4 = new File(realFilePath4);
	if(realFile1.exists()){
		realFile1.delete();
	}
	if(realFile2.exists()){
		realFile2.delete();
	}
	if(realFile3.exists()){
		realFile3.delete();
	}
	if(realFile4.exists()){
		realFile4.delete();
	}
}

int result = cdao.semiDelete(idx);
rdao.relikeDelete(idx);
rdao.clikeDelete(idx);
cmdao.semiDeleteComment(idx);
String msg = result > 0 ? "게시글을 삭제하였습니다." : "게시글을 삭제하지 못하였습니다.";
%>

<script>
window.alert('<%=msg%>');
location.href='/instargram/home.jsp';
</script>