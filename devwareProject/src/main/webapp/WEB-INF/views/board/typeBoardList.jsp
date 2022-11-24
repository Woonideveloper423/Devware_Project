<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>사내 게시판</title>
 <!-- 헤드 네비게이션 효과 -->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/board/boardWriteForm.css" rel="stylesheet">
</head>
<body>

	<div class="body_box">
			<!-- 게시판 title 분기 -->
			<div class="titlebox" align="center">
				<c:choose>
					<c:when test="${brd_type == 1 }">
						<h2>사내 게시판</h2>
					</c:when>
					<c:when test="${brd_type == 2 }">
						<h2>소속팀 게시판</h2>
					</c:when>
					<c:when test="${brd_type == 3 }">
						<h2>Q&A 게시판</h2>
					</c:when>
					<c:when test="${brd_type == 4 }">
						<h2>스터디&소모임 게시판</h2>
					</c:when>
					<c:otherwise>
						<h2>노멀 게시판</h2>
					</c:otherwise>
				</c:choose>
			</div>
			<hr>
			
			<div class="search_btn input-group input-group-lg">
			  <button class="btn btn-success btn-lg" type="button">검색</button>
			  <input type="text" class="form-control" placeholder="검색어를 입력하세요" aria-label="Example text with button addon" aria-describedby="button-addon1">
		   </div>
		   
		   
		   <table class="table table-hover">
		   		<thead>
		   		<tr>
		   			<th>글번호</th>
		   			<th>제목</th>
		   			<th>작성자</th>
		   			<th>댓글 수</th>
		   			<th>조회 수</th>
		   		</tr>
		   		</thead>
		   		<tbody>
		   		<tr>
		   			<td>1</td>
		   			<td>우루과이 뚜드려 패보자</td>
		   			<td>손흥민</td>
		   			<td>100</td>
		   			<th>100</th>
		   		</tr>
		   		
		   		<tr>
		   			<td>2</td>
		   			<td>호날두 뚜드려 패보자</td>
		   			<td>김민재</td>
		   			<td>100</td>
		   			<th>100</th>
		   		</tr>
		   		</tbody>
		   </table>
		   <hr/>
		   
		   <nav aria-label="Page navigation example">
				  <ul class="pagination pagination-lg justify-content-center">
				    <li class="page-item"><a class="page-link" href="#">이전</a></li>
				    <li class="page-item"><a class="page-link" href="#">1</a></li>
				    <li class="page-item"><a class="page-link" href="#">2</a></li>
				    <li class="page-item"><a class="page-link" href="#">3</a></li>
				    <li class="page-item"><a class="page-link" href="#">다음</a></li>
				  </ul>
		  </nav>
		   
		   
		   
		   
	
	</div>		
</body>
</html>			
			
			
			
			
			
		
		
	
	



