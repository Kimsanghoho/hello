<%@page import="java.util.Random"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
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
//현재 시간을 nowTime에 저장. (시간만. 24시간 형태로.)/ 날짜를 nowData에 저장.(20141011형태로)
	int nowTime = Integer.parseInt(new SimpleDateFormat("HH").format(new Date()));

//평점 높은순으로 정리 하기위한 클래스랑 어레이리스트
	class RankingLikeGroup{
		String name;
		double score;
	}

	ArrayList<RankingLikeGroup> rankingLikeGroup1 = new ArrayList<RankingLikeGroup>();
	ArrayList<RankingLikeGroup> rankingLikeGroup2 = new ArrayList<RankingLikeGroup>();
	ArrayList<String> like  = new ArrayList<String>();
	ArrayList<String> group1_ranking = new ArrayList<String>();
	ArrayList<String> group2_ranking = new ArrayList<String>();
	ArrayList<String> duplicate_food = new ArrayList<String>();
	ArrayList<String> recommended_food = new ArrayList<String>();
	ArrayList<String> all_food = new ArrayList<String>();
	String str_temp="참";
 	String id = new String(request.getParameter("id").getBytes(
 	"ISO-8859-1"), "utf-8");

// 	out.print("현재시간 : " + nowTime+"시<br>");
// 	out.print("id : " + id + "<br>");
//  out.print("<br>==========================<br>");
 	
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";
	Class.forName(driverName);
	
	Connection con = DriverManager.getConnection(dbURL, "jellybean",
	"jellybean2014");
	Statement stm = con.createStatement();
	Statement stm2 = con.createStatement();
	Statement stm3 = con.createStatement();
	ResultSet rs,sub_rs,recommend_rs;
	
	//컬럼명 받아오기 쿼리문.
	String SQLgetCol = "select COLUMN_NAME from information_schema.COLUMNS	where TABLE_NAME IN ('likedb') And TABLE_SCHEMA='jellybean'";
	rs = stm.executeQuery(SQLgetCol);
	
	//컬럼명 받아서 like arrylist에 저장. id빼고.
	while(rs.next()){
		String temp = rs.getString("COLUMN_NAME");

		if(!temp.equals("id")){
	like.add(temp);

	
//likegroup1 sort.
	String SQLgetScore1 = "select * from likegroup1 where id = '"+id+"'";
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
			for(int i = 0 ; i < ranksize ; i++){
				
				
				if(rlg.score > rankingLikeGroup1.get(i).score){
					rankingLikeGroup1.add(i,rlg);
					break;
				}else if(i==ranksize-1){
					rankingLikeGroup1.add(ranksize,rlg);
					break;
				}
				
				}
			}
		}
		}catch(Exception e){
			//out.print("exption발생1 "+temp+": "+e+" <br>");
			}
//likegroup2 sort.
	String SQLgetScore2 = "select * from likegroup2 where id = '"+id+"'";
	try{
	sub_rs = stm2.executeQuery(SQLgetScore2);
		
	while(sub_rs.next()){
		
		int ranksize = rankingLikeGroup2.size();
		RankingLikeGroup rlg = new RankingLikeGroup();
		rlg.name=temp;
		rlg.score=sub_rs.getDouble(temp);
		
		if(ranksize ==0){
			rankingLikeGroup2.add(rlg);
		}else{
			for(int i = 0 ; i < ranksize ; i++){
				
				
				if(rlg.score > rankingLikeGroup2.get(i).score){
					rankingLikeGroup2.add(i,rlg);
					break;
				}else if(i==ranksize-1){
					rankingLikeGroup2.add(ranksize,rlg);
					break;
				}
				
				
				}
			}
		}
		}catch(Exception e){
			//out.print("exption발생2 "+temp+": "+e+" <br>");
			}



			}
		}
	
//순서대로 정렬되서 잘 나오는지 확인용	
//   	for(int i = 0 ;i<rankingLikeGroup1.size();i++){
//   		out.print(rankingLikeGroup1.get(i).name+" : "+rankingLikeGroup1.get(i).score+"<br>");
//   	}

//   	for(int i = 0 ;i<rankingLikeGroup2.size();i++){
//   		out.print(rankingLikeGroup2.get(i).name+" : "+rankingLikeGroup2.get(i).score+"<br>");
//   	}

// 시간 잘나오는지 확인용
// 	out.print("현재시간 : " + nowTime+"시");

//  	out.print("<br>==========================<br>");
// 	out.print("id : " + id + "<br>");

