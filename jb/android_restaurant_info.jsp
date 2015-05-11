<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/xml; charset=utf-8"
	pageEncoding="utf-8"%>


<%
 	String resName = new String(request.getParameter("res").getBytes("8859_1"), "utf-8");
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";
	String strSQL = "";
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean",
			"jellybean2014");

	Statement stm = con.createStatement();
	ResultSet rs;
		//검색하는 쿼리
		strSQL = "SELECT * FROM restaurant where name ='"+resName+"'";
	rs = stm.executeQuery(strSQL);
%><info><%
 	while (rs.next()) {
 		out.print("<name>");
 		out.print(rs.getString("name"));
 		out.print("</name>");
 		
 		out.print("<foods>");
 		out.print(rs.getString("foods"));
 		out.print("</foods>");
 		
 		out.print("<lat>");
 		out.print(rs.getString("lat"));
 		out.print("</lat>");
 		
 		out.print("<lng>");
 		out.print(rs.getString("lng"));
 		out.print("</lng>");
 		
 		out.print("<addr>");
 		out.print(rs.getString("addr"));
 		out.print("</addr>");
 		
 		out.print("<tel>");
 		out.print(rs.getString("tel"));
 		out.print("</tel>");
 		
 		out.print("<intro>");
 		out.print(rs.getString("intro"));
 		out.print("</intro>");
 		
 		out.print("<code>");
 		out.print(rs.getString("code"));
 		out.print("</code>");
 	}
 %> </info>
