<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<%!ArrayList<String> data =new ArrayList<String>();	 %>
<title>체크</title>
</head>
<body bgcolor="#f5f5f5">
<!-- 	<div id='load'
		style='visibility: visible; background-color: #f5f5f5; position: absolute; width: 95%; height: 20px; z-index: 1; border-width: 1px; border-style: none;'>
		<center>
			<img src='loading.gif'><br> <br> <b><font color="red">DB 제거중...</font></b> <br>
		</center>
	</div> -->
	<%
/* 		out.flush(); */
		request.setCharacterEncoding("utf-8");
		
		Enumeration<String> e = request.getParameterNames();
		while(e.hasMoreElements()){
			 String name= (String) e.nextElement();
			 if(!name.equals("btnDelFood")){
				 data.add(name);
			 }
		}
		
		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");

		Statement stm = con.createStatement();
		
		try {
			for(int i = 0;i<data.size();i++){
				String strSQL = "delete from food where name = '"+data.get(i)+"'";
				stm.executeUpdate(strSQL);
			}
			%>
	<script type="text/javascript">
/* 		document.getElementById('load').style.visibility = "hidden"; */
		alert("음식점 제거에 성공했습니다.");
		location.replace('i_adminres.jsp');
	</script>
	<%
		}catch (Exception except) {
			out.print(except);
		} 


	%>


</body>
</html>