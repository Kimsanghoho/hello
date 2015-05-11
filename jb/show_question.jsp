<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>

<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<script type="text/javascript">
function go_back() {
	
}
</script>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean",
			"jellybean2014");

	Statement stm = con.createStatement();
	String num = request.getParameter("num");
	
	ResultSet rs;
	
	String email = null;
	String question = null;
	String strSQL = "SELECT * FROM question where num ='"+num+"'";
	
	rs= stm.executeQuery(strSQL);
	
	while(rs.next()){
		email=rs.getString("email");
		question=rs.getString("question");
	}
	
%>

<body bgcolor="white">
	<center>
		<table border="0">
			<tr>
				<td>
						<img src="qna_show.jpg" align="left"><br>
						<br>
						<br> <img src="email.jpg"><br>
						<br> <input type="text" name="email" size=60
							style="width: 700px" value=<%=email %> disabled="disabled"><br>
						<br> <img src="questionbody.jpg"><br> <br>
						<textarea style="height: 300px; width: 700px" name="question" disabled="disabled"><%=question %></textarea>
						<br>
						<br> 
						<div align="right"><input type="button" value="뒤로가기" onClick="script:location.replace('i_question.jsp')"></div>
				</td>
			</tr>
		</table>
	</center>
</body>

</html>