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
					<c:when test="${board.brd_type == 1 }">
						<h2>사내 게시판</h2>
					</c:when>
					<c:when test="${board.brd_type == 2 }">	
						<h2>소속팀 게시판</h2>
					</c:when>
					<c:when test="${board.brd_type == 3 }">
						<h2>Q&A 게시판</h2>
					</c:when>
					<c:when test="${board.brd_type == 4 }">
						<h2>스터디&소모임 게시판</h2>
					</c:when>
					<c:otherwise>
						<h2>오류 게시판</h2>
					</c:otherwise>
				</c:choose>
			</div>
			<hr>
			
			
			<div class="input-group input-group-lg">
			 	<input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg">
			   <span class="input-group-text" id="inputGroup-sizing-lg">검색</span>
			</div>
		   
		   <c:set var="num" value="${page.total-page.start+1 }"></c:set>
		   
		   <ul style="margin-top: 25px; margin-left: -20px" class="nav">
			  <li class="nav-item">
			    <a class="nav-link active" aria-current="page" href="#"><span style="font-size: 18px;">최신순</span></a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#"><span style="font-size: 18px;">추천순</span></a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#"><span style="font-size: 18px;">댓글많은순</span></a>
			  </li>
			</ul>
		   
		   
		   
		   
		   <table style="margin-top: 20px"  class="table table-hover" >
		   		<thead align="center">
		   		<tr>
		   			<th>글번호</th>
		   			<th>제목</th>
		   			<th>작성자</th>
		   			<th>댓글 수</th>
		   			<th>조회 수</th>
		   			<th>작성일</th>
		   			<th>유형</th>
		   		</tr>
		   		</thead>
		   		<tbody align="center">
		   		<c:forEach var="board" items="${typeBrdList }">
			   		<tr>
			   			<td>${num }</td>
			   			<td align="center"><a href="/detailBoard?emp_num=${board.emp_num }&brd_type=${board.brd_type }&brd_num=${board.brd_num}">${board.brd_title }</a></td>
			   			<td>${board.dept_name } ${board.emp_name }</td>
			   			<td>0</td>
			   			<th>0</th>
			   			<th>${board.brd_date }</th>
			   			<th>${board.brd_type }</th>
			   		<c:set var="num" value="${num - 1 }"></c:set>
			   		</tr>
		   		</c:forEach>
		   		</tbody>
		   </table>
		   <hr/>
		   
		   <nav aria-label="Page navigation example">
				  <ul class="pagination pagination-lg justify-content-center">
					  <c:if test="${page.startPage > page.pageBlock }">
					  	<li class="page-item"><a class="page-link" href="/typeBoardList?currentPage=${page.startPage-page.pageBlock}&brd_type=${board.brd_type}">이전</a></li>
					  </c:if>
					  <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				    	<li class="page-item"><a class="page-link" href="/typeBoardList?currentPage=${i }&brd_type=${board.brd_type}">${i }</a></li>
				      </c:forEach>
				  	  <c:if test="${page.endPage<page.totalPage }">
				   		 <li class="page-item"><a class="page-link" href="/typeBoardList?currentPage=${page.startPage+page.pageBlock }&brd_type=${board.brd_type}">다음</a></li>
				    </c:if>
				  </ul>
		  </nav>
		   
	</div>		
</body>
</html>			
			
			
			
			
			
		
		
	
	



