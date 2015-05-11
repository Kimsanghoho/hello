<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<title>체크</title>
<script type="text/javascript">
<!--
	function toinsert() {
		location.replace("insertfood.html");

	}
	-->
</script>
</head>
<body bgcolor="#f5f5f5">
<!-- 	<div id='load'
		style='visibility: visible; background-color: #f5f5f5; position: absolute; width: 95%; height: 20px; z-index: 1; border-width: 1px; border-style: none;'>
		<center>
			<img src='loading.gif'><br> <br> <b>음식<br>DB 로딩중...</b> <br>
		</center>
	</div> -->
	<%
/* 		out.flush(); */
		request.setCharacterEncoding("utf-8");
		String a = request.getParameter("id");
		String b = request.getParameter("pass");

		
		
	%>
	<script type="text/javascript">
		document.getElementById('load').style.visibility = "hidden";
	</script>
	<form action="i_adminfood.jsp" method="get">
		<input type="button" value="이전"> <input type="button"
			value="다음">--미완성
	</form>
	<form action="delfood.jsp" method="post">
		<table border="1" bordercolor="black" width="852" align="center">
			<tr bgcolor="white">
				<td width="39" align="center">체크</td>
				<td width="262" align="center">이름</td>
				<td width="155" align="center">종류1</td>
				<td width="220" align="center">종류2</td>
				<td width="152" align="center">평균평점</td>
			</tr>
            <%
String pageNum = request.getParameter("pageNum");
if(pageNum == null){
	pageNum = "1";
}

int listSize = 5;
int currentPage = Integer.parseInt(pageNum);

int lastRow = 0;
int i = 0;
int count=0;



    String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");
		Statement stm = con.createStatement();
	
		ResultSet rs;
		String food = null;
		String group1 = null;
		String group2 = null;
		double score = 0;
		boolean temp = false;
		int colorvalue = 1;
		String strSQL = "SELECT * FROM food";

		rs = stm.executeQuery(strSQL);
	rs.next();
	lastRow = rs.getInt(1);

	
	if(lastRow > 0) {
	while (rs.next()) {
		i++;
			if(currentPage*5-5>i) continue;
					food = rs.getString("name");
					group1 = rs.getString("group1");
					group2 = rs.getString("group2");
					score = 0;
					count++;
					if(count==5) break;
					if (colorvalue == 1) {
						
			%>
			
				

			<tr bgcolor="darkgray">
				<td width="39" align="center"><input type="checkbox"
					name=<%=food%>></td>
				<td width="262" align="center"><%=food%></td>
				<td width="155" align="center"><%=group1%></td>
				<td width="220" align="center"><%=group2%></td>
				<td width="152" align="center"><%=score%></td>
			</tr>
			<%
				colorvalue = 0;
					} else if (colorvalue == 0) {
			%>

			<tr bgcolor="white">
				<td width="39" align="center"><input type="checkbox"
					name=<%=food%>></td>
				<td width="262" align="center"><%=food%></td>
				<td width="155" align="center"><%=group1%></td>
				<td width="220" align="center"><%=group2%></td>
				<td width="152" align="center"><%=score%></td>
			</tr>
            
			<%
				colorvalue = 1;
					}
				}
			%>
            <%	
	rs.close();
	stm.close();
	con.close();

 %>
		</table>
		<br>
		<p>
		<p>&nbsp;</p>

		<p align="center">
			<input type="submit" name="btnDelFood" value="선택제거">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" name="btnAddFood" value="음식추가"
				onclick="toinsert()">
		</p>
	</form>
</body>
</html>