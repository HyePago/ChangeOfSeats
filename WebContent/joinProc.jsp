<%@page import="java.io.FileWriter"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
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
	
		String ID = request.getParameter("ID");
		String PW = request.getParameter("PW");
		String GRADE = request.getParameter("GRADE");
		String CLASS = request.getParameter("CLASS");
		
		String filePath = application.getRealPath("/WEB-INF/user/user.txt");
		
		BufferedWriter bw = null;
		PrintWriter writer = null;
		BufferedWriter wrtier = null;
		BufferedReader reader = null;
		
		String[] info = null;
		
		try {
			reader = new BufferedReader(new FileReader(filePath));
			
			while(true){
				String str = reader.readLine();
				
				if(str == null) break;
				
				info = str.split("\t");

				out.print(info[0] + "<br>");
				
				// 아이디가 이미 존재한다면
				if(info[0].equals(ID)) { 
					break;
				}
			}

			// 아이디가 이미 존재한다면
			if(info.length > 0){
				out.print("2" + "<br>");
				if(info[0].equals(ID)){
					out.print("3" + "<br>");
					out.println("<script>alert('이미 존재하는 아이디입니다.'); history.go(-1); </script>");
					return;
				}
			}
			
			// 중복 유효성 검사 후, 회원가입
			bw = new BufferedWriter(new FileWriter(filePath, true));
			writer = new PrintWriter(bw, true);
			
			writer.printf("%s\t%s\t%s\t%s", ID, PW, GRADE, CLASS);
			writer.println("");
			writer.flush();
			writer.close();
		} catch (Exception e){
			e.printStackTrace();
		}
		
		out.println("<script>alert('로그인에 성공하셨습니다.');</script>");
	
		response.sendRedirect("index.jsp");
	%>
</body>
</html>