<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
function goToResult(){
		location.replace('result.jsp');
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<%
	int str1_1=0,str1_2=0,str1_3=0,str1_4=0,str1_5=0;
	int str2_1=0,str2_2=0,str2_3=0;
	int str3_1=0,str3_2=0,str3_3=0;
	int str4_1=0,str4_2=0,str4_3=0,str4_4=0;
	int str5_1=0;
	int str6_1=0;
	
	String driverName = "org.gjt.mm.mysql.Driver";
	String dbURL = "jdbc:mysql://211.218.150.109:3306/jellybean";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(dbURL, "jellybean", "jellybean2014");

	Statement stm = con.createStatement();
	ResultSet rs;

	String str = "SELECT * FROM temp01";

	
	rs = stm.executeQuery(str);
		while (rs.next()) {
			str5_1++;
			str6_1++;
			if(rs.getString("1st").equals("무멘")) str1_1++;
			if(rs.getString("1st").equals("주멘")) str1_2++;
			if(rs.getString("1st").equals("도도")) str1_3++;
			if(rs.getString("1st").equals("성로리")) str1_4++;
			if(rs.getString("1st").equals("진영준")) str1_5++;
	 	}
rs.beforeFirst();
		while (rs.next()) {
			if(rs.getString("2nd").equals("무멘")) str2_1++;
			if(rs.getString("2nd").equals("호선생")) str2_2++;
			if(rs.getString("2nd").equals("도베일")) str2_3++;
	 	}
		rs.beforeFirst();
		while (rs.next()) {
			if(rs.getString("3rd").equals("빛로킹")) str3_1++;
			if(rs.getString("3rd").equals("도로리")) str3_2++;
			if(rs.getString("3rd").equals("로성지")) str3_3++;
	 	}
		rs.beforeFirst();
		while (rs.next()) {
			if(rs.getString("4th").equals("진영준")) str4_1++;
			if(rs.getString("4th").equals("돈그로")) str4_2++;
			if(rs.getString("4th").equals("혀노")) str4_3++;
			if(rs.getString("4th").equals("별점장")) str4_4++;
	 	}
%>
<body>
	<center>
		<form action="end.jsp" method="post">
			<table border="2">
				<tr bordercolor="white">
					<td colspan="3"><img src="re.png">
					<hr></td>
				</tr>
				<tr bordercolor="white" align="center">
					<td colspan="3">대상(광성도르)</td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>기호</td>
					<td>코드네임</td>
					<td width="40">선택</td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>가</td>
					<td>무멘</td>
					<td width="40"><%=str1_1%></td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>나</td>
					<td>주멘</td>
					<td width="40"><%=str1_2%></td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>다</td>
					<td>도도</td>
					<td width="40"><%=str1_3%></td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>로</td>
					<td>성로리</td>
					<td width="40"><%=str1_4%></td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>마</td>
					<td>진영준</td>
					<td width="40"><%=str1_5%></td>
				</tr>
				<!--------------------------1차 끝--------------------------------->
				<tr bordercolor="white" align="center">
					<td colspan="3"><br>올해의 섹드리퍼</td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>기호</td>
					<td>코드네임</td>
					<td width="40">선택</td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>가</td>
					<td>무멘</td>
					<td width="40"><%=str2_1%></td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>나</td>
					<td>호선생</td>
					<td width="40"><%=str2_2%></td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>다</td>
					<td>도베일</td>
					<td width="40"><%=str2_3%></td>
				</tr>
				<!--------------------------2차 끝--------------------------------->
				<tr bordercolor="white" align="center">
					<td colspan="3"><br>올해의 로ㄹ....</td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>기호</td>
					<td>코드네임</td>
					<td width="40">선택</td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>가</td>
					<td>빛로킹</td>
					<td width="40"><%=str3_1%></td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>나</td>
					<td>도로리</td>
					<td width="40"><%=str3_2%></td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>다</td>
					<td>로성지</td>
					<td width="40"><%=str3_3%></td>
				</tr>
				<!--------------------------3차 끝--------------------------------->
				<tr bordercolor="white" align="center">
					<td colspan="3"><br>올해의 노점상(No Zam, Yes Stress)</td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>기호</td>
					<td>코드네임</td>
					<td width="40">선택</td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>가</td>
					<td>진영준</td>
					<td width="40"><%=str4_1%></td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>나</td>
					<td>돈그로</td>
					<td width="40"><%=str4_2%></td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>다</td>
					<td>혀노(고인)</td>
					<td width="40"><%=str4_3%></td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>라</td>
					<td>별점장</td>
					<td width="40"><%=str4_4%></td>
				</tr>
				<!--------------------------4차 끝--------------------------------->
				<tr bordercolor="white" align="center">
					<td colspan="3"><br>올해의 어그로</td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>가</td>
					<td>돈그로</td>
					<td width="40"><%=str5_1%></td>
				</tr>
				<!--------------------------5차 끝--------------------------------->
				<tr bordercolor="white" align="center">
					<td colspan="3"><br>올해의 개진상</td>
				</tr>
				<tr bordercolor="black" align="center">
					<td>가</td>
					<td>진영준</td>
					<td width="40"><%=str6_1%></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>