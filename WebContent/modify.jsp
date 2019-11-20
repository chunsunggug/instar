<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>
<%@ page import="semi.content.*" %>
<%@ page import="semi.comment.*" %>
<%@ page import="member.*" %>

<jsp:useBean id="mdto" class="member.MemberDTO"></jsp:useBean>
<jsp:useBean id="cdao" class="semi.content.ContentDAO"/>
<jsp:useBean id="cmdao" class="semi.comment.CommentDAO"/>
<jsp:useBean id="mdao" class="member.MemberDAO"/>
<jsp:useBean id="rdao" class="semi.relike.RelikeDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>
<link rel="stylesheet" type="text/css" href="/instargram/css/font_color.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/mainLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/detailLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/detailreplyLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/history_modalLayout.css?after">
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<article id="list">
<form name="semiModify" action="modify_ok.jsp">
<%
int idx = Integer.parseInt(request.getParameter("idx"));
int idx_check=idx;

ContentDTO cdto = cdao.semiContent(idx);
String yid=cdto.getId();
String yourimg = mdao.getUserInfo(cdto.getId());
%>

<div id="content_box">
	<input type="hidden" name="id" value="<%=cdto.getId() %>" />
	
	<div id="content_img">
	<%	String mainImg = cdto.getMainimg();
		String subimg1 = cdto.getSubimg1();
		String subimg2 = cdto.getSubimg2();
		String subimg3 = cdto.getSubimg3();
		
		if(subimg1==null||subimg1.equals("null")||subimg1.equals("")){
			subimg1 = "nobody.jpg";
		}else if(subimg2==null||subimg2.equals("null")||subimg2.equals("")){
			subimg2 = "nobody.jpg";
		}else if(subimg3==null||subimg3.equals("null")||subimg3.equals("")){
			subimg3 = "nobody.jpg";
		}
		
		if(mainImg==null||mainImg.equals("null")||mainImg.equals("")){
			%>
			<img src="/instargram/img/upload/nobody.jpg">
			<%
		}else {
			%>
			<img class="slider" src="/instargram/img/upload/<%=mainImg %>"> 
			<img class="slider" src="/instargram/img/upload/<%=subimg1 %>">
			<img class="slider" src="/instargram/img/upload/<%=subimg2 %>">
			<img class="slider" src="/instargram/img/upload/<%=subimg3 %>">
			  
			<a class="w3-btn-floating" style="position:absolute;top:50%;left:0" onclick="plusDivs(-1)"><img style="width:30px;" src="/instargram/icon/arrow-left.png"></a>
			<a class="w3-btn-floating" style="position:absolute;top:50%;right:51.5%" onclick="plusDivs(1)"><img style="width:30px;" src="/instargram/icon/arrow-right.png"></a> 
	<% 
		}			
	%>
	</div>
	<div id="content_main">  
		<div id="writer">
		<%
			if(yourimg==null||yourimg.equals("null")||yourimg.equals("")){
		%>
			<div id="writer_img"><a href="#"><img src="/instargram/img/profile/nobody.jpg"></a></div>
		<%
			}else{
		%>
			<div id="writer_img"><a href="#"><img src="/instargram/img/profile/<%=yourimg%>"></a></div>
		<%
			}
		%>
			<div id="writer_name"><a href="fPage/fPage.jsp?yid=<%=cdto.getId()%>"><span style="font-weight:bold;"><%=cdto.getNickname() %></span></a></div>
		</div>
		
		
		<div id="content_text">
			<input type="hidden" name="idx" value="<%=cdto.getIdx()%>">
			<textarea name="content" id="m_content"><%=cdto.getContent() %></textarea>
			<input id="fBtn" type="submit" value="수정하기">
		</div> 
		 
	</div>	
</div>

</form>
</article>
</section>
<%@include file="/footer.jsp" %>
<script>
function changeLike(){
	var like = document.getElementById("like");
	if(like.src.match("color")){
		like.src="icon/like.png";
		window.open('/instargram/relike/likeDel.jsp?idx=<%=idx_check%>','likeAddpopup','width=350,height=300,left=700');
	}else{
		like.src="icon/like_color.png";
		window.open('/instargram/relike/likeAdd.jsp?idx=<%=idx_check%>','likeDelpopup','width=350,height=300,left=700');
	}
}

function changeTag(){
	var tag = document.getElementById("tag");
	if(tag.src.match("color")){
		tag.src="icon/tag.png";
		window.open('/instargram/scrap/scrapDel.jsp?idx=<%=idx_check%>&yid=<%=yid%>','scrapAddpopup','width=1,height=1');
	}else{
		tag.src="icon/tag_color.png";
		window.open('/instargram/scrap/scrapAdd.jsp?idx=<%=idx_check%>&yid=<%=yid%>','scrapDelpopup','width=1,height=1');
	}
}

function likesBtn(){
	var sW=screen.availwidth;
	var sH=screen.availHeight;
	var top = (parseInt(sH-350))/2;
	window.open('likesList.html','popup','width=400,height=350,left=700,top='+top+',scrollbars=yes');
}

function input_check(){
	   
	   window.onkeyup = function(){
	      var reply = document.getElementById('reply_text');
	      var reply_ok = document.getElementById('reply_ok');
	      var temp;
	      temp = reply.value;
	         if(temp==''||temp==' '){
	            reply_ok.disabled = true;   
	            reply_ok.style.opacity = "0.5";
	            reply_ok.style.cursor = "default";
	         }
	         else{
	            reply_ok.disabled = false;
	            reply_ok.style.opacity = "1";
	            reply_ok.style.cursor = "pointer";
	            
	         }
	      
	         console.log("value >>> " + reply.value + "지금 입력받는 곳의 ID는 " +  reply.id);
	      
	   }
	}
	
	var slideIndex = 1;
	showDivs(slideIndex);
	
	function plusDivs(n) {
	  showDivs(slideIndex += n);
	}
	
	function showDivs(n) {
	  var i;
	  var x = document.getElementsByClassName("slider");
	  if (n > x.length) {slideIndex = 1}    
	  if (n < 1) {slideIndex = x.length} ;
	  for (i = 0; i < x.length; i++) {
	     x[i].style.display = "none";  
	  }
	  x[slideIndex-1].style.display = "block";  
	}
</script>
</body>
</html>