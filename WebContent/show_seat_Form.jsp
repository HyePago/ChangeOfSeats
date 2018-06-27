<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
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
		
			int division_number = Integer.parseInt(request.getParameter("count"));
			
			String ID = (String)session.getAttribute("ID");
			String filePath = application.getRealPath("/WEB-INF/record/" + ID + ".txt");
			
			BufferedReader reader = null;
			
			int count = 0;
			
			try {
		reader = new BufferedReader(new FileReader(filePath));
		
		while(true){
			String str = reader.readLine();
			
			if(str == null) break;

			if(count == division_number){
				String[] info = str.split("\t");
			}

					count++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>