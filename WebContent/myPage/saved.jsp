<%@page import="semi.content.ContentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="cdao" class="semi.content.ContentDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
<link rel="stylesheet" type="text/css" href="/instargram/css/font_color.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/mainLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/myPageLayout.css?after">
<link rel="stylesheet" type="text/css" href="/instargram/css/history_modalLayout.css?after">
<link rel="stylesheet" href="/instargram/css/fPage.css?after">
<style>
a{
	text-decoration: none;
}

#myPage_bar_content{
	opacity: 0.5;
}

#myPage_bar_saved{
	border-top: 0.5px solid #6E6E6E;
}

#myPage_bar_taged{
	opacity: 0.5;
}

#container{
	width: 680px;
	height: 330px;
}
#container div{
	display: inline-block;
	float: left;
	width: 330px;
	height: 330px;
}

#content_img img{
	width:330px;
}
#content_text{
	text-align: center;
}

</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/myPage/myProfile.jsp" %>
<%
				int totalCnt = cdao.getTotalmscr(id);
				if(totalCnt==0){
					totalCnt++;
				}
				int listSize = 9;
				int pageSize = 5;

				String pnum_temp = request.getParameter("pnum");
				if (pnum_temp == null || pnum_temp.equals("")) {
					pnum_temp = "1";
				}
				int pnum = Integer.parseInt(pnum_temp);

				int totalPage = (totalCnt / listSize) + 1;
				if (totalCnt % listSize == 0)
					totalPage--;

				int nowPageGroup = pnum / pageSize;
				if (pnum % pageSize == 0)
					nowPageGroup--;
				int idx_check = 0;
			%>

<div id="list">
<%
					ArrayList<ContentDTO> tarr = cdao.semiScrapList(id);
					if (tarr == null || tarr.size() == 0) {
				%>
						<img src="../img/sampleImg.jpg">
				<%
					} else {
						for (int i = 0; i < tarr.size(); i++) {
							int idx_sc = tarr.get(i).getIdx();
							String tarrimg = cdao.semiScrapImgFind(idx_sc);
							if (tarrimg == null || tarrimg.equals("null") || tarrimg.equals("")) {
				%>
<div>
					<a href="/instargram/detail.jsp?idx=<%=idx_sc%>"><img id="Detail" src="/instargram/img/upload/<%=tarrimg%>"></a>
				</div>
				<%
					} else {
				%>
	<div>
					<a href="/instargram/detail.jsp?idx=<%=idx_sc%>"><img id="Detail"
						src="/instargram/img/upload/<%=tarrimg%>"></a>
				</div>
				<%
					}
						}
					}
				%>

</div>
	<center>
				<div id="page">
					<%
						if (nowPageGroup != 0) {
					%>
					<a href="saved.jsp?id=<%=id %>&cp=<%=(nowPageGroup - 1) * pageSize + pageSize%>">&lt;&lt;</a>
					<%
						}
					%>

					<%
						for (int i = nowPageGroup * pageSize + 1; i <= nowPageGroup * pageSize + pageSize; i++) {
					%>
					&nbsp;&nbsp; <a href="saved.jsp?id=<%=id%>&pnum=<%=i%>"><%=i%></a>
					&nbsp;&nbsp;
					<%
						if (i == totalPage)break;
					%>
					<%
						}
					%>

					<%
						if (nowPageGroup != (totalPage / pageSize - (totalPage % pageSize == 0 ? 1 : 0))) {
					%>
					<a href="saved.jsp?id=<%=id %>&pnum=<%=(nowPageGroup + 1) * pageSize + 1%>">&gt;&gt;</a>
					<%
						}
					%>
				</div>
			</center>		
			
			
	<div id="content_text">
		<div id=wrap_text>
			<p style="font-weight: bold; font-size: 15px;">소중한 순간을 포착하여 공유해보세요.</p>
			<p style="font-size: 12px;">앱을 다운로드하고 첫 사진이나 동영상을 공유해보세요.</p>
		</div>
	</div>
<%@include file="/footer.jsp" %>
</body>
</html>