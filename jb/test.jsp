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
	</div> -->
	<%
		request.setCharacterEncoding("utf-8");
		String path = application.getRealPath("/jb/foodimg/");
		MultipartRequest multi = new MultipartRequest(request, path,
				1024 * 1024 * 1, "utf-8", new DefaultFileRenamePolicy());
		
		out.print(multi.getParameter("sfile"));
	%>
	<script type="text/javascript">
		alert("업로드완료!");
	</script>



</body>
</html>