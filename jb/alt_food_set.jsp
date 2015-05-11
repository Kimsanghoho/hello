<%@page import="java.sql.*"%>
<%@page import="java.io.File"%>

<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<html>
<head>
<title>체크</title>
</head>
<body bgcolor="#f5f5f5">
<!-- 	<div id='load'
		style='visibility: visible; background-color: #f5f5f5; position: absolute; width: 95%; height: 20px; z-index: 1; border-width: 1px; border-style: none;'>
		<center>
			<img src='loading.gif'><br> <br> <b><font
				color="blue">DB 삽입중...</font></b> <br>
		</center>
	</div>  -->
	<%
/* 		out.flush(); */

		request.setCharacterEncoding("utf-8");
		
		String path = application.getRealPath("/foodimg/");

		MultipartRequest multi = new MultipartRequest(request, path,
				1024 * 1024 * 20, "utf-8", new DefaultFileRenamePolicy());

		String food = multi.getParameter("food");
		String g1 = multi.getParameter("group1");
		String g2 = multi.getParameter("group2");
		String code = multi.getParameter("code");

 		if (multi.getFilesystemName("imgfile") != null) {
			File delf = new File(path, code + ".png");
			if( delf.exists()) delf.delete();
			
			String fileName = multi.getFilesystemName("imgfile");
			File f = new File(path, fileName);
			File nameChangedFile = new File(path, code + ".png");
			f.renameTo(nameChangedFile);
		}

		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");

		Statement stm = con.createStatement();

		String strSQL = "update food set group1='"+g1+"', group2='"+g2+"' where code = '"+code+"'";

		try {
			stm.executeUpdate(strSQL);
	%>
	<script type="text/javascript">
/* 		document.getElementById('load').style.visibility = "hidden"; */
		alert("완료!");
		location.replace('i_adminfood.jsp');
	</script>
	<%
		} catch (Exception e) {
			out.print(code+"<br>"+e);
		}
	%>


</body>
</html>