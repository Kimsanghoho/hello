<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.File"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>

<head>
<title>alt_res</title>
</head>
<%
		request.setCharacterEncoding("utf-8");
		String email = request.getParameter("email");
		String question = request.getParameter("question");	
		
		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");
		Statement stm = con.createStatement();
		String strSQL = "insert into question (email,question) values('"+ email + "','"+question+"')";

		stm.executeUpdate(strSQL);


	%>
<script type="text/javascript">
alert("질문이 등록되었습니다.\n적어주신 이메일로 조속히 답변드리겠습니다.");
location.replace('question.jsp');
</script>