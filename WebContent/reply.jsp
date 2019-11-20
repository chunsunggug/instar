<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="reply_input">
	<form action="semiComment_ok.jsp">
		<input type="text" id="reply_text" placeholder="댓글 달기..." name="r_comment">
		<input type="submit" value="게시" id="reply_ok" disabled="disabled">
	</form>
</div>

<script>
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
		console.log("value >>> " + reply.value);
}
</script>