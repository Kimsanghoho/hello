<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/xml; charset=utf-8"%>
<%@page pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	
	String input_id = new String(request.getParameter("id").getBytes("8859_1"),"utf-8");
	String input_pw = new String(request.getParameter("pw").getBytes("8859_1"),"utf-8");
	String input_nn = new String(request.getParameter("nickname").getBytes("8859_1"),"utf-8");
	String input_email = new String(request.getParameter("email").getBytes("8859_1"),"utf-8");
	
	boolean temp = false;
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");
	Statement stm = con.createStatement();

	String joinSQL = "insert into people (id,pw,nickname,email,admin) values ('"+input_id+"','"
			+input_pw+"','"+input_nn+"','"+input_email+"','no')";
	String joinSQL2 = "insert into likedb (id) values ('"+input_id+"')";	
	

		%><join><%
		try{
			stm.executeUpdate(joinSQL);
			stm.executeUpdate(joinSQL2);
			out.print("true");
		}catch(Exception e){
			out.print(e);
		}
		%></join>
