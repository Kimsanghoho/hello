<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/xml; charset=utf-8"
	pageEncoding="utf-8"%>


<%
	response.setCharacterEncoding("utf-8");
	String input_nick = request.getParameter("input_nickname");
	boolean temp = false;
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");

	Statement stm = con.createStatement();
	ResultSet rs;

	String strSQL = "SELECT * FROM people where nickname='"+input_nick+"'";

	rs = stm.executeQuery(strSQL);
%><check><%
 	try{
   	 	while (rs.next()) {
   	 		
		   	if(input_nick.equals(rs.getString("nickname"))){
		   		out.print("false");
		   		temp=true;
		   	}
   	 	}
   	 	if(temp!=true){
   	 		out.print("true");
   	 	}
   	}catch(Exception e){
   		out.print(e);
   	}
 %></check>
