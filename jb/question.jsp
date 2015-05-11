<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>

<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>

<body bgcolor="white">
<center><table border="0"><tr><td>
	<form action="send_question.jsp" method="post" name="send_question">
	<img src="qna_title.jpg" align="left"><br><br><br><br>
	<img src="email.jpg"><br><br>
	<input type="text" name="email" size=60 style="width: 900px"><br><br>
	<img src="questionbody.jpg"><br>
	<br>
	<textarea style="height: 300px; width: 900px" name="question"></textarea>
	<br><br>
	<input type="submit" value=" " style="height: 50px; width: 900px;background: url(qna_submit.jpg)">
	</form>
	</td></tr>
</table>
</center>
</body>

</html>