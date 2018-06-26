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
		String p_total_seat = request.getParameter("total_seat");
		String[] total_seat = p_total_seat.split(",");
		
		int[] seat = new int[Integer.parseInt(expert)];
		int[] person = new int[end_number + 1];
		
		String[] missing_number = new String[0];
		String[] if_number = new String[0];
		String[] if_number_2 = new String[0];
		String[] if_select = new String[0];
		String[] if_select_2 = new String[0];
		
		try {
			missing_number = (String[])application.getAttribute("missing_number");
			if_number = (String[])application.getAttribute("if_number");
			if_number_2 = (String[])application.getAttribute("if_number_2");
			if_select = (String[])application.getAttribute("if_select");
			if_select_2 = (String[])application.getAttribute("if_select_2");
		} catch(Exception e){
			e.printStackTrace();
		}
		
		Random rand = new Random();
		
		for(int i=start_number; i<person.length; i++){
			person[i] = 0;
		}
		for(int i=start_number; i<= end_number; i++){
			person[i] = 1;
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
		
		// i : 자리, number : 번호
		int division_cnt = 1;
		int height_cnt = 1;
		int if_cnt = 0;
		boolean sw = false;
		boolean sw1 = false;
		boolean sw2 = false;
		
		for(int i=0; i<seat.length; i++){
			sw1 = false;
			sw2 = false;
			
			if(if_cnt == line){
				if_cnt = 0;
				division_cnt++;
				
				sw1 = true;
			}
			if(division_cnt == division + 1){
				division_cnt = 1;
				height_cnt++;
				
				sw2 = true;
			}
			if_cnt++;
			
			int number = rand.nextInt(end_number) + start_number; // 번호
			
			if(person[number] == 1){ // 해당 번호가 유효하면
				sw = false;
				// 조건 제한
				for(int j=0; j<if_number.length - 1; j++){
					if(number == Integer.parseInt(if_number[j])) {
						// 조건에 해당하는 번호와 같다면 분단인지 라인인지 구분
						
						if(if_select_2[j].equals("1")){
							// 연산자
							switch(if_select[j]){
							case "1":
								if(division_cnt != Integer.parseInt(if_number_2[j])){
									sw = true;
								}
								break;
							case "2":
								if(division_cnt < Integer.parseInt(if_number_2[j])){
									sw = true;
								}
								break;
							case "3":
								if(division_cnt > Integer.parseInt(if_number_2[j])){
									sw = true;
								}
								break;
							case "4":
								if(division_cnt == Integer.parseInt(if_number_2[j])){
									sw = true;
								}
								break;
							}
						}
						
						if(if_select_2[j].equals("2")){
							// 연산자
							switch(if_select[j]){
							case "1":
								if(height_cnt != Integer.parseInt(if_number_2[j])){
									sw = true;
								}
								break;
							case "2":
								if(height_cnt < Integer.parseInt(if_number_2[j])){
									sw = true;
								}
								break;
							case "3":
								if(height_cnt > Integer.parseInt(if_number_2[j])){
									sw = true;
								}
								break;
							case "4":
								if(height_cnt == Integer.parseInt(if_number_2[j])){
									sw = true;
								}
								break;
							}
						}
					}
					
					if(sw == true){
						break;
					}
				}
				
				if(sw == true){
					i--;
					sw = false;
					if_cnt--;
					
					if(sw1 == true){
						division_cnt--;
						if_cnt = line;
					}
					if(sw2 == true){
						height_cnt--;
						division_cnt = division + 1;
					}
					
					continue;
				}
				
				person[number] = 0;
				seat[i] = number;
			} else {
				i--;
				if_cnt--;
				
				if(sw1 == true){
					division_cnt--;
				}
				if(sw2 == true){
					height_cnt--;
				}
				
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