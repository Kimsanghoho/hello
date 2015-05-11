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
<body bgcolor="white">
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

	<form action="delfood.jsp" method="post">
		<table border="1" bordercolor="black" width="852" align="center">
			<tr bgcolor="white">
				<td width="35" align="center">체크</td>
				<td width="262" align="center">이름</td>
				<td width="155" align="center">종류1</td>
				<td width="220" align="center">종류2</td>
				<td width="152" align="center">상세정보</td>
			</tr>
			<%
				String pageNum = request.getParameter("pageNum");
				if (pageNum == null) {
					pageNum = "1";
				}
				
				int listSize = 10;
				int currentPage = Integer.parseInt(pageNum);
				int maxPage;
				int rssize=0;
				int i = 0;
				int count = 0;

				String driverName = "org.gjt.mm.mysql.Driver";
				String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

				Class.forName(driverName);
				Connection con = DriverManager.getConnection(dbURL, "jellybean",
						"jellybean2014");
				Statement stm = con.createStatement();

				ResultSet rs;
				String food = null;
				String group1 = null;
				String group2 = null;
				boolean temp = false;
				int colorvalue = 1;
				String strSQL = "SELECT * FROM food";

				rs = stm.executeQuery(strSQL);
				
				//최대 페이지수 구하기.				
				while(rs.next()){
					rssize++;
				}
				

				
				if(rssize%10==0){
					maxPage=rssize/10;
				}else{
					maxPage=(rssize/10)+1;
				}
				
				rs.first();				

				

				do{
					i++;
					if (currentPage * listSize - listSize >= i)
						continue;
					food = rs.getString("name");
					group1 = rs.getString("group1");
					group2 = rs.getString("group2");
					
					count++;
					if (count == listSize+1)
						break;
					String alt_res_uri="alt_food.jsp?name="+food;
					if (colorvalue == 1) {
			%>



			<tr bgcolor="darkgray">
				<td width="35" align="center"><input type="checkbox"
					name=<%=food%>></td>
				<td width="262" align="center"><%=food%></td>
				<td width="155" align="center"><%=group1%></td>
				<td width="220" align="center"><%=group2%></td>
				<td width="152" align="center"><input type="button" value="확인/수정" onclick="script:location.replace('<%=alt_res_uri%>')"></td>
			</tr>
			<%
				colorvalue = 0;
					} else if (colorvalue == 0) {
			%>

			<tr bgcolor="white">
				<td width="35" align="center"><input type="checkbox"
					name=<%=food%>></td>
				<td width="262" align="center"><%=food%></td>
				<td width="155" align="center"><%=group1%></td>
				<td width="220" align="center"><%=group2%></td>
				<td width="152" align="center"><input type="button" value="확인/수정" onclick="script:location.replace('<%=alt_res_uri%>')"></td>
			</tr>

			<%
				colorvalue = 1;
					}
				}while (rs.next());
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
	<table width="852">
	<tr>
	<%
		if (currentPage > 1) {
	%>


<td align="left">
	<input type="button" name="btnAddFood" value="이전페이지" onClick="script:location.replace('i_adminfood.jsp?pageNum=<%=currentPage - 1%>')">
</td>	<%
		}
 		if(currentPage < maxPage) 
		{
	%>
<td align="right">
	<input type="button" name="btnAddFood" value="다음페이지" onClick="script:location.replace('i_adminfood.jsp?pageNum=<%=currentPage + 1%>')">
</td>
</table>
	<%
		}
	%>

</body>
</html>