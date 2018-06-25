<%@page import="java.util.Random"%>
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
	
		int start_number = Integer.parseInt(request.getParameter("start_number"));
		int end_number = Integer.parseInt(request.getParameter("end_number"));
		int division = Integer.parseInt(request.getParameter("division"));
		int line = Integer.parseInt(request.getParameter("line"));
		int height_line = Integer.parseInt(request.getParameter("height_line"));
		String expert = request.getParameter("expert");
		//String p_missing_number = request.getParameter("missing_number");
		//String[] missing_number = (String[])application.getAttribute("missing_number");
		String p_total_seat = request.getParameter("total_seat");
		String[] total_seat = p_total_seat.split(",");
		
		int[] seat = new int[Integer.parseInt(expert)];
		int[] person = new int[end_number + 1];
		
		String[] missing_number = new String[0];
		
		try {
			missing_number = (String[])application.getAttribute("missing_number");
		} catch(Exception e){
			e.printStackTrace();
		}
		
		Random rand = new Random();
		
		for(int i=0; i<person.length; i++){
			person[i] = 0;
		}
		for(int i=start_number; i<person.length; i++){
			for(int j=0; j<missing_number.length - 1; j++){
				if(i == Integer.parseInt(missing_number[j])){
					person[i] = 0;
					break;
				}
				else {
					person[i] = 1;
				}
			}
		}
		
		for(int i=0; i<seat.length; i++){
			int number = rand.nextInt(end_number) + start_number;
			
			if(person[number] == 1){
				person[number] = 0;
				seat[i] = number;
			} else {
				i--;
				continue;
			}
		}
	%>
	
	<form action="change.jsp" method="post">
		<div>
			<table class="main_seat_table">
				<%
					int count = 1;
					int cnt = 0;
				
					for(int i=0; i<height_line; i++){
						out.print("<tr>");
						
						for(int j=0; j<division; j++){
							for(int k=0; k<line; k++){
								if(total_seat[count - 1].equals("1")){
									%>
										<td id="seat<%= count %>" value="<%= count %>"><div class="seat"><%= seat[cnt] %></div></td>
									<%
									cnt ++;
								} else {
									%>
									<td id="seat<%= count %>" value="<%= count %>"><div></div></td>
									<%
								}
								count++;
							}
							out.println("<th></th>");
						}
						out.print("</tr>");
					}
				%>
			</table>		
			<table class="main_seat_sub_table">
				<tr>
					<td> <input type="button" value="이전으로 돌아가기" onclick="history.go(-1);"></td>
					<td> <input type="submit" value="다시 돌리기"> </td>
					<td> <input type="button" value="선택하기"> </td>
				</tr>
			</table>
			
			<input type="hidden" name="start_number" value="<%= start_number %>">
			<input type="hidden" name="end_number" value="<%= end_number %>">
			<input type="hidden" name="division" value="<%= division %>">
			<input type="hidden" name="line" value="<%= line %>">
			<input type="hidden" name="height_line" value="<%= height_line %>">
			<input type="hidden" name="expert" value="<%= expert %>">
			<input type="hidden" name="total_seat" id="total_seat" value="<%= p_total_seat %>">
		</div>
	</form>

</body>
</html>