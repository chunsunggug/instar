<%@page import="member.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="m_dao" class="member.MemberDAO"></jsp:useBean>
    <jsp:useBean id="c_dao" class="semi.content.ContentDAO"></jsp:useBean>
    <jsp:useBean id="f_dao" class="semi.follow.FollowDAO"></jsp:useBean>
    <%
String myid=(String)session.getAttribute("sid");
ArrayList<MemberDTO> user = m_dao.mypage(myid);
String profImg = user.get(0).getImg();
int concnt = c_dao.getTotalCnt(myid);
int folloing = f_dao.allFollow(myid);
int follow = f_dao.allFolloing(myid);
%>
<section>
<%
if(profImg==null||profImg.equals("0")||profImg.equals("")){
	
	%>
<div id="my_img"><img src="../icon/nobody.jpg"></div>	
	<%
	
}else{
	%>
<div id="my_img"><img src="../img/profile/<%=user.get(0).getImg() %>"></div>	
	<%
}
%>

<div id="my_profile">
	<div id="top"><span id="my_id"><%=myid %></span> &nbsp; 
	<input type="button" id="edit" value="프로필 편집" onclick="location.href='myProfile_m.jsp'">&nbsp;
	<input type="button" id="edit" value="로그아웃" onclick="location.href='logout_ok.jsp'"></div>
	<div id="middle">게시물 <%=concnt %> &nbsp; 팔로워 <%=follow %> &nbsp; 팔로잉 <%=folloing %> </div>
	<div id="bottom"><span id="my_name"><%=user.get(0).getName() %></span></div>
	<div>자기소개 : <%=user.get(0).getGuide() %></div>
	<div>홈페이지 : <a href=<%=user.get(0).getHomepage() %>><%=user.get(0).getHomepage() %></a></div>
	
</div>
<article>
<div id="myPage_bar">
	<div id="myPage_bar_content">
		<a href="content.jsp"><img src="../img/myPage/board.png">게시물</a>
	</div>
	<div id="myPage_bar_saved">
		<a href="saved.jsp"><img src="../img/myPage/flag.png">저장됨</a>
	</div>
	<div id="myPage_bar_taged">
		<a href="taged.jsp"><img src="../img/myPage/tag.png">태그됨</a>
	</div>
</div>
</article>
</section>