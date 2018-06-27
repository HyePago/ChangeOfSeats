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
		
		String date = null;
		int division = 0;
		int line = 0;
		int height_line = 0;
		String p_total_seat = null;
		String p_seat = null;
		
		String[] total_seat = null;
		String[] seat = null;
		
		
		int count = 0;
		
		try {
			reader = new BufferedReader(new FileReader(filePath));
			
			while(true){
				String str = reader.readLine();
				
				if(str == null) break;
				
				if(count == division_number){
					String[] info = str.split("\t");
					
					date = info[0];
					division = Integer.parseInt(info[1]);
					line = Integer.parseInt(info[2]);
					height_line = Integer.parseInt(info[3]);
					p_total_seat = info[4];
					p_seat = info[5];
					
					total_seat = p_total_seat.split(",");
					seat = p_seat.split(",");
					
					break;
				}
				count++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	
	<form>
		<div>
			<table class="main_seat_table">
				<%
					count = 1;
					int cnt = 0;
					
					for(int i=0; i<height_line; i++){
						out.print("<tr>");
						
						for(int j=0; j<division; j++){
							for(int k=0; k<line; k++){
								if(total_seat[count-1].equals("1")){
									%>
										<td id="seat<%= count %>" value="<%= count %>" height="80px">
											<div class="seat"><%= seat[cnt] %></div>
										</td>
									<%
									cnt++;
								} else {
									%>
									<td id="seat<%=count %>" value="<%=count %>">
										<div></div>
									</td>
									<%
								}
								
								count++;
							}
							out.print("<th></th>");
						}
						out.print("</tr>");
					}
				%>
			</table>
			<table class="main_seat_sub_table">
				<tr>
					<td> <input type="button" value="이전으로 돌아가기" onclick="history.go(-1);"></td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>