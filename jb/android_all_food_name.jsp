<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/xml; charset=utf-8"
	pageEncoding="utf-8"%>


<%
	String input_id = request.getParameter("input_id");
	String input_pw = request.getParameter("input_pw");
	boolean temp = false;
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");

	Statement stm = con.createStatement();
	ResultSet rs;

	String strSQL = "SELECT * FROM food";

	rs = stm.executeQuery(strSQL);
		%><food><%
	 	while (rs.next()) {
	 		
	 		out.print("<name>");
			out.print(rs.getString("name"));
			out.print("</name>");

	 	}
		%></food>
