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
	</div>   -->
	<%
/*  		out.flush();  */

		request.setCharacterEncoding("utf-8");


		String path = application.getRealPath("/resimg/");
		
		MultipartRequest multi = new MultipartRequest(request, path, 1024 * 1024 * 20, "utf-8", new DefaultFileRenamePolicy());
		
		String name = multi.getParameter("name");
		String foods = multi.getParameter("foods");
		String addr =multi.getParameter("addr");
		String tel =multi.getParameter("tel");	
		String intro =multi.getParameter("intro");
		
		String filecode = null;
		
		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";
		
		double lng = 126.867796;
		double lat = 37.500399;
		
		String strSQL = "insert into restaurant (name,foods,lat,lng,addr,tel,intro) values('"
				+ name + "','" + foods + "','" + lat + "','" + lng + "','" +addr+"','"+tel+"','"+intro+"')";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");

		Statement stm = con.createStatement();		
		stm.executeUpdate(strSQL);
		
		ResultSet rs;
		strSQL = "select * from restaurant where name = '"+name+"'";
		
		rs = stm.executeQuery(strSQL);
		while( rs.next()){
			filecode = rs.getString("code");
		}

		try {
			if (multi.getFilesystemName("imgfile") != null) {
				String fileName = multi.getFilesystemName("imgfile");
				File f = new File(path, fileName);
				File nameChangedFile = new File(path, filecode + ".png");
				f.renameTo(nameChangedFile);
			}
	%>
	<script type="text/javascript">
/* 		document.getElementById('load').style.visibility = "hidden"; */
		alert("음식점 추가가 완료되었습니다.\n위치설정을 해주세요.");
		location.replace('viewmap.jsp?name=<%=name%>&lat=<%=lat%>&lng=<%=lng%>');
	</script>
	<%
		} catch (Exception e) {
			out.print(name);
			out.print(foods);
			out.print(e);
			
		}
	%>


</body>
</html>