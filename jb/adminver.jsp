<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<script language="javascript">
	function admin_log() {
		if (confirm("로그아웃하시겠습니까?")) {
			parent.frames[2].location.replace('c.html');
			parent.frames[1].location.replace('b.html');
			parent.frames[0].location.replace('a_2.html');
		} else {

		}

	}
	function move1() {
		parent.frames[2].location.replace('adminCus.html');
	}
	function move2() {
		parent.frames[2].location.replace('adminFood.html');
	}
	function move3() {
		parent.frames[2].location.replace('adminRes.html');
	}
	function move4() {
		parent.frames[2].location.replace('question.html');
	}
</script>
</head>

<body bgcolor="#202020" marginheight="0">


	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="5%"><img src="logout.png" align="left"
				style="width: 55px; height: 58px" onClick="admin_log()"></td>
			<td width="20%">&nbsp;</td>
			<td width="19%" align="right"><img src="img/cus.png"
				height="30" alt="ȸ������" onClick='move1()'></td>
			<td width="19%" align="right"><img src="img/food.png"
				height="30" alt="���İ���" onClick='move2()'></td>
			<td width="19%" align="right"><img src="img/rest.png"
				height="30" alt="����������" onClick='move3()'></td>
			<td width="19%" align="right"><img src="img/question.png"
				height="30" alt="����������" onClick='move4()'></td>
		</tr>
	</table>
</body>
</html>