//랜덤용 모든 데이터 뽑아내서 all_food에 저장.
 	String recommendSQL = "select * from food";
 	recommend_rs=stm.executeQuery(recommendSQL);
 	while(recommend_rs.next()){
 		all_food.add(recommend_rs.getString("name"));
	}
 	
//group1에서 맞는 데이터 뽑아내기 (1위,2위)
 	recommendSQL = "select * from food where group1= '"+rankingLikeGroup1.get(0).name+"'";
 	recommend_rs=stm.executeQuery(recommendSQL);

//  	out.print("<br>==========================<br>");
	
 	while(recommend_rs.next()){
 		group1_ranking.add(recommend_rs.getString("name"));
	}
 	
 	recommendSQL = "select * from food where group1= '"+rankingLikeGroup1.get(1).name+"'";
 	recommend_rs=stm.executeQuery(recommendSQL);
 	
 	while(recommend_rs.next()){
 		group1_ranking.add(recommend_rs.getString("name"));
	}
 	//출력
// 	for(int i = 0 ; i<group1_ranking.size();i++){
// 		out.print(group1_ranking.get(i)+"<br>");
// 	}

//group2에서 맞는 데이터 뽑아내기 (1위,2위)
 	recommendSQL = "select * from food where group2= '"+rankingLikeGroup2.get(0).name+"'";
 	recommend_rs=stm.executeQuery(recommendSQL);
//  	out.print("<br>==========================<br>");
	
 	while(recommend_rs.next()){
	 		group2_ranking.add(recommend_rs.getString("name"));
	}
 	
 	recommendSQL = "select * from food where group2= '"+rankingLikeGroup2.get(1).name+"'";
 	recommend_rs=stm.executeQuery(recommendSQL);
 	
 	while(recommend_rs.next()){
 		group2_ranking.add(recommend_rs.getString("name"));
}
 	//출력
// 	for(int i = 0 ; i<group2_ranking.size();i++){
// 		out.print(group2_ranking.get(i)+"<br>");
// 	}
 	
 	//group1과 group2의 중복값 찾아서 듀플리케이트푸드에 저장.
	for(int i = 0; i< group1_ranking.size();i++){
		for(int j = 0 ; j<group2_ranking.size();j++){
			if(group1_ranking.get(i).equals(group2_ranking.get(j))){
				duplicate_food.add(group1_ranking.get(i));
				
			}
		}
	}
 	//출력
// 	for(int i = 0 ; i<duplicate_food.size();i++){
// 		out.print("중복값 : "+duplicate_food.get(i)+"<br>");
// 	}
 	
 	//랜덤!!
	Random random = new Random();
	int r_all = random.nextInt(all_food.size());
	
	
	recommended_food.add(duplicate_food.get((random.nextInt(duplicate_food.size()))));
	
	for(int tempInt = 0 ; tempInt<3 ;tempInt++){
		String getFood = duplicate_food.get(random.nextInt(duplicate_food.size()));
		
		while(!isNotSame(recommended_food, getFood)){
			getFood = duplicate_food.get(random.nextInt(duplicate_food.size()));
		}

		recommended_food.add(getFood);
		
		}
		

	
	if(recommended_food.size()!=4){
		int size = recommended_food.size();
		for(int i=0; i<4-size;i++){
			String randomfood = all_food.get(random.nextInt(all_food.size()));
			while(!isNotSame(recommended_food, randomfood)){
				randomfood = duplicate_food.get(random.nextInt(duplicate_food.size()));
			}
			recommended_food.add(randomfood);
		}
		str_temp="랜덤값 포함"; 
	}
	
	String allrandomfood = all_food.get(random.nextInt(all_food.size()));
	
	while(!isNotSame(recommended_food, allrandomfood)){
		allrandomfood = duplicate_food.get(random.nextInt(duplicate_food.size()));
	}
	

// 	out.print("<추천>");
// 	out.print("<추천음식>"+duplicate_food.get(r_dupl)+"</추천음식>");
	
// 	out.print("<랜덤음식>"+all_food.get(r_all)+"</랜덤음식>");
// 	out.print("</추천>");
	%><recommend>
	<f1><%=recommended_food.get(0) %></f1>
	<f2><%=recommended_food.get(1) %></f2>
  	<f3><%=recommended_food.get(2) %></f3>  
 	<f4><%=recommended_food.get(3) %></f4>  
	<f5><%=allrandomfood %></f5>
	<temp><%=str_temp %></temp>
	</recommend>