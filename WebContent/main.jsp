<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자리배치</title>
<link href="css/myStyle.css" rel="stylesheet">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String contentPage = request.getParameter("CONTENTPAGE");
%>	
	<header class="main_header">
		<h1>우리 반 자리 배치 프로그램</h1>
		<nav class="main_nav">
			<ul>
				<li><a href="index.jsp">자리배치 프로그램</a></li>
				<li><a href="#">JSP 순서</a></li>
				<li><a href="#">관리자 페이지</a></li>
			</ul>
		</nav>
	</header>
	
	<section class="main_section">
		<jsp:include page="<%= contentPage %>" flush="false" />
	</section>
</body>
</html>