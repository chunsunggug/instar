<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="mdao" class="member.MemberDAO"></jsp:useBean>
    <jsp:useBean id="cdao" class="semi.content.ContentDAO"></jsp:useBean>
    <jsp:useBean id="fdao" class="semi.follow.FollowDAO"></jsp:useBean>
<link rel="stylesheet" href="/instargram/css/fPage.css">
<link rel="stylesheet" type="text/css" href="/instargram/css/font_color.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/mainLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/history_modalLayout.css?after">
<%@include file="/header.jsp" %>
 <%
 	String yid = request.getParameter("yid");
    if(yid==null||yid.equals("null")||yid.equals("")){
    	%>
      	<script>
      	window.alert('잘못된 접근 또는 삭제된 게시글입니다');
      	location.href = '../home.jsp';
      	</script>     	   
     		<%
     		return;
    }else if(yid!=null||!yid.equals("")||!yid.equals("null")){
    	session.setAttribute("yid", yid);
    }else{
   		yid=(String) session.getAttribute("yid");
    }
    ArrayList<MemberDTO> yidInfo=mdao.mypage(yid); 
    int concnt = cdao.getTotalCnt(yid);
    int follow = fdao.allFollow(yid);
    int folling = fdao.allFolloing(yid);
    %>
	<section>
		<article id="topAticle">
			<div id="proFile">
			<%
			String yourimg = yidInfo.get(0).getImg();
			if(yourimg==null||yourimg.equals("null")||yourimg.equals("")){
				yourimg="nobody.jpg";
			}
			%>
				<img id="proFileimg" src="/instargram/img/profile/<%=yourimg%>">
				
			</div>
			<div id="nickname">
			<%
			if(yidInfo!=null){
				%>
				<h2>[<%=yidInfo.get(0).getNickname() %>]</h2>
				<%
			}else{
				%>
				<h2>다시 확인해주세요.</h2>
				<%
			}
			 %>
			</div>
			<div id="followBtn">
			<%
			int check = fdao.checkFollow(id,yid);
			if(yid.equals(id)){
				%>
				<input id="fBtn" type="button" value="로그아웃" onclick="logout()">
				<%
			}else{
			if(check==fdao.ON_FOLLOW){
				%>
				<form action="/instargram/follow/followDel.jsp">
				<input id="fBtn" name="foff" type="hidden" value="<%=yid %>">
				<input id="fBtn" type="submit" value="팔로우 취소">
				</form>
				<%
			}else{
				%>
				<form action="/instargram/follow/followAdd.jsp">
				<input id="fBtn" name="fon" type="hidden" value="<%=yid %>">
				<input id="fBtn" type="submit" value="팔로우">
				</form>
				<%
			}
			}
			%>
				
			</div>
			<div id="proFileMenu">
				<ul>
					<li>게시물[ <%=concnt %> ]</li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li>팔로워[ <%=folling %> ]</li>&nbsp;&nbsp;&nbsp;&nbsp;
					<li>팔로잉[ <%=follow %> ]</li>&nbsp;&nbsp;&nbsp;&nbsp;
				</ul>
			</div>
			<div id="selfimfo">
				<ul>
					<li>이름 : <%=yidInfo.get(0).getName() %></li>
					<li>자기소개 : <%=yidInfo.get(0).getGuide() %></li>
					<li>홈페이지 : <a href="<%=yidInfo.get(0).getHomepage()%>"><%=yidInfo.get(0).getHomepage() %></a></li>
				</ul>
			</div>
		</article>
	</section>
		<script>
      	function logout(){
      		location.replace('/instargram/member/logout.jsp');
      	}
      	</script>   
