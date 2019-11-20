<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="member.MemberDAO"></jsp:useBean>
<% 
String myid = (String)session.getAttribute("sid");
ArrayList<MemberDTO> user= mdao.mypage(myid);
%>
<% 
String uploadPath=request.getRealPath("/img/profile");
int maxSize = 1024*1024*100;
long fileSize=0;
String fileType="";
String filename="";

String name = "";
String nick="";
String guide="";
String home="";
String pwd="";
String cpwd="";
String getimg="";
String fakeimg="";
MultipartRequest multi = null;

try{
multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
name =multi.getParameter("my_name");
nick=multi.getParameter("my_nick");
guide=multi.getParameter("my_intro");
home=multi.getParameter("my_web");
cpwd=multi.getParameter("c_pwd");
fakeimg=multi.getParameter("my_fakeimg");

}catch(Exception e){
	e.printStackTrace();
}
System.out.println(name+nick+pwd+getimg+uploadPath+"확인"+fakeimg);

if(name!=null||!name.equals("")||!name.equals("null")||!name.equals(user.get(0).getName())){
	int result = mdao.modifyName(myid,name);
	if(result!=1){
		System.out.println("Error Modify");
	}
}
if(nick!=null&&!nick.equals("")&&!nick.equals("null")&&!nick.equals(user.get(0).getNickname())){
	int result = mdao.modifyNick(myid,nick);
	if(result!=1){
		System.out.println("Error Modify");
	}
}
if(guide!=null&&!guide.equals("")&&!guide.equals("null")&&!guide.equals(user.get(0).getGuide())){
	int result = mdao.modifyGuide(myid,guide);
	if(result!=1){
		System.out.println("Error Modify");
	}
}
if(home!=null&&!home.equals("")&&!home.equals("null")&&!home.equals(user.get(0).getHomepage())){
	int result = mdao.modifyHome(myid,home);
	if(result!=1){
		System.out.println("Error Modify");
	}
}
if(cpwd!=null||!pwd.equals("")||!pwd.equals("null")||!pwd.equals(user.get(0).getPwd())){
	int result = mdao.modifyPwd(myid,cpwd);
	if(result!=1){
		System.out.println("Error Modify");
	}
}
if(fakeimg!=null||fakeimg!="0"||!fakeimg.equals("")||!fakeimg.equals("null")||!fakeimg.equals(user.get(0).getImg())){
	try{
		File f = new File(uploadPath+"\\"+fakeimg);
		if(f.exists()){
			f.delete();
		}
		getimg = multi.getFilesystemName("profile_img");
		filename=uploadPath+"\\"+getimg;
	
	}catch(Exception e){
		e.printStackTrace();
	}
	int result = mdao.modifyImg(myid,getimg);
}
session.invalidate();
%>
<script>
	window.alert('개인 정보 수정이 완료되었습니다.');
	location.reload();
	window.self.close();
	location.replace('/instargram/member/member_login.jsp');
	
</script>