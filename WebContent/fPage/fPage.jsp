<%@page import="semi.content.ContentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="/instargram/css/fPage.css">
<link rel="stylesheet" href="/instargram/css/DetailModal.css">
<body id="background">

	<%@include file="fPage_top.jsp" %>
		<section>
		<article id="bottomAticle">
			<div id="nav">
				<ul>
					<li><a href="fPage.jsp?yid=<%=yidInfo.get(0).getId()%>"><img src="/instargram/img/myPage/board.png" style="width:20px;">게시물</a></li>
					<li><a href="fPage_tag.jsp?yid=<%=yidInfo.get(0).getId()%>"><img src="/instargram/img/myPage/tag.png" style="width:20px;">테그됨</a></li>
				</ul>
			</div>
			
			<%

			int totalCnt=concnt;
			if(totalCnt==0){
				totalCnt++;
			}
			int listSize=9;
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
			%>
			<div id="list">
			<%
			ArrayList<ContentDTO> yarr = cdao.ypageList(pnum,listSize,yid);
			if(yarr==null || yarr.size()==0){
				%>
				<div><a href="#"><img src="/instargram/img/gadot.jpeg"></a></div>
				<%
			}else{
				for(int i=0; i < yarr.size(); i++){
				if(yarr.get(i).getMainimg()==null||yarr.get(i).getMainimg().equals("null")||yarr.get(i).getMainimg().equals("")){
					%>
					<div><a href=""><img src="/instargram/img/upload/nobody.jpg"></a></div>
					<%
				}else{
					%>
					<div><a href="/instargram/detail.jsp?idx=<%=yarr.get(i).getIdx()%>"><img id="Detail" src="/instargram/img/upload/<%=yarr.get(i).getMainimg()%>"></a></div>
					<%	
							}
						}
					}
			
			%>
			</div>
		<center><div id="page">
<%
	if (nowPageGroup != 0) {
%>
	<a href="fPage.jsp?yid=<%=yid %>&cp=<%=(nowPageGroup - 1) * pageSize + pageSize%>">&lt;&lt;</a>
<%
	}
%>

<%
	for(int i=nowPageGroup*pageSize+1; i<=nowPageGroup*pageSize+pageSize; i++){
%>
	&nbsp;&nbsp; <a href="fPage.jsp?yid=<%=yid %>&pnum=<%=i %>"><%=i %></a> &nbsp;&nbsp;
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
	<a href="fPage.jsp?yid=<%=yid %>&pnum=<%=(nowPageGroup + 1) * pageSize + 1%>">&gt;&gt;</a>
<%
}
%>
</div></center>
		</article>
	</section>
	
	
	<!-- Detail likes Modal -->
	
	<div id="likesModal" class="modal2">
		<div class="likesmodal-content">
		
		</div>
	</div>
<%@include file="/footer.jsp" %>
	
	
<script>


function changeLike(){
	var like = document.getElementById("like");
	if(like.src.match("color")){
		like.src="/instargram/icon/like.png";
	}else{
		like.src="/instargram/icon/like_color.png";
	}
}

function changeTag(){
	var tag = document.getElementById("tag");
	if(tag.src.match("color")){
		tag.src="/instargram/icon/tag.png";
	}else{
		tag.src="/instargram/icon/tag_color.png";
	}
}

function likesBtn(){
	var sW=screen.availwidth;
	var sH=screen.availHeight;
	var top = (parseInt(sH-350))/2;
	window.open('/instargram/likesList.html','popup','width=400,height=350,left=700,top='+top+',scrollbars=yes');
}

</script>
</body>
</html>