<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	alert("로그아웃 되셨습니다.");
	location.href='<%=context%>/loginForm'
</script>
</head>
<body>
</body>
</html>