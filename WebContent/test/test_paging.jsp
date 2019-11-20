<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int sample_num = 124;

int totalCnt=sample_num;
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

%>

<div>
	총 게시물 숫자 : <%=sample_num %><br/>
	총 페이지 숫자 : <%=totalPage %><br/>
	현재 페이지 : <%=pnum %><br/>
	현재 페이지그룹 번호 : <%=nowPageGroup %><br/>

<%
	if (nowPageGroup != 0) {
%>
	<a href="test.jsp?cp=<%=(nowPageGroup - 1) * pageSize + pageSize%>">&lt;&lt;</a>
<%
	}
%>

<%
	for(int i=nowPageGroup*pageSize+1; i<=nowPageGroup*pageSize+pageSize; i++){
%>
	&nbsp;&nbsp; <a href="test.jsp?pnum=<%=i %>"><%=i %></a> &nbsp;&nbsp;
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
	<a href="test.jsp?pnum=<%=(nowPageGroup + 1) * pageSize + 1%>">&gt;&gt;</a>
<%
}
%>
</div>
<%-- <%
	if (userGroup != 0) {
%>
	<a href="bbsList.jsp?cp=<%=(userGroup - 1) * pageSize + pageSize%>">&lt;&lt;</a>
<%
	}
%>
<%
	for (int i = userGroup * pageSize + 1; i <= userGroup * pageSize + pageSize; i++) {
%>
	&nbsp;&nbsp;<a href="bbsList.jsp?cp=<%=i%>"><%=i%></a>&nbsp;&nbsp;
	<%
		if (i == totalPage)
			break;
		}
	%>
	<%
		if (userGroup != (totalPage / pageSize - (totalPage % pageSize == 0 ? 1 : 0))) {
	%>
	<a href="bbsList.jsp?cp=<%=(userGroup + 1) * pageSize + 1%>">&gt;&gt;</a>
<%
}
%> --%>
</body>
</html>