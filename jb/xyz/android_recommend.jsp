<%@page import="java.util.Date"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>


<%
	class RankingLikeGroup{
		String name;
		double score;
	}
	
	ArrayList<RankingLikeGroup> rankingLikeGroup1 = new ArrayList<RankingLikeGroup>();
	ArrayList<RankingLikeGroup> rankingLikeGroup2 = new ArrayList<RankingLikeGroup>();
	ArrayList<String> like  = new ArrayList<String>();
	
	String id = new String(request.getParameter("id").getBytes(
	"ISO-8859-1"), "utf-8");

	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";
	Class.forName(driverName);
	
	Connection con = DriverManager.getConnection(dbURL, "jellybean",
	"jellybean2014");
	Statement stm = con.createStatement();
	Statement stm2 = con.createStatement();
	ResultSet rs,sub_rs;
	
	//컬럼명 받아오기 쿼리문.
	String SQLgetCol = "select COLUMN_NAME from information_schema.COLUMNS	where TABLE_NAME IN ('likedb') And TABLE_SCHEMA='jellybean'";
	rs = stm.executeQuery(SQLgetCol);
	
	//컬럼명 받아서 like arrylist에 저장. id빼고.
	while(rs.next()){
		String temp = rs.getString("COLUMN_NAME");

		if(!temp.equals("id")){
	like.add(temp);
	String SQLgetScore1 = "select * from likegroup1 where id = '"+id+"'";
	String SQLgetScore2 = "select * from likegroup2 where id = '"+id+"'";
	
	
	try{
	sub_rs = stm2.executeQuery(SQLgetScore1);
		
	while(sub_rs.next()){
		
		int ranksize = rankingLikeGroup1.size();
		RankingLikeGroup rlg = new RankingLikeGroup();
		rlg.name=temp;
		rlg.score=sub_rs.getDouble(temp);
		
		if(ranksize ==0){
			rankingLikeGroup1.add(rlg);
		}else{
			for(int i = 0 ; i <= ranksize ; i++){
				if(i==ranksize){
					rankingLikeGroup1.add(i,rlg);
					break;
				}
				
				if(rlg.score > rankingLikeGroup1.get(i).score){
					rankingLikeGroup1.add(i,rlg);
					if(i== ranksize-1){
						break;
					}
				}
				
				}
			}
		}
		}catch(Exception e){
			//out.print("exption발생 "+temp+"<br>");
			}
		
			}
		}
	
 	for(int i = 0 ;i<rankingLikeGroup1.size();i++){
 		out.print(rankingLikeGroup1.get(i).name+" : "+rankingLikeGroup1.get(i).score+"<br>");
 	}
	
	int nowTime = Integer.parseInt(new SimpleDateFormat("HH").format(new Date()));
	out.print(nowTime);
	
// 	for(int i = 0 ; i<like.size();i++){
// 		out.print(i +" "+ like.get(i)+"<br>");
// 	}
%>