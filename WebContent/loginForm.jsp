<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		request.setCharacterEncoding("UTF-8");
	%>
	
	<form action="loginProc.jsp" method="post">
		<table class="join_table">
			<tr>
				<th>ID</th>
				<td><input type="text" name="ID" required="required"></td>
			</tr>
			<tr>
				<th>PASSWORD</th>
				<td><input type="password" name="PW" required="required"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="로그인">
				</td>
			</tr>
		</table>
	</form>	
</body>
</html>