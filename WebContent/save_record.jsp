<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Arrays"%>
<%@page import="org.apache.catalina.User"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.BufferedWriter"%>
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
	
		int division = Integer.parseInt(request.getParameter("division"));
		int height_line = Integer.parseInt(request.getParameter("height_line"));
		int line = Integer.parseInt(request.getParameter("line"));

		String total_seat = request.getParameter("total_seat");
		
		int[] seat = new int[0];
		String ID = null;
		
		try {
			seat = (int[])application.getAttribute("seat");
			ID = (String)session.getAttribute("ID");
		} catch(Exception e){
			e.printStackTrace();
		}
		
		// 문자로 변경
		String use_seat = Arrays.stream(seat)
		        .mapToObj(String::valueOf)
		        .collect(Collectors.joining(","));
		
		// 파일에 저장
		String filePath = application.getRealPath("/WEB-INF/record/"+ID+".txt");
		
		BufferedWriter bw = null;
		PrintWriter writer = null;
		
		// 저장되는 순서
		// date division line height_line total_seat seat
		
		 Date today = new Date();
		 SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
		 out.println("Date: "+date.format(today));
		
		try {
			bw = new BufferedWriter(new FileWriter(filePath, true));
			writer = new PrintWriter(bw, true);
			
			writer.printf("%s\t%s\t%s\t%s\t%s\t%s", date.format(today) ,division, line, height_line, total_seat, use_seat);
			writer.println("");
			writer.flush();
			writer.close();
		} catch(Exception e){
			e.printStackTrace();
		}
		
		 response.sendRedirect("show_record.jsp");
	%>
</body>
</html>