<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<title>체크</title>
</head>
<body bgcolor="#f5f5f5">
<!--  	<div id='load'
		style='visibility: visible; background-color: #f5f5f5; position: absolute; width: 95%; height: 20px; z-index: 1; border-width: 1px; border-style: none;'>
		<center>
			<img src='loading.gif'><br> <br> <b><font color="blue">DB 삽입중...</font></b> <br>
		</center>
	</div>  -->
	<%
/* 		out.flush(); */
		request.setCharacterEncoding("utf-8");

		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		String name =new String(request.getParameter("name").getBytes(
				"ISO-8859-1"), "utf-8");
		
		
		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");

		Statement stm = con.createStatement();

		String strSQL = "update restaurant set lat="+lat+",lng="+lng+" where name ='"+name+"'";

		try {
			stm.executeUpdate(strSQL);
	%>
	<script type="text/javascript">
/* 		document.getElementById('load').style.visibility = "hidden"; */
		alert("성공!");
		location.replace('i_adminres.jsp');
	</script> 
	<%
		} catch (Exception e) {
			out.print(e.getMessage());
		}
	%>


</body>
</html>