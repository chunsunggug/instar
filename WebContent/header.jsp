<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<header>
<%
String id = (String)session.getAttribute("sid");
String name = (String)session.getAttribute("sname");
String nickname = (String)session.getAttribute("snick");
String img = (String)session.getAttribute("sprof");

if(id==null||id.equals("null")){
	%>
	<script type="text/javascript">
	window.alert('로그인 후 이용해주세요.');
	location.replace('/instargram/member/member_login.jsp');
	</script>
	<%
}
%>
<div id="home_logo">
<a href="/instargram/home.jsp"><img src="/instargram/img/header/instar_logo.png"></a>
</div>
<div id="search">
<input type="text" name="search_bar" placeholder="검색">
</div>
<div id="menu">
<a href="/instargram/write/write.jsp"><img src="/instargram/img/header/compass.png"></a>
<a href="#"><img id="history_open" src="/instargram/icon/like.png"></a>
<a href="/instargram/myPage/content.jsp"><img src="/instargram/img/header/person.png"></a>
</div>
</header>

<article id="history">
   <div id="history_modal">
      <div id="history_modal_box">
      <div id="history_modal_box_scroll">
         <%
         for(int i=0; i<10; i++){ 
         %>
         <div id="history_alarm_wrap">
            <div id="history_alarm_img"><img src="/instargram/img/sample_writer.jpg"></div>
            <%
            if(i%2==0){
            %>
               <div id="history_alarm_box">
                  <div id="history_alarm_box_text">
                  	<p id="history_alarm_box_text_name"><span style="font-weight:bold;">이름NAME</span> 님이 회원님을 팔로우하기 시작했습니다.</p>
                  </div>
                  <div id="history_alarm_box_button"><input type="button" value="팔로우"></div>
               </div>
            <%
            }else{ 
            %>
               <div id="history_alarm_box">
                  <div id="history_alarm_box_text">
                  	<p id="history_alarm_box_text_name"><span style="font-weight:bold;">이름NAME/이름NAME/이름NAME</span> 님이 회원님의 사진을 좋아합니다.</p>
                  </div>
                  <div id="history_alarm_box_img"><img src="/instargram/img/sample_content.jpg"></div>
               </div>
            <%
            } 
            %>
         </div>
         <%
         } 
         %>
      </div>
   </div>
   </div>
</article>


<script>
//Get the modal
var modal = document.getElementById("history");

// Get the img that opens the modal
var img = document.getElementById("history_open");

// When the user clicks the img, open the modal 
img.onclick = function() {
  modal.style.display = "block";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
//--------------------------------------------------------

</script>