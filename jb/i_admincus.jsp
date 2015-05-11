<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<style type="text/css">
.left {
	text-align: left;
}

.right {
	text-align: right;
}
</style>
<title>회원관리</title>
</head>
<body bgcolor="white">
<!-- 	<div id='load'
		style='visibility: visible; background-color: #f5f5f5; position: absolute; width: 95%; height: 20px; z-index: 1; border-width: 1px; border-style: none;'>
		<center>
			<img src='loading.gif'><br> <br> <b>회원<br>DB 로딩중...</b> <br>
		</center>
	</div> -->

	<%
/* 		out.flush(); */
		request.setCharacterEncoding("utf-8");
		String a = request.getParameter("id");
		String b = request.getParameter("pass");

	%>
	<script type="text/javascript">
		document.getElementById('load').style.visibility="hidden";
	</script>
    
    <form action="delcus.jsp" method="post">
	<table border="1" bordercolor="black" width="852" align="center">
		<tr bgcolor="white">
			<td width="35" align="center">체크</td>
			<td width="122" align="center">ID</td>
			<td width="152" align="center">닉네임</td>
			<td width="214" align="center">이메일</td>
			<td width="160" align="center">관리자여부</td>
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
				String id = null;
				String nickname = null;
				String admin = null;
				String email = null;
				boolean temp = false;
				int colorvalue = 1;
				String strSQL = "SELECT * FROM people";

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
					id = rs.getString("id");
					nickname = rs.getString("nickname");
					email = rs.getString("email");
					admin = rs.getString("admin");
					count++;
					if (count == listSize+1)
						break;
					if (colorvalue == 1) {
			%>

		<tr bgcolor="darkgray">
			<td width="35" align="center"><input type="checkbox"
				name="<%=id%>" id="<%=id%>"></td>
			<td width="122"><div align="center"><%=id%></div></td>
			<td width="152"><div align="center"><%=nickname%></div></td>
			<td width="214"><div align="center"><%=email%></div></td>
			<td width="160"><div align="center"><%=admin%></div></td>
		</tr>
		<%
			colorvalue = 0;
				} else if (colorvalue == 0) {
		%>

		<tr bgcolor="white">
			<td width="35" align="center"><input type="checkbox"
				name="<%=id%>" id="<%=id%>"></td>
			<td width="122"><div align="center"><%=id%></div></td>
			<td width="152"><div align="center"><%=nickname%></div></td>
			<td width="214"><div align="center"><%=email%></div></td>
			<td width="160"><div align="center"><%=admin%></div></td>
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
	<div align="center">
		<input type="submit" value="아이디 삭제">
	</div>

	<table width="852">
<tr>
    <%
		if (currentPage > 1) {
	%>

<td align="left">
	<input type="button" name="btnAddFood" value="이전페이지" onClick="script:location.replace('i_admincus.jsp?pageNum=<%=currentPage - 1%>')">
	</td>
	<%
		}
 		if(currentPage < maxPage) 
		{
	%>
<td align="right">
	<input type="button" name="btnAddFood" value="다음페이지" onClick="script:location.replace('i_admincus.jsp?pageNum=<%=currentPage + 1%>')">
</td>
</tr>
</table>
</form>
	<%
		}
	%>
</body>
</html>