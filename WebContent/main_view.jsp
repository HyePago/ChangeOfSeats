<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body onload="init();">
	<%
		request.setCharacterEncoding("UTF-8");
	
		int start_number = 0; // 시작 번호
		int end_number = 0; // 끝 번호
		String[] missing_number = new String[0]; // 결번
		int division = 0; // 분단 수
		int line = 0; // 분단 별 줄 수
		int expert = 0; // 총 인원수
		int height_line = 0; // 세로 인원 수
		int checked = 0; // 체크된 수
		int missing_number_size = 0; 
		String[] if_number = new String[0]; // 조건 번호
		String[] if_select = new String[0]; // 조건 조건
		String[] if_select_2 = new String[0]; // 조건 구분
		String[] if_number_2 = new String[0]; // 조건 구분 숫자
		int if_number_size = 0;
		
	
		// 할당
		try {
			start_number = Integer.parseInt(request.getParameter("start_number"));
			end_number = Integer.parseInt(request.getParameter("end_number"));
			division = Integer.parseInt(request.getParameter("division"));
			line = Integer.parseInt(request.getParameter("line"));
			missing_number = request.getParameterValues("missing_number");
			
			if_number = request.getParameterValues("if_number");
			if_select = request.getParameterValues("if_select");
			if_number_2 = request.getParameterValues("if_number_2");
			if_select_2 = request.getParameterValues("if_select_2");
		} catch(Exception e){
			e.printStackTrace();
		}

		if(start_number == 0) start_number = 1;
		if(end_number == 0) end_number = 19;
		if(division == 0) division = 3;
		if(line == 0) line = 2;
		
		// 총 인원수
		missing_number_size = missing_number.length - 1;
		if(missing_number_size == -1){
			missing_number_size = 0;
		}
		if_number_size = if_number.length - 1;
		if(if_number_size == -1){
			missing_number_size = 0;
		}

		expert = (end_number - start_number) + 1 - missing_number_size;
		checked = expert;
		
		// 세로 줄 수
		height_line = expert / (division * line);
		
		if(expert % (division * line) != 0) {
			height_line += 1;
		}
		
		// 0 혹은 마지막 번호보다 높은 번호가 들어왔는 지 검사
		for(int i=0; i<missing_number.length-1; i++){
			if(Integer.parseInt(missing_number[i]) < start_number){
				out.print("<script>alert('결번에는 시작번호보다 작은 수가 들어갈 수 없습니다.'); history.go(-1); </script>");
				return;
			} else if(Integer.parseInt(missing_number[i]) > end_number){
				out.print("<script>alert('결번에는 끝 번호보다 큰 수가 들어갈 수 없습니다.'); history.go(-1); </script>");
				return;
			}
		}
		
		// 결번에서 중복된 값이 있는 지 검사
		for(int i=0; i<missing_number.length -1; i++){
			for(int j=0; j<i; j++){
				if(missing_number[i].equals(missing_number[j])){
					out.print("<script>alert('중복된 결번 값이 들어갈 수 없습니다.'); history.go(-1); </script>");
					return;
				}
			}
		}
		
		// missing_number
		application.setAttribute("missing_number", missing_number);
		
		// 번호 당 조건 : 조건 확인
		for(int i=0; i<if_number_size; i++){
			// 존재하는 번호인지, 결번은 아닌지 확인
			if(Integer.parseInt(if_number[i]) < start_number){
				out.print("<script>alert('조건 번호에는 시작번호보다 작은 수가 들어갈 수 없습니다.'); history.go(-1); </script>");
				return;
			} else if(Integer.parseInt(if_number[i]) > end_number){
				out.print("<script>alert('조건 번호에는 끝 번호보다 큰 수가 들어갈 수 없습니다.'); history.go(-1); </script>");
				return;
			}
		}
		
		// 조건 번호에 중복된 번호가 들어갔는 지 확인
		for(int i=0; i<if_number_size; i++){
			for(int j=0; j<i; j++){
				if(if_number[i].equals(if_number[j])){
					out.print("<script>alert('조건 번호는 중복된 번호가 들어갈 수 없습니다.'); history.go(-1); </script>");
					return;
				}
			}
			// 결번에 속하는 번호가 있는 지 확인
			for(int j=0; j<missing_number_size; j++){
				if(if_number[i].equals(missing_number[j])){
					out.print("<script>alert('결번에 속하는 번호에는 조건을 지정해줄 수 없습니다.'); history.go(-1); </script>");
					return;
				}
			}
		}
		
		// 분단과 라인 구분
		for(int i=0; i<if_number_size; i++){
			// 분단
			if(if_select_2[i].equals("1")){
				// 1보다 작은 지 및 분단 개수보다 많은 지
				if(Integer.parseInt(if_number_2[i]) < 1){
					out.print("<script>alert('분단 번호에는 1보다 작은 수가 들어갈 수 없습니다.'); history.go(-1); </script>");
					return;
				} else if(Integer.parseInt(if_number_2[i]) > division){
					out.print("<script>alert('분단 번호에는 분단 개수보다 큰 수가 들어갈 수 없습니다.'); history.go(-1); </script>");
					return;
				}
			} else if(if_select_2[i].equals("2")){ // 라인
				// 1 보다 작은지 line_height보다 많은 지
				if(Integer.parseInt(if_number_2[i]) < 1){
					out.print("<script>alert('라인 번호에는 1보다 작은 수가 들어갈 수 없습니다.'); history.go(-1); </script>");
					return;
				} else if(Integer.parseInt(if_number_2[i]) > height_line) {
					out.print("<script>alert('라인 번호에는 줄 개수보다 큰 수가 들어갈 수 없습니다.'); history.go(-1); </script>");
					return;
				}
			}
		}
		
		// application
		application.setAttribute("if_number", if_number);
		application.setAttribute("if_number_2", if_number_2);
		application.setAttribute("if_select", if_select);
		application.setAttribute("if_select_2", if_select_2);
	%>
	<form action="index.jsp" method="post">
		<div class="main_view_div">
			<table class="main_view_table">
				<tr>
					<th>분단 </th>
					<td><input type="number" value="<%= division %>" size="2" name="division"></td>
				</tr>
				<tr>
					<th>분단 별 줄 개수 </th>
					<td><input type="number" value="<%= line %>" size="2" name="line"></td>
				</tr>
				<tr>
					<th>시작 번호 </th>
					<td><input type="number" value="<%= start_number %>" size="2" min="1" name="start_number"></td>
				</tr>
				<tr>
					<th>끝 번호 </th>
					<td><input type="number" value="<%= end_number %>" size="2" min="1" name="end_number"></td>
				</tr>
				<tr>
					<th>결번으로 <br>선택 된 번호 </th>
					<td>
						<%
							for(int i=0; i<missing_number.length - 1; i++){
								out.print(missing_number[i]);
								
								if(i != missing_number.length - 2){
									out.print(", ");
								}
							}
						%>
					</td>
				</tr>
				<tr>
					<th>
						결번
					</th>
					<td>
						<div>
							<div id="add_place"></div>
							<input type="button" value="추가" onclick="add_div()">
						</div>
						<input type="hidden" size="2" name="missing_number" class="sample_number" value="1">
					</td>
				</tr>
				<tr>
					<th>조건</th>
					<td>
						<%
							for(int i=0; i<if_number_size; i++){
								out.print(if_number[i] + "번, ");
								
								if(if_select_2[i].equals("1")){
									out.print("분단 ");
								} else if(if_select_2[i].equals("2")) {
									out.print("줄");
								}
								
								switch(if_select[i]){
								case "1":
									out.print(" = ");
									break;
								case "2":
									out.print(" >= ");
									break;
								case "3":
									out.print(" <= ");
									break;
								case "4":
									out.print(" != ");
									break;
								}
								
								out.print(if_number_2[i] + "<br>");
							}
						%>
					</td>
				</tr>
				<tr>
					<th>
						번호 당 조건
					</th>
					<td>
						<div>
							<div id="add_if"></div>
							<input type="button" value="추가" onclick="add_if()">
						</div>
						<input type="hidden" size="2" name="if_number" value="1">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="변경" class="main_view_submit">
					</td>
				</tr>
			</table>
		</div>	
	</form>
	
	<div id="add_sample" style="display: none">
		<input type="number" size="2" name="missing_number" id="missing_number" class="sample_number" value="1"> <input type="button" value="삭제" onclick="remove_div(this)">
	</div>
	
	<div id="add_if_sample" style="display: none">
		<input type="number" name="if_number" id="if_number" min="<%= start_number %>" max="<%= end_number %>" placeholder="번호" required="required">
		<select name="if_select_2">
			<option value="1">분단</option>
			<option value="2">라인</option>
		</select>
		<select name="if_select">
			<option value="1">=</option>
			<option value="2">>=</option>
			<option value="3"><=</option>
			<option value="4">!=</option>
		</select>
		<input type="number" name="if_number_2" placeholder="조건" required="required">
		<input type="button" value="삭제" onclick="remove_if(this)">
	</div>
	
	<form id="form_2" action="change.jsp" method="post">
		<div>
			<table class="main_seat_table">
				<%
					int count = 1;
				
					for(int i=0; i<height_line; i++){
						out.print("<tr>");
						
						for(int j=0; j<division; j++){
							for(int k=0; k<line; k++){
								%>
									<td class="seat_td" id="seat<%= count %>" onclick="javascript:seat_click(this)" value="<%= count %>" height="80px"><div class="seat"><%= count %></div></td>
								<%
								count++;
							}
							out.println("<th></th>");
						}
						out.println("</tr>");
					}
				%>
			</table>
			<table class="main_seat_sub_table">
				<tr>
					<td>
						<input type="button" value="돌리기" onclick="javascript:change()" class="main_view_submit">
					</td>
				</tr>
			</table>
			
			<input type="hidden" name="start_number" value="<%= start_number %>">
			<input type="hidden" name="end_number" value="<%= end_number %>">
			<input type="hidden" name="division" value="<%= division %>">
			<input type="hidden" name="line" value="<%= line %>">
			<input type="hidden" name="height_line" value="<%= height_line %>">
			<input type="hidden" name="expert" value="<%= expert %>">
			<input type="hidden" name="total_seat" id="total_seat">
		</div>
	</form>
	<script>
		var checked = <%= expert %>
		var total_seat = [];
		
		for(var i=0; i< <%= division * line * height_line %>; i++){
			total_seat[i] = 0;
		}
		for(var i=0; i<<%= expert %>; i++){
			total_seat[i] = 1;
		}
	
		function add_div(){
			var div = document.createElement('div');
			div.innerHTML = document.getElementById('add_sample').innerHTML;
			document.getElementById('add_place').appendChild(div);
		}
		function add_if(){
			var div = document.createElement('div');
			div.innerHTML = document.getElementById('add_if_sample').innerHTML;
			document.getElementById('add_if').appendChild(div);
		}
		
		function remove_div(obj){
			document.getElementById('add_place').removeChild(obj.parentNode);
		}
		function remove_if(obj){
			document.getElementById('add_if').removeChild(obj.parentNode);
		}
		
		function seat_click(obj){
			var separation = obj.style.backgroundColor == "rgb(185, 228, 201)";
			
			if(separation == true){
				total_seat[obj.id.substring(4,obj.id.length + 1) - 1] = "0";
				obj.style.backgroundColor = "rgba(255,255,255,0)";
				checked--;
			} else {
				if(checked < <%= expert %>){
					total_seat[obj.id.substring(4,obj.id.length + 1) - 1] = "1";
					obj.style.backgroundColor = "#B9E4C9";
					checked++;
				}
			}
		}
		
		function change() {
			if(checked < <%= expert %>){
				alert((<%= expert %> - checked) + "자리 더 체크해주셔야 합니다.");
				
				return;
			} 

			document.getElementById("total_seat").value = total_seat;
			document.getElementById("form_2").submit();
		}
		
		function init(){
			<%
				for(int i=1; i<=expert; i++){
					%>
						document.getElementById("seat<%=i%>").style.backgroundColor = "#B9E4C9";
					<%
				}
			%>
		}
	</script>
</body>
</html>