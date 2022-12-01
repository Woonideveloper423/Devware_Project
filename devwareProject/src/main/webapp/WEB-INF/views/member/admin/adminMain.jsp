<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인 페이지</title>
</head>
<body>
	${emp.emp_name}님 환영합니다.<p>
	<a href="/userlist">유저 리스트</a><p>
	<a href="/adminMyPageForm">관리자 마이페이지</a><p>
	<a href="/createUserListForm">유저 리스트 만들기</a><p>
</body>
</html>