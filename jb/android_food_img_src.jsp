<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
	<%
		String url = "./foodimg/noimg.png";
		String input_food;
		String path = application.getRealPath("/foodimg/");
		
		boolean temp = false;
		if (request.getParameter("foodname") == null) {
			input_food = "nodata";
		}
		else {
			input_food = new String(request.getParameter("foodname").getBytes("ISO-8859-1"),"utf-8");
		}

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
				out.print("http://jellybean.dongyangmirae.kr/foodimg/"+code+".png");
			}else{
				out.print("http://jellybean.dongyangmirae.kr/foodimg/noimg.png");
			}
		}
		if(!temp){
			out.print("http://jellybean.dongyangmirae.kr/foodimg/noimg.png");
		}
	%>