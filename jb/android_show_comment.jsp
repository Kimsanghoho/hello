<%@page import="java.text.DecimalFormat"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/xml; charset=utf-8"
	pageEncoding="utf-8"%>


<%
	double avg=0.0, sum=0;
	int num=0;
	boolean isNotEmpty=false;
	DecimalFormat df = new DecimalFormat("#.##");
	
	
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
		strSQL = "SELECT * FROM commentdb where restaurant ='"+resName+"' order by code desc";
	rs = stm.executeQuery(strSQL);
%><comments><%
 	while (rs.next()) {
 		out.print("<comment>");
 		
	 		out.print("<nick>");
	 		out.print(rs.getString("nickname"));
	 		out.print("</nick>");
 		
	 		out.print("<sub>");
	 		out.print(rs.getString("comment"));
	 		out.print("</sub>");
 		
	 		out.print("<score>");
	 		sum += rs.getDouble("score");
	 		out.print(rs.getString("score"));
	 		out.print("</score>");
	 		
	 	out.print("</comment>");
	 	num++;
	 	isNotEmpty=true;
 	}
	out.print("<number>");
	out.print(num);
	out.print("</number>");

	if(isNotEmpty){
	avg=sum/num;
	out.print("<avg>");
	out.print(df.format(avg));
	out.print("</avg>");
	}else{
		out.print("<avg>");
		out.print("0.0");
		out.print("</avg>");
	}
 %> </comments>
