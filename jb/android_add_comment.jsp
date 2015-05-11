<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/xml; charset=utf-8"%>
<%@page pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	
	String input_id = new String(request.getParameter("id").getBytes("8859_1"),"utf-8");
	String input_comment = new String(request.getParameter("comment").getBytes("8859_1"),"utf-8");
	String input_restaurant = new String(request.getParameter("restaurant").getBytes("8859_1"),"utf-8");
	String input_score = new String(request.getParameter("score").getBytes("8859_1"),"utf-8");
	String nick="임시";
	boolean temp = false;
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");
	Statement stm = con.createStatement();
	ResultSet rs;
	
	String searchNick = "select * from people where id = '"+input_id+"'";
	rs=stm.executeQuery(searchNick);
	
	while(rs.next()){
		nick=rs.getString("nickname");
	}
	
	String addSQL = "insert into commentdb (id,nickname,comment,score,restaurant) values ('"+input_id+"','"
			+nick+"','"+input_comment+"','"+input_score+"','"+input_restaurant+"')";	
	

		%><comment><%
		try{
			stm.executeUpdate(addSQL);
			out.print("true");
		}catch(Exception e){
			out.print(e);
		}
		%></comment>
