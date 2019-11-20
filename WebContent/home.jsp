<%@page import="semi.follow.FollowDTO"%>
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
<jsp:useBean id="fdao" class="semi.follow.FollowDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>
<link rel="stylesheet" type="text/css" href="/instargram/css/font_color.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/mainLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/listLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/replyLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/history_modalLayout.css?after">
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<article id="list">
<form action="semiComment_ok.jsp">
<%

int totalCnt=cdao.getTotalCnt();
int listSize=5;
int pageSize=5;

String pnum_temp=request.getParameter("pnum");
if(pnum_temp==null||pnum_temp.equals("")){
	pnum_temp="1";
}
int pnum=Integer.parseInt(pnum_temp);

int totalPage=(totalCnt/listSize)+1;
if(totalCnt%listSize==0)totalPage--;

int nowPageGroup=pnum/pageSize;
if(pnum%pageSize==0)nowPageGroup--;
int idx_check=0;
String yid="";
ArrayList<ContentDTO> arr = cdao.semiList(pnum,listSize);
if(arr==null || arr.size()==0){
%>

<h2>등록된 게시글이 없습니다.</h2>
<%
}else{//
for(int i=0; i < arr.size(); i++){
	idx_check=arr.get(i).getIdx();
	yid=arr.get(i).getId();
ArrayList<CommentDTO> carr = cmdao.semiListComment(arr.get(i).getIdx());
String yourimg = mdao.getUserInfo(arr.get(i).getId());
%>
<div id="content_box">
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
	<div id="writer_name"><a href="fPage/fPage.jsp?yid=<%=arr.get(i).getId()%>"><span style="font-weight:bold;"><%=arr.get(i).getNickname() %></span></a></div>
	<div id="dot"><a href="detail.jsp?idx=<%=arr.get(i).getIdx()%>"><img src="img/list/dot.png"></a></div>
</div>
<div id="content_img">
<%	String mainImg = arr.get(i).getMainimg();
	if(mainImg==null||mainImg.equals("null")||mainImg.equals("")){
		%>
		<a href="detail.jsp?idx=<%=arr.get(i).getIdx()%>"><img src="/instargram/img/upload/nobody.jpg"></a>
		<%
	}else{
		%>
		<a href="detail.jsp?idx=<%=arr.get(i).getIdx()%>"><img src="/instargram/img/upload/<%=mainImg %>"></a>	
		<%
	}
%>	
	
	
</div>
<div id="icons">
	<%
	boolean check_like=false; 
	check_like=rdao.checkLike(idx_check, id);
	if(check_like==true){
		%>
	<img id="like" src="./icon/like_color.png">
		<%
	}else{
		%>
	<img id="like" src="./icon/like.png"">
		<%
	}
	%>
	
	
	<a href="detail.jsp?idx=<%=arr.get(i).getIdx()%>"><img src="./icon/message.png"></a>
	
	
	<img src="./icon/share.png">
	
	
		<%
	boolean check_tag=false; 
	check_tag=cdao.checkScrap(idx_check,id);
	if(check_tag==true){
		%>
	<img id="tag" src="./icon/tag_color.png"">
		<%
	}else{
		%>
	<img id="tag" src="./icon/tag.png"">
		<%
	}
	%>
	
	
	
</div>
	<div id="likesBtn" onclick="likesBtn()">좋아요 <%=arr.get(i).getRelike() %>개</div>
<div id="content_text">
	<a href="#"><span style="font-weight:bold;"><%=arr.get(i).getNickname() %></span></a>&nbsp;<span><%=arr.get(i).getContent() %></span> 
</div>
<div id="reply">
	<%
		for(int j = 0; j < carr.size(); j++){
	%>
	<div>
		<a href="#"><%=carr.get(j).getId() %></a>&nbsp;<span><%=carr.get(j).getR_comment() %></span> 
	</div>
	<%
		}
	%>
</div>
<div id="past_time">
	<a href="#">1시간 전</a>
</div>
<div id="reply_input">
	<input type="hidden" value="<%=arr.get(i).getIdx() %>" name="idx">
	<input type="hidden" value="<%=arr.get(i).getId() %>" name="yid">
	<input type="hidden" value="<%=id %>" name="id">
	<input type="hidden" value="<%=nickname %>" name="nickname">
	
	<!-- <input type="text" id="reply_text<%=arr.get(i).getIdx() %>" placeholder="댓글달기.." name="r_comment" onclick="input_check(<%=arr.get(i).getIdx() %>)" class="reply_text">
   <input type="submit" value="게시" id="reply_ok<%=arr.get(i).getIdx() %>" disabled="disabled" class="reply_ok"> -->
	
</div>
</div>
<%
}
}//
%>
<div id="page">
<%
	if (nowPageGroup != 0) {
%>
	<a href="home.jsp?cp=<%=(nowPageGroup - 1) * pageSize + pageSize%>">&lt;&lt;</a>
<%
	}
