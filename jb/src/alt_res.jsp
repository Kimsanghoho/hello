<%@page import="java.net.URLDecoder"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>

<head>
<title>alt_res</title>

<script language="javascript">
	function returnf() {
		location.replace('i_adminres.jsp');
	}
</script>


</head>
<%
	request.setCharacterEncoding("utf-8");
	String temp_name = request.getParameter("name");
	String name = new String(temp_name.getBytes("ISO-8859-1"),"utf-8");
	
	String foods = null;

	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");
	Statement stm = con.createStatement();
	ResultSet rs;
	String strSQL = "SELECT * FROM restaurant where name ='" + name	+ "'";

	rs = stm.executeQuery(strSQL);

	while (rs.next()) {
		foods = rs.getString("foods");
	}
%>

<body bgcolor="#f5f5f5">
	<form action="i_insertres.jsp" method="post" name="insert_food">
		<table border="1" bordercolor="white" width="448" align="center">
			<tr bgcolor="white" align="center">
				<td width="149" height="24">음식점이름</td>
				<td width="488"><input type="text" size="40" name="name"
					id="name" value=<%=name%>></td>
			</tr>
			<tr bgcolor="white" align="center">
				<td width="149" height="64">취급음식</td>
				<td width="488"><input type="text" size="40" name="foods"
					id="foods" value=<%=foods%>></td>
			</tr>


			<tr bgcolor="white" align="center">
				<td height="24" colspan="2" align="center"><input type="submit"
					align="center" value="수정"> <input type="button"
					align="center" value="목록으로 돌아가기" onClick="returnf()"></td>
			</tr>
		</table>
	</form>
	<p>&nbsp;</p>
	</p>
</body>

</html>