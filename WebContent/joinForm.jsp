<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	
	<form action="joinProc.jsp" method="post">
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
				<th>학년</th>
				<td><input type="number" name="GRADE" required="required"></td>
			</tr>
			<tr>
				<th>반</th>
				<td><input type="number" name="CLASS" required="required"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="가입하기">
				</td>
			</tr>
		</table>
	</form>	
</body>
</html>