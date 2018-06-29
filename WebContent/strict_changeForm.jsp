<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.ArrayList"%>
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
		int height_line = Integer.parseInt(request.getParameter("height_line"));
		int line = Integer.parseInt(request.getParameter("line"));
		int expert = Integer.parseInt(request.getParameter("expert"));
		String p_total_seat = request.getParameter("total_seat");
		String[] total_seat = p_total_seat.split(",");

		int[] seat = new int[expert];
		int[] person = new int[expert];
		
		String[] missing_number = new String[0];
		String[] if_number = new String[0];
		String[] if_number_2 = new String[0];
		String[] if_select = new String[0];
		String[] if_select_2 = new String[0];
		
		Random rand = new Random();
		
		for(int i=0; i<person.length; i++){
			person[i] = 1;
		}
		
		try {
			missing_number = (String[])application.getAttribute("missing_number");
			if_number = (String[])application.getAttribute("if_number");
			if_number_2 = (String[])application.getAttribute("if_number_2");
			if_select = (String[])application.getAttribute("if_select");
			if_select_2 = (String[])application.getAttribute("if_select_2");
		} catch(Exception e){
			e.printStackTrace();
		}
		
		ArrayList<String> use_missing_number = new ArrayList<String>();
		for(int i=0; i<missing_number.length - 1; i++){
			use_missing_number.add(i, missing_number[i]);
		}
		
		ArrayList<String> use_if_number = new ArrayList<String>();
		for(int i=0; i<if_number.length - 1; i++){
			use_if_number.add(i, if_number[i]);
		}
		ArrayList<String> use_if_number_2 = new ArrayList<String>();
		for(int i=0; i<if_number.length - 1; i++){
			use_if_number_2.add(i, if_number_2[i]);
		}
		ArrayList<String> use_if_select = new ArrayList<String>();
		for(int i=0; i<if_number.length - 1; i++){
			use_if_select.add(i, if_select[i]);
		}
		ArrayList<String> use_if_select_2 = new ArrayList<String>();
		for(int i=0; i<if_number.length - 1; i++){
			use_if_select_2.add(i, if_select_2[i]);
		}
		
		// 직전 자리 가져오기
		String b_total_seat = null;
		String b_seat = null;
		String[] total_seat_b = new String[0];
		String[] seat_b = new String[0];
		
		int division_b = 0;
		int line_b = 0;
		int height_line_b = 0;
		
		int count_b = 0;

		String ID = (String)session.getAttribute("ID");
		
		String filePath = application.getRealPath("/WEB-INF/record/"+ID+".txt");
		
		BufferedReader reader = null;
		
		try {
			reader = new BufferedReader(new FileReader(filePath));
			
			while(true){
				String str = reader.readLine();
				
				if(str == null) break;
				
				String[] info = str.split("\t");
				division_b = Integer.parseInt(info[1]);
				line_b = Integer.parseInt(info[2]);
				height_line_b = Integer.parseInt(info[3]);
				b_total_seat = info[4];
				b_seat = info[5];
				
				count_b ++;
			}
			
			total_seat_b = b_total_seat.split(",");
			seat_b = b_seat.split(",");			
			
			// 이전에 저장된 결과가 없으면
			if(count_b == 0){
				out.print("<script>alert('이전에 저장된 결과가 없습니다.'); history.go(-1); </script>");
				return;
			}

			// 분단과 라인 수가 다르면
			if(division != division_b || line != line_b || height_line != height_line_b){
				out.print("<script>alert('분단 수 혹은 줄 수와 같은 조건이 달라 이전 결과와 비교할 수 없습니다.'); history.go(-1); </script>");
				return;
			}
			
			// 명수가 다르면
			if(seat_b.length != expert){
				out.print("<script>alert('명수가 다르면 이전 결과와 비교할 수 없습니다.'); history.go(-1); </script>");
				return;
			}
			
			// 자리 지정이 다르면
			Boolean sw_b = false;
			
			for(int i=0; i<total_seat.length; i++){
				if(total_seat[i].equals(total_seat_b[i]));
				else {
					sw_b = true;
				}
			}
			
			if(sw_b == true){
				out.print("<script>alert('자리를 똑같이 지정해주어야 합니다.'); history.go(-1); </script>");
				return;
			}
		} catch(Exception e){
			e.printStackTrace();
		}
	
		int sw = 0;
		int temp = 0;

		// start_number ~ end_number : 결번 제외 AMD 조건에 맞춰서 자리를 지정
		for(int i=start_number; i<= end_number; i++){ // 시작 번호부터 끝 번호까지 돈다.
			sw = 0;
			
			// missing_number와 같을 경우에는 다음 번호로 이동
			for(int j=0; j<use_missing_number.size(); j++){
				if(i == Integer.parseInt(use_missing_number.get(j))){
					use_missing_number.remove(j);
					sw = 1; // for_out에서 continue하라는 의미
					break;
				} // for _ in
			} // for _ out
			
			// 결번임으로 뛰어 넘어야한다.
			if(sw == 1) continue;
					
			int index = rand.nextInt(expert);
					
			// index 검사
		
			if(seat_b.length == 0){
				out.print("<script>alert('이전에 저장된 결과가 없습니다.'); history.go(-1); </script>");
				return;
			}					
			
			if(person[index] != 1 || i == Integer.parseInt(seat_b[index])){
				while(true){
					index = rand.nextInt(expert);
					
					if(person[index] == 1 && seat[index] != Integer.parseInt(seat_b[index])) break;
				}
			}
			
			int current_division = (index % (line * division)) / line + 1;
			int current_line_height = index / (division * line) + 1;
			
			// 조건 준 번호에 해당하는 지 check
			for(int j=0; j<use_if_number.size(); j++){
				sw = 0;
				
				if(i == Integer.parseInt(use_if_number.get(j))){
					// 조건 준 번호에 해당한다면
					
					// 조건을 준 것이 분단인지 라인인지 구분
					// 분단이라면
					if(use_if_select_2.get(j).equals("1")){
						// 연산
						switch(use_if_select.get(j)){
						case "1":
							if(current_division != Integer.parseInt(use_if_number_2.get(j))){
								sw = 2; // random을 다시 돌려야한다는 의미
							}
							break;
						case "2":
							if(current_division < Integer.parseInt(use_if_number_2.get(j))){
								sw = 2; // random을 다시 돌려야한다는 의미
							}
							break;
						case "3":
							if(current_division > Integer.parseInt(use_if_number_2.get(j))){
								sw = 2; // random을 다시 돌려야한다는 의미
							}
							break;
						case "4":
							if(current_division == Integer.parseInt(use_if_number_2.get(j))){
								sw = 2; // random을 다시 돌려야한다는 의미
							}
							break;
						}
					}
					
					// 라인이라면
					if(use_if_select_2.get(j).equals("2")){
						// 연산
						switch(use_if_select.get(j)){
						case "1":
							if(current_line_height != Integer.parseInt(use_if_number_2.get(j))){
								sw = 2; // random을 다시 돌려야한다는 의미
							}
							break;
						case "2":
							if(current_line_height < Integer.parseInt(use_if_number_2.get(j))){
								sw = 2; // random을 다시 돌려야한다는 의미
							}
							break;
						case "3":
							if(current_line_height > Integer.parseInt(use_if_number_2.get(j))){
								sw = 2; // random을 다시 돌려야한다는 의미
							}
							break;
						case "4":
							if(current_line_height == Integer.parseInt(use_if_number_2.get(j))){
								sw = 2; // random을 다시 돌려야한다는 의미
							}
							break;
						}
					}
					
					if(sw == 2) {
						break;
					}
					
					if(j == use_if_number.size() - 1 && sw != 2){
						use_if_number.remove(j);
						use_if_number_2.remove(j);
						use_if_select.remove(j);
						use_if_select_2.remove(j);
					} // end _ if
				}
			} // end for
			
			if(sw == 2){
				sw = 0;
				i--;

				continue;
			}

			seat[index] = i;
			person[index] = 0;
		}

		application.setAttribute("seat", seat);
	%>
	
	<form action="change.jsp" method="post" id="myForm" name="myForm" class="myForm">
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
										<td id="seat<%= count %>" value="<%= count %>" height="80px"><div class="seat"><%= seat[cnt] %></div></td>
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
					<%
						if(!(((String)session.getAttribute("ID")) == null || ((String)session.getAttribute("ID")).equals(""))) {
					%>
							<td> <input type="button" value="저장하기" onclick="javascript:save(1)"> </td>
					<%
						}
					%>
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
	<script>
		function save(index){
			if(index == 1){
				document.myForm.action = "save_record.jsp";
			}

			document.myForm.submit();
		}
	</script>
</body>
</html>
