<%@page import="java.sql.*"%>
<%@page import="java.io.File"%>

<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<html>

<head>
<title>alt_res_set</title>

<script language="javascript">
	function returnf() {
		location.replace('i_adminres.jsp');
	}
</script>


</head>
<%
		request.setCharacterEncoding("utf-8");

			String path = application.getRealPath("/resimg/");
			
			MultipartRequest multi = new MultipartRequest(request, path,
					1024 * 1024 * 20, "utf-8", new DefaultFileRenamePolicy());
			
			String name = multi.getParameter("name");
			String foods = multi.getParameter("foods");
			String tel = multi.getParameter("tel");
			String intro = multi.getParameter("intro");
			String addr = multi.getParameter("addr");
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
			
			String strSQL = "update restaurant set foods='"+foods+"',tel='"+tel+"',intro='"+intro+"',addr='"+addr+"' where name ='"+name+"'";
			
			try {
				stm.executeUpdate(strSQL);
			%>
			<script type="text/javascript">
			/* 		document.getElementById('load').style.visibility = "hidden"; */
			alert("완료!");
			location.replace('i_adminres.jsp');
			</script>
			<%
			} catch (Exception e) {
				out.print(code+"<br>"+e);
			}
			%>
	
	