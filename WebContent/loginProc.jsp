<%@page import="java.io.FileWriter"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.PrintWriter"%>
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
	
		String filePath = application.getRealPath("/WEB-INF/user/user.txt");
		String ID = request.getParameter("ID");
		String PW = request.getParameter("PW");
		
		BufferedReader reader = null;
		
		try {
			reader = new BufferedReader(new FileReader(filePath));
			
			// 아이디가 존재하고 비밀번호가 일치하는 지 확인
			while(true){
				String str = reader.readLine();
				if(str == null) break;
				
				String[] info = str.split("\t");
				
				// 아이디가 존재한다면
				if(info[0].equals(ID)){
					// 비밀번호가 일치하는 지 확인
					if(info[1].equals(PW)){
						session.setAttribute("ID", ID);
						break;
					}
				}
			} // end_while
			
			if(session.getAttribute("ID") != null){
				response.sendRedirect("index.jsp");
			} else {
				out.println("<script>alert('아이디 혹은 비밀번호를 다시 한 번 확인해주세요.');history.go(-1);</script>");
			}
			
		} catch(Exception e){
			e.printStackTrace();
		}
	%>
</body>
</html>