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
	
		// 할당
		try {
			start_number = Integer.parseInt(request.getParameter("start_number"));
			end_number = Integer.parseInt(request.getParameter("end_number"));
			division = Integer.parseInt(request.getParameter("division"));
			line = Integer.parseInt(request.getParameter("line"));
			missing_number = request.getParameterValues("missing_number");
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

		expert = (end_number - start_number) + 1 - missing_number_size;
		checked = expert;
		
		// 세로 줄 수
		height_line = expert / (division * line);
		
		if(expert % (division * line) != 0) {
			height_line += 1;
		}
		
		
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
					<td colspan="2">
						<input type="submit" value="번경">
					</td>
				</tr>
			</table>
		</div>	
	</form>
	
	<div id="add_sample" style="display: none">
		<input type="number" size="2" name="missing_number" class="sample_number" value="1"> <input type="button" value="삭제" onclick="remove_div(this)">
	</div>
	
	<div>
		<table class="main_seat_table">
			<%
				int count = 1;
			
				for(int i=0; i<height_line; i++){
					out.print("<tr>");
					
					for(int j=0; j<division; j++){
						for(int k=0; k<line; k++){
							%>
								<td id="seat<%= count %>" onclick="javascript:seat_click(this)"><div class="seat"><%= count %></div></td>
							<%
							count++;
						}
						out.println("<th></th>");
					}
					out.println("</tr>");
				}
			%>
		</table>
		<table class="main_seat_table">
			<tr>
				<td>
					<input type="button" value="돌리기">
				</td>
			</tr>
		</table>
	</div>
	
	<script>
		var checked = <%= expert %>
	
		function add_div(){
			var div = document.createElement('div');
			div.innerHTML = document.getElementById('add_sample').innerHTML;
			document.getElementById('add_place').appendChild(div);
		}
		
		function remove_div(obj){
			document.getElementById('add_place').removeChild(obj.parentNode);
		}
		
		function seat_click(obj){
			var separation = obj.style.backgroundColor == "rgb(185, 228, 201)";
			
			if(separation == true){
				obj.style.backgroundColor = "rgba(255,255,255,0)";
				checked --;
			} else {
				if(checked < <%= expert %>){
					obj.style.backgroundColor = "#B9E4C9";
					checked++;
				}
			}
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