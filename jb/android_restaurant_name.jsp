<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/xml; charset=utf-8"
	pageEncoding="utf-8"%>

<%!
	public boolean isNotSame(ArrayList<String> list,String str){
	
		int size = list.size();
		
		for(int i = 0 ; i < size ; i++){
			if(list.get(i).equals(str)) return false;
		}
		
		return true;
}
%>
<%
//	request.setCharacterEncoding("utf-8");
//	String input_food = request.getParameter("food");
	ArrayList<String> list = new ArrayList<String>();
 	String input_food = new String(request.getParameter("food").getBytes("8859_1"), "utf-8");
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";
	String strSQL = "";
	String strSQL2 = "";
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean",
			"jellybean2014");

	Statement stm = con.createStatement();
	ResultSet rs;
	Statement stm2 = con.createStatement();
	ResultSet rs2;
	if (input_food.equals("all") || input_food.isEmpty()) {
		strSQL = "SELECT name FROM restaurant";
	} else {
		//검색하는 쿼리
		strSQL = "SELECT name FROM restaurant where foods like '%"
				+ input_food + "%'";
	}
	rs = stm.executeQuery(strSQL);
	strSQL2 = "SELECT name FROM restaurant where name like '%"
			+ input_food + "%'";
	rs2 = stm2.executeQuery(strSQL2);
	
%><restaurants><%
 	while (rs.next()) {
 		out.print("<restaurant>");
 		out.print(rs.getString("name"));
 		out.print("</restaurant>");
 		list.add(rs.getString("name"));
 	}
	while (rs2.next()) {
		if(isNotSame(list, rs2.getString("name"))){
	 		out.print("<restaurant>");
	 		out.print(rs2.getString("name"));
	 		out.print("</restaurant>");
		}
 	}
 %> </restaurants>
