<%@page import="java.util.ArrayList"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<body bgcolor="#EAEAEA">

	<%
		boolean ok = true;
		request.setCharacterEncoding("utf-8");
		String id = new String(request.getParameter("id").getBytes(
				"ISO-8859-1"), "utf-8");
		String foods = new String(request.getParameter("foods").getBytes(
				"ISO-8859-1"), "utf-8");

		//  	 	String id = request.getParameter("id");
		//  	 	String foods = request.getParameter("foods");
		// 	out.print(id);
		
		//--취향 재조사를위한 초기화.
		String initdriverName = "org.gjt.mm.mysql.Driver";
		String initdbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";
		Class.forName(initdriverName);
		Connection initcon = DriverManager.getConnection(initdbURL,	"jellybean", "jellybean2014");
		Statement initstm = initcon.createStatement();
		String initquery = "update likedb set 밥 = 0,면=0,빵=0,고기=0,반찬=0,떡=0,한식=0,중식=0,양식=0,분식=0,일식=0 where id ='"
				+ id + "'";
		initstm.executeUpdate(initquery);
		//--
		String food[];
		food = foods.split(",");
		for (int i = 0; i < food.length; i++) {
			String group1 = "";
			String group2 = "";
			double group1score = 0.0, group2score = 0.0;
			String updatequery = "";
			String name = food[i].split("-")[0];
			String score = food[i].split("-")[1];
			//이름이랑 스코어 잘받아오는지 확인용		
			//  			 	 		out.print(name+"/");
			//  			 	 		out.print(score+"_");
			//  			 	 		out.print(id);
			//  					out.print("<br>");

			//해당음식의 그룹(면류,중식,고기같은거) 확인
			String driverName = "org.gjt.mm.mysql.Driver";
			String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";
			Class.forName(driverName);
			Connection con = DriverManager.getConnection(dbURL,
					"jellybean", "jellybean2014");
			Statement stm = con.createStatement();
			ResultSet rs;
			String strSQL = "SELECT * FROM food where name ='" + name + "'";
			rs = stm.executeQuery(strSQL);

			while (rs.next()) {
				group1 = rs.getString("group1");
				group2 = rs.getString("group2");
			}
			//그룹을 잘 받아오는지 확인용		
			//  						out.print(group1+"/");
			//  						out.print(group2+"/");

			String strSQL2 = "SELECT * FROM likedb where id ='" + id + "'";
			rs = stm.executeQuery(strSQL2);

			while (rs.next()) {
				group1score = rs.getDouble(group1);
				group2score = rs.getDouble(group2);
			}
			// 						out.print(group1score+"/");
			// 						out.print(group2score+"/");
			group1score += Double.parseDouble(score);
			group2score += Double.parseDouble(score);
			//그룹 점수 잘받아오는지 확인용.
			//  						out.print(group1score+"/");
			//  						out.print(group2score);
			//  						out.print("<br>");

			updatequery = "update likedb set " + group1 + "=" + group1score
					+ "," + group2 + "=" + group2score + " where id ='"
					+ id + "'";
			try {
				stm.executeUpdate(updatequery);
				//  				 	 		out.print("완료!");
			} catch (Exception e) {
				//  				out.print(e);
				ok = false;
			}
			//  			 		out.print("완료!");
		}

		if (ok) {
	%>
	<center>
		<img src="./loading.gif"><br>
	</center>
	<%
		} else {
			out.print("오류발생!");
		}
	%>
</body>