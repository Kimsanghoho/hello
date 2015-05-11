<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<title>체크</title>
</head>
<body bgcolor="white">
<!-- 	<div id='load'
		style='visibility: visible; background-color: #f5f5f5; position: absolute; width: 95%; height: 20px; z-index: 1; border-width: 1px; border-style: none;'>
		<center>
			<img src='loading.gif'><br> <br> <b>음식점<br>DB
				로딩중...
			</b> <br>
		</center>
	</div> -->
	<%
/* 		out.flush() */;
		request.setCharacterEncoding("utf-8");
		String a = request.getParameter("id");
		String b = request.getParameter("pass");

	%>
	<script type="text/javascript">
		document.getElementById('load').style.visibility = "hidden";
	</script>
<form action="delres.jsp" method="post">
	
	<table border="1" bordercolor="black" width="852" align="center">
		<tr bgcolor="white">
			<td width="35" align="center">체크</td>
			<td width="155" align="center">음식점 이름</td>
			<td width="212" align="center">취급 음식</td>
			<td width="50" align="center">지도</td>
			<td width="50" align="center">상세정보</td>
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
				Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");

				Statement stm = con.createStatement();

				ResultSet rs;
				double score = 0;
				boolean temp = false;
				int colorvalue = 1;
				String strSQL = "SELECT * FROM restaurant";

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
					String name = rs.getString("name");
					String encodingname=URLEncoder.encode(name, "utf-8");
				
					String foods = rs.getString("foods");
					double lat = rs.getDouble("lat");
					double lng = rs.getDouble("lng");
				
				
				
					String viewmap_uri ="viewmap.jsp?name="+encodingname+"&lat="+lat+"&lng="+lng;
				
					String alt_res_uri="alt_res.jsp?name="+encodingname;
					
					count++;
					if (count == listSize+1)
						break;
			%>


		<tr bgcolor="<%if (colorvalue==0){ out.print("white");} else {out.print("darkgray");}%>">
			<td width="35" align="center"><input type="checkbox" name=<%=name%>></td>
			<td width="155" align="center"><%=name%></td>
			<td width="212" align="center"><%=foods%></td>
			<td width="50" align="center"><input type="button" value="설정" onClick="script:location.replace('<%=viewmap_uri%>')"></td>
			<td width="50" align="center"><input type="button" value="확인/수정" onClick="script:location.replace('<%=alt_res_uri%>')"></td>
		</tr>
<%
		if(colorvalue==0){
			colorvalue=1;
		}else{
			colorvalue=0;
		}
				} while (rs.next());
			
			%>
			<%
				rs.close();
				stm.close();
				con.close();
			%>

	</table>
	<br>
	<p>&nbsp;</p>
	<p align="center">
		<input type="submit" name="btnDelRes" value="삭제">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" name="btnAddFood" value="추가" onClick="script:location.replace('insertres.html')">
        </form>

	</p>
	<table width="852">
<tr>
<%
		if (currentPage > 1) {
	%>

<td align="left">
	<input type="button" name="btnAddFood" value="이전페이지" onClick="script:location.replace('i_adminres.jsp?pageNum=<%=currentPage - 1%>')">
</td>
<%
		}
 		if(currentPage < maxPage) 
		{
	%>
<td align="right">
	<input type="button" name="btnAddFood" value="다음페이지" onClick="script:location.replace('i_adminres.jsp?pageNum=<%=currentPage + 1%>')">
</td>
</tr>
</table>
	<%
		}
	%>
</body>
</html>