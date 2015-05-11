<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.File"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>

<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>insert food</title>

<script language="javascript">
	function returnf() {
		location.replace('i_adminfood.jsp');
	}
	
	function ispng() {
		imgfile = document.getElementById("imgfile");
		filename = imgfile.value;
		ttt = file.lastIndexOf('.');
		overDot = filename.substring(ttt+1,filename.length);
		if(overDot=="png"){
			alert("png파일이 맞아영");
		}else{
			alert("png로 올려줘여");
		}
	}
	
</script>


</head>
<%
		request.setCharacterEncoding("utf-8");

		String name = new String(request.getParameter("name").getBytes("ISO-8859-1"), "utf-8");
		String code = null;
		String g1 = null;
		String g2 = null;
		String src = null;
		String path = application.getRealPath("/foodimg/");
		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");
		Statement stm = con.createStatement();
		ResultSet rs;
		String strSQL = "SELECT * FROM food where name ='" + name	+ "'";

		rs = stm.executeQuery(strSQL);
		
		while (rs.next()) {
			code = rs.getString("code");
			g1 = rs.getString("group1");
			g2 = rs.getString("group2");
		}
		
		File f = new File(path,code+".png");
		if(f.isFile()){
			src="./foodimg/"+code+".png";
		}else{
			src="./foodimg/noimg.png";
		}
		
		
	%>



<body bgcolor="#f5f5f5">
	<form action="alt_food_set.jsp" method="post" name="alt_food" enctype="multipart/form-data">
		<table border="1" bordercolor="white" width="448" align="center">
			<tr bgcolor="white" align="center">
				<td colspan="2"><img src=<%=src %> width="200" height="200"></td>
			</tr>
			<tr bgcolor="white" align="center">
				<td width="149" height="24">음식이름</td>
				<td width="488"><input
					type="text" size="40" name="food" value=<%=name %> readonly="readonly"><font color="red"> 수정불가</font> </td>
			</tr>
			<tr bgcolor="white" align="center">
				<td height="24">음식코드(영문)</td>
				<td width="488"><input type="text" size="40" name="code" value="<%=code %>" readonly="readonly"><font color="red"> 수정불가</font> </td>
			</tr>
			<tr bgcolor="white" align="center">
				<td height="24">종류1</td>
				<td>현재선택 :<%=g1 %>
				<select name="group1" size="1">
						<option value="한식">한식</option>
						<option value="중식">중식</option>
						<option value="양식">양식</option>
						<option value="분식">분식</option>
						<option value="일식">일식</option>
						<option value="기타">기타</option>
				</select></td>
			</tr>
			<tr bgcolor="white" align="center">
				<td height="24">종류2</td>
				<td>현재선택 :<%=g2 %>
				<select name="group2" size="1">
						<option value="밥">밥</option>
						<option value="면">면</option>
						<option value="빵">빵</option>
						<option value="고기">고기</option>
						<option value="반찬">반찬</option>
						<option value="떡">떡</option>
				</select></td>
			</tr>
			<tr bgcolor="white" align="center">
				<td height="24">Image</td>
				<td><input type="file" id="imgfile" name="imgfile" onchange="ispng()">
	
				</td>
			</tr>
			<tr bgcolor="white" align="center">
				<td height="24" colspan="2" align="center"><input type="submit"
					align="center" name="btnAddFood" value="수정하기"> <input
					type="button" align="center" value="목록으로 돌아가기" onClick="returnf()"></td>
			</tr>
		</table>
	</form>
	<p>&nbsp;</p>
	</p>
</body>

</html>