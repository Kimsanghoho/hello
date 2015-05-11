<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<%
	request.setCharacterEncoding("utf-8");
 	String input_name = request.getParameter("name");
	String name = new String(input_name.getBytes("ISO-8859-1"),"utf-8");
	
	double lat = Double.valueOf(request.getParameter("lat"));
	double lng = Double.valueOf(request.getParameter("lng"));
%>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
html {
	height: 100%
}

body {
	height: 100%;
	margin: 0;
	padding: 0
}

#map_canvas {
	height: 100%
}
</style>
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false">
	
</script>
<script type="text/javascript">
	var marker;

	function initialize() {
		var myLatlng = new google.maps.LatLng(<%=lat%>,<%=lng%>);
		var mapOptions = {
			center : myLatlng,
			zoom : 14,
			disableDefaultUI : true,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		var map = new google.maps.Map(document.getElementById("map_canvas"),
				mapOptions);

		marker = new google.maps.Marker({
			position : myLatlng,
			map : map,
			draggable : true
		});
		showInfo();
		google.maps.event.addListener(marker, 'mouseup', showInfo);
	}
	function showInfo() {
		document.getElementById("lat").value = marker.getPosition().lat();
		document.getElementById("lng").value = marker.getPosition().lng();

	}

	function back() {
		location.replace("i_adminres.jsp");
	}
</script>
</head>
<body bgcolor="#f5f5f5" onload="initialize()">
	<div align="center">
		<b><%=name%></b><br>
		<form action="res_pos_set.jsp" method="get">
			위도 : <input type="text" id="lat" name="lat" size="10"> 경도 : <input
				type="text" name="lng" id="lng" size="10"> <input
				type="hidden" name="name" value="<%=name%>">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit"
				value="위치지정">
		</form>
	</div>
	<div align="center" id="map_canvas" style="width: 100%; height: 80%"></div>
	<br>
	<center>
		<input type="button" value="돌아가기" onclick="back()">
	</center>
</body>
</html>