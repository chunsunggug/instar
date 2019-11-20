<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cdto" class="semi.content.ContentDTO"></jsp:useBean>
<jsp:useBean id="cdao" class="semi.content.ContentDAO"></jsp:useBean>
<%



String realPath = "";
String filePath = "/img/upload";
String encType = "utf-8";
int sizeLimit = 10*1024*1024;

realPath = request.getServletContext().getRealPath(filePath);

try{
MultipartRequest multi = null;
multi = new MultipartRequest(request, realPath, sizeLimit, encType, new DefaultFileRenamePolicy());
String myid=multi.getParameter("id");
String mynick=multi.getParameter("nickname");
cdto.setId(myid);
cdto.setNickname(mynick);
cdto.setContent(multi.getParameter("content"));
System.out.println("받아온 값 확인"+myid+mynick+"\n경로"+realPath);
Enumeration files = multi.getFileNames();

while(files.hasMoreElements()){
	String paramName = (String) files.nextElement();
	System.out.println("paramName >>> " + paramName);
	String fileName = multi.getFilesystemName(paramName);
	/* File file = multi.getFile(paramName); */
	if(paramName.equals("mainimg")){
		cdto.setMainimg(fileName);
		System.out.println("mainimg >>> " + fileName);
	}else if(paramName.equals("subimg1")){
		cdto.setSubimg1(fileName);
		System.out.println("subimg1 >>> " + fileName);
	}else if(paramName.equals("subimg2")){
		cdto.setSubimg2(fileName);
		System.out.println("subimg2 >>> " + fileName);
	}else{
		cdto.setSubimg3(fileName);
		System.out.println("subimg3 >>> " + fileName);
	}
}

/* if(files.hasMoreElements()){
	String paramName = (String) files.nextElement();
	System.out.println("이미지 >>> " + paramName);
	String fileName = multi.getFilesystemName(paramName);
	System.out.println("이미지이름 >>> " + fileName);
	String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
	 boolean isImage = (fileExt.equalsIgnoreCase("PNG") ||
			fileExt.equalsIgnoreCase("JPG") ||
			fileExt.equalsIgnoreCase("GIF") ||
			fileExt.equalsIgnoreCase("JPEG")); 
	cdto.setMainimg(fileName);

} */
}catch(Exception e){
	e.printStackTrace();
}
int result = cdao.semiWrite(cdto);
String msg = result > 0 ? "업로드 성공!" : "업로드 실패!";
%>
<script>
window.alert('<%=msg%>');
location.href='/instargram/myPage/content.jsp';
</script>