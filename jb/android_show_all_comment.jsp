<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/xml; charset=utf-8"
	pageEncoding="utf-8"%>


<%
 	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";
	String strSQL = "";
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean",
			"jellybean2014");

	Statement stm = con.createStatement();
	ResultSet rs;
		//검색하는 쿼리
		strSQL = "SELECT * FROM commentdb order by code desc";
	rs = stm.executeQuery(strSQL);
%><확인용><%
 	while (rs.next()) {
 		out.print("<comment>");
 		
	 		out.print("<입력순서>");
	 		out.print(rs.getString("code"));
	 		out.print("</입력순서>");	
 		
	 		out.print("<nick>");
	 		out.print(rs.getString("restaurant"));
	 		out.print("</nick>");	
	 		
	 		out.print("<nick>");
	 		out.print(rs.getString("nickname"));
	 		out.print("</nick>");
 		
	 		out.print("<sub>");
	 		out.print(rs.getString("comment"));
	 		out.print("</sub>");
 		
	 		out.print("<score>");
	 		out.print(rs.getString("score"));
	 		out.print("</score>");
	 		
	 	out.print("</comment>");
 	}
 %> </확인용>
