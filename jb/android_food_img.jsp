<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8;">
</head>
<body bgcolor="#f2f2f2">
	<%
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		String url = "./foodimg/noimg.png";
		String input_food;
		String path = application.getRealPath("/foodimg/");
		
		boolean temp = false;
		if (request.getParameter("foodname") == null) {
			input_food = "nodata";
		}
		//한글처리용 인코딩, 디코딩으로 처리가 안됨. 이걸로 처리.
		input_food = new String(request.getParameter("foodname").getBytes("ISO-8859-1"),"utf-8");

		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");

		Statement stm = con.createStatement();
		ResultSet rs;

		String strSQL = "SELECT * FROM food where name ='" + input_food	+ "'";

		rs = stm.executeQuery(strSQL);
		while (rs.next()) {
			temp=true;
			String code = rs.getString("code");
			File f = new File(path,code+".png");
			if(f.isFile()){
				out.print("<img width='95%' height='95%' src='./foodimg/"+code+".png'>");
			}else{
				out.print("<img width='95%' height='95%' src='./foodimg/noimg.png'>");
			}
		}
		if(!temp){
			out.print("<img width='95%' height='95%' src='./foodimg/noimg.png'>");
		}
	%> 
	


</body>
</html>