<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>return test</h1>
<c:if test="${msg!=null }">${msg }</c:if>

<br><br><br>
<h3><회원 관리></h3>
	<a href="/board/WriteForm">게시판 글쓰기</a><p>
	<a href="/detailBoard">게시글 상세조회</a><p>



</body>
</html>