<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/instargram/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/instargram/css/history_modalLayout.css?after">
</head>
<style>
#preview{
	width: 500px;
	margin: 20px auto;
 	display: grid;
  	grid-template-columns: auto auto;
  	grid-gap: 3px;
 	background-color: #f2f2f2;

}

#image1, #image2,#image3,#image4{
	width: 100%;
}
#content{
	width: 500px;
	margin: 20px auto;	
}

label, button{ 
display: inline-block; 
padding: .5em .75em; 
color: #4da6ff; 
font-size: inherit; 
line-height: normal; 
vertical-align: middle; 
background-color: #fdfdfd; 
cursor: pointer; 
border: 1px solid #ebebeb; 
border-bottom-color: #e2e2e2; 
border-radius: .25em;
}
 
#file1,#file2,#file3,#file4[type="file"]{
position: absolute;
width: 1px;
height: 1px;
padding: 0;
margin: -1px; 
overflow: hidden; 
clip:rect(0,0,0,0); 
border: 0;
}
#tag{
	width: 310px;
	height: 30px;
	text-align: left;
}
#con{
width: 495px;
margin: 10px auto;
height: 200px;
}
#Btn{
	margin-left: 40%;
	display: inline-block; 
padding: .5em .75em; 
color: white; 
font-size: inherit; 
line-height: normal; 
vertical-align: middle; 
background-color: #4da6ff; 
cursor: pointer; 
border: 1px solid #ebebeb; 
border-bottom-color: #e2e2e2; 
border-radius: .25em;
	
}
</style>
<body>
	<%@include file="/header.jsp"%>
	<%
	System.out.println("대가리 id 확인 : "+id);
	%>
	<section>
		<article>
			<form name="semiWrite" action="semiWrite_ok.jsp" method="post" enctype="multipart/form-data">
				<div id="preview">
					<img src="/instargram/icon/up.png" id="image1" />
					<img src="/instargram/icon/up.png" id="image2" />
					<img src="/instargram/icon/up.png" id="image3" />
					<img src="/instargram/icon/up.png" id="image4" />
				</div>
				<div id="content">
					<input type="hidden" name="id" value="<%=id %>" />
					<input type="hidden" name="nickname" value="<%=nickname %>" />
					<input type="text" id="tag" placeholder="사람 테그하기">
					<button id="serch">검색</button>
					<label for="file1">이미지 첨부1</label>
					<input id="file1" name="mainimg" type="file">
					<label for="file2">이미지 첨부2</label>
					<input id="file2" name="subimg1" type="file">	
					<label for="file3">이미지 첨부3</label>
					<input id="file3" name="subimg2" type="file">
					<label for="file4">이미지 첨부4</label>
					<input id="file4" name="subimg3" type="file">									
					<input type="text" name="content" id="con" placeholder="내용입력">
					
					<input type="submit" id="Btn" value="공유하기">
				</div>
			</form>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
<script>
	//이미지 미리보기 스크립트
	document.getElementById("file1").onchange = function() {
		var reader = new FileReader();

		reader.onload = function(e) {
			document.getElementById("image1").src = e.target.result;
		};
		reader.readAsDataURL(this.files[0]);
	};
	document.getElementById("file2").onchange = function() {
		var reader = new FileReader();

		reader.onload = function(e) {
			document.getElementById("image2").src = e.target.result;
		};
		reader.readAsDataURL(this.files[0]);
	};
	document.getElementById("file3").onchange = function() {
		var reader = new FileReader();

		reader.onload = function(e) {
			document.getElementById("image3").src = e.target.result;
		};
		reader.readAsDataURL(this.files[0]);
	};
	document.getElementById("file4").onchange = function() {
		var reader = new FileReader();

		reader.onload = function(e) {
			document.getElementById("image4").src = e.target.result;
		};
		reader.readAsDataURL(this.files[0]);
	};	
</script>
</html>