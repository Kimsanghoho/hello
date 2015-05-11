<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.File"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>

<head>
<title>alt_res</title>

<script language="javascript">
	function returnf() {
		location.replace('i_adminres.jsp');
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

		String foods = null;
		String tel =  null;
		String intro = null;
		String addr = null;
		String code = null;
		String src = null;
		String path = application.getRealPath("/resimg/");
		String name = new String(request.getParameter("name").getBytes("ISO-8859-1"), "utf-8");
		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");
		Statement stm = con.createStatement();
		ResultSet rs;
		String strSQL = "SELECT * FROM restaurant where name ='" + name	+ "'";

		rs = stm.executeQuery(strSQL);

		while (rs.next()) {
			foods = rs.getString("foods");
			tel = rs.getString("tel");
			intro = rs.getString("intro");
			addr = rs.getString("addr");
			code = rs.getString("code");
		}
		
		File f = new File(path,code+".png");
		if(f.isFile()){
			src="./resimg/"+code+".png";
		}else{
			src="./resimg/noimg.png";
		}
	%>

	<body bgcolor="#f5f5f5">
		<form action="alt_res_set.jsp" method="post" name="alt_res" enctype="multipart/form-data">
			<table border="1" bordercolor="white" width="448" align="center">
				<tr bgcolor="white" align="center">
				<td colspan="2"><img src=<%=src %> width="200" height="200"><input type="hidden" name="code" value=<%=code %>></td>
			</tr>
				<tr bgcolor="white" align="center">
					<td width="149" >음식점이름</td>
					<td><input type="text" size="39" name="name"
						id="name" value=<%=name%> readonly="readonly"><font color="red"> 수정불가</font></td>
				</tr>
				<tr bgcolor="white" align="center">
					<td>취급음식</td>
					<td><input type="text" size="39" name="foods"
						id="foods" value=<%=foods%>></td>
				</tr>
				<tr bgcolor="white" align="center">
					<td>전화번호</td>
					<td><input type="text" size="39" name="tel"
						id="tel" value=<%=tel%>></td>
				</tr>
				<tr bgcolor="white" align="center">
					<td>주소</td>
					<td><textarea cols="30" rows="1" name="addr"
						id="addr"><%=addr%></textarea></td>
				</tr>
              	<tr bgcolor="white" align="center">
				<td height="24">Image</td>
				<td><input type="file" id="imgfile" name="imgfile" onchange="ispng()">
	
				</td>
				<tr bgcolor="white" align="center">
					<td> 소개</td>
					<td><textarea cols="30" rows="6" name="intro"
						id="intro" autofocus="autofocus"><%=intro%></textarea></td>
				</tr>

			</tr>
				<tr bgcolor="white" align="center">
					<td colspan="2" align="center"><input type="submit"
						align="center" value="수정하기"> <input type="button"
						align="center" value="목록으로 돌아가기" onClick="returnf()"></td>
				</tr>
			</table>
		</form>
		<p>&nbsp;</p>
		</p>
	</body>

	</html>
