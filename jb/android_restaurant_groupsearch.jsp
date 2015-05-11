<%@page import="java.util.ArrayList"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/xml; charset=utf-8"
	pageEncoding="utf-8"%>
<%!
public boolean isNotduplicate(ArrayList<String> list,String str){

	int size = list.size();
	if(size==0) return true;
	
	for(int i = 0 ; i < size ; i++){
		if(list.get(i).equals(str)) return false;
	}
	
	return true;
}
%>

<%
//	request.setCharacterEncoding("utf-8");
//	String input_food = request.getParameter("food");
 	String input_group = new String(request.getParameter("group").getBytes("8859_1"), "utf-8");
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";
	String strSQL = "";
	ArrayList<String> food = new ArrayList<String>();
	ArrayList<String> res = new ArrayList<String>();
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean",
			"jellybean2014");

	Statement stm = con.createStatement();
	ResultSet rs;
	if (input_group.equals("all") || input_group.isEmpty()) {
		strSQL = "SELECT name FROM restaurant";
	} else {
		//검색하는 쿼리
		strSQL = "SELECT * FROM food where group1 like '%"
				+ input_group + "%'";
	}
	rs = stm.executeQuery(strSQL);
	
	while (rs.next()) {
 		food.add(rs.getString("name"));
 	}
	for(int i = 0;i<food.size();i++){
		
		ResultSet inner_rs;
		Statement inner_stm = con.createStatement();
		String inner_SQL = "SELECT * FROM restaurant where foods like '%" + food.get(i) + "%'";
		inner_rs = inner_stm.executeQuery(inner_SQL);
		
		while (inner_rs.next()) {
			String result_name = inner_rs.getString("name");
			if(isNotduplicate(res,result_name)){
				res.add(result_name);
	 		}
	 	}
	}

	
	
%><restaurants><%
  	for(int i =0;i<res.size();i++){
 		out.print("<restaurant>");
 		out.print(res.get(i));
 		out.print("</restaurant>");
 	}
 %> </restaurants>
