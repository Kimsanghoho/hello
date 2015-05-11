<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
	function goToResult() {
		location.replace('result.jsp');
	}
</script>
<head>
<title></title>
</head>
<%
	request.setCharacterEncoding("utf-8");

	String str_1st = request.getParameter("1st");
	String str_2nd = request.getParameter("2nd");
	String str_3rd = request.getParameter("3rd");
	String str_4th = request.getParameter("4th");
	String str_5th = request.getParameter("5th");
	String str_6th = request.getParameter("6th");

	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean",
			"jellybean2014");

	Statement stm = con.createStatement();

	String SQL1 = "insert into temp01 (1st,2nd,3rd,4th,5th,6th) values ('"
			+ str_1st
			+ "','"
			+ str_2nd
			+ "','"
			+ str_3rd
			+ "','"
			+ str_4th + "','" + str_5th + "','" + str_6th + "')";
	
	
	stm.executeUpdate(SQL1);
%>


<body>
	<center>
		<%-- 
<%=str_1st %><br>
<%=str_2nd %><br>
<%=str_3rd %><br>
<%=str_4th %><br>
<%=str_5th %><br>
<%=str_6th %><br>
 --%>
		투표에 성공해씀다!<br>
		<button type="button" onclick="goToResult()">결과보기</button>
	</center>
</body>
</html>