%>

<%
	for(int i=nowPageGroup*pageSize+1; i<=nowPageGroup*pageSize+pageSize; i++){
%>
	&nbsp;&nbsp; <a href="home.jsp?pnum=<%=i %>"><%=i %></a> &nbsp;&nbsp;
	<%
		if (i == totalPage)
			break;
	%>
<%
	}
%>

<%
		if (nowPageGroup != (totalPage / pageSize - (totalPage % pageSize == 0 ? 1 : 0))) {
	%>
	<a href="home.jsp?pnum=<%=(nowPageGroup + 1) * pageSize + 1%>">&gt;&gt;</a>
<%
}
%>
</div>
</form>
</article>
<article id="side">
	<div id="profile">
		<div id="profile_img"><a href="myPage/content.jsp">
		<%
		if(img==null||img.equals("null")||img.equals("")||img.equals("nobody.jpg")){
			
			%>
			<img src="/instargram/img/profile/nobody.jpg">
			<%
		}else{
			%>
			<img src="/instargram/img/profile/<%=img %>"></a>
			<%
		}
		%>
		</div>
		<div id="profile_name">
			<a href="myPage/content.jsp"><%=nickname %></a><br/>
			<%=name %>
		</div>
	</div>
	<div id="recommend">
		<div id="recommend_top">
			<div id="recommend_top_left">
				회원님을 위한 추천
			</div>
			<div id="recommend_top_right">
				<a href="#">모두 보기</a>
			</div>
		</div>
		<%
		ArrayList<FollowDTO> flist = fdao.followList(id);
		for(int n=0; n<flist.size(); n++){
			String fyourimg = mdao.getUserInfo(flist.get(n).getId());
		%>
		<div id="recommend_user">
		<%if(fyourimg==null||fyourimg.equals("null")||fyourimg.equals("")){
			%>
			<div id="recommend_img"><a href="fPage/fPage.jsp"><img src="/instargram/img/profile/nobody.jpg"></a></div>
			<%
		}else{
			%>
			<div id="recommend_img"><a href="fPage/fPage.jsp"><img src="/instargram/img/profile/<%=fyourimg%>"></a></div>
			<%
		}
		 %>
			
			
			<div id="recommend_text">
				<div id="recommend_name"><a href="fPage/fPage.jsp"><%=flist.get(n).getId() %></a></div>
				<div id="recommend_fstate">	회원님을 팔로우 합니다 </div>
			</div>
			<div id="recommend_follow">
			<a href="fPage/fPage.jsp?yid=<%=flist.get(n).getId()%>">팔로우</a>
			</div>
		</div>
		<%
		}
		%>
	</div>
</article>
</section>
<%@include file="/footer.jsp" %>
<script>

//function changeLike(){
//	var like = document.getElementById("like");
//	if(like.src.match("color")){
//		like.src="icon/like.png";
//	}else{
//		like.src="icon/like_color.png";
//	}
//}

//function changeTag(){
//	var tag = document.getElementById("tag");
//	if(tag.src.match("color")){
//		tag.src="icon/tag.png";
//	}else{
//		tag.src="icon/tag_color.png";
//	}
//}
/*
function likesBtn(){
	var sW=screen.availwidth;
	var sH=screen.availHeight;
	var top = (parseInt(sH-350))/2;
	window.open('likesList.html','popup','width=400,height=350,left=700,top='+top+',scrollbars=yes');
}*/

/*function input_check(idx){
	   var idx=idx;
	   window.onkeyup = function(){
	      var reply = document.getElementById('reply_text'+idx);
	      var reply_ok = document.getElementById('reply_ok'+idx);
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
	}*/


</script>
</body>
</html>