<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/xml; charset=utf-8"
	pageEncoding="utf-8"%>


<%
	String input_id = request.getParameter("id");
	String email = request.getParameter("email");
	boolean temp = false;
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");

	Statement stm = con.createStatement();
	ResultSet rs;

	String strSQL = "SELECT * FROM people where (id='"+input_id+"' and email='"+email+"')";

	rs = stm.executeQuery(strSQL);
%><find><%
 	try{
   	 	while (rs.next()) {
   	 		
		   	if(input_id.equals(rs.getString("id"))){
		   		out.print(rs.getString("pw"));
		   		temp=true;
		   	}
   	 	}
   	 	if(temp!=true){
   	 		out.print("!false");
   	 	}
   	}catch(Exception e){
   		out.print(e);
   	}
 %></find>
