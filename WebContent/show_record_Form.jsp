<%@page import="java.util.ArrayList"%>
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
	
		String ID = (String)session.getAttribute("ID");
		String filePath = application.getRealPath("/WEB-INF/record/" + ID + ".txt");
		
		BufferedReader reader = null;
		
		int count = 0;
		
		ArrayList<String> result = new ArrayList<String>();
	%>
	<form>
		<table class="show_record_table">
			<%
				try {
					reader = new BufferedReader(new FileReader(filePath));
					
					while(true){
						String str = reader.readLine();
						
						if(str == null) break;
						String[] info = str.split("\t");
						
						result.add(count, info[0]);
						
						count++;
					}
					
				} catch(Exception e){
					e.printStackTrace();
				}
			
				count = 0;
			
				for(int i=result.size()-1; i>=0; i--){
					if(count%3 == 0){
						out.print("<tr>");
					}
					%>
						<td onclick="location.href='show_seat.jsp?count=<%= i %>'"> <%= result.get(i) %> </td>
					<%
					if(count%3 == 2){	
						out.print("</tr>");
					}
					
					count++;
				}
			%>		
		</table>	
	</form>
</body>
</html>