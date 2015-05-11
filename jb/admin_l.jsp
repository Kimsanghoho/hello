<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body bgcolor="#f5f5f5">
<!-- 	<div id='load'
		style='visibility: visible; background-color: #f5f5f5; position: absolute; width: 95%; height: 20px; z-index: 1; border-width: 1px; border-style: none;'>
		<center>
			<img src='loginLoading.gif'><br> <br> <b>로그인중입니다.</b>
			<br>
		</center>
	</div> -->
	<%
/* 		out.flush(); */
		request.setCharacterEncoding("utf-8");
		String a = request.getParameter("id");
		String b = request.getParameter("pass");

		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");

		Statement stm = con.createStatement();
		ResultSet rs;
		String id = null;
		String pw = null;
		boolean temp = false;
		String strSQL = "SELECT * FROM people where admin='yes'";

		rs = stm.executeQuery(strSQL);

		while (rs.next()) {
			id = rs.getString("id");
			pw = rs.getString("pw");
			if (a.equals(id) && b.equals(pw)) {
				temp = true;
				break;
			}
		}

		if (temp) {
	%>

	<script type="text/javascript">
		alert("로그인에 성공하였습니다.");
		parent.frames[0].location.replace('a_2_admin.jsp');
		parent.frames[1].location.replace('adminver.jsp');
		parent.frames[2].location.replace('adminCus.html');

		</script>

	<%
		} else {
	%>

	<script type="text/javascript">
		parent.frames[2].location.replace('login.html');
		alert("ID와 비번을 확인해주세요!!");
	</script>

	<%
		}
	%>


</body>
</html>