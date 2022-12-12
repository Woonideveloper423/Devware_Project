<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>


  <!-- 헤드 네비게이션 효과 -->
<link href="<%=context%>/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>
<body id="body">


	
	<div class="container-fluid">
    							<h2>결재함</h2>
    			
	<table class="table table-hover text-center">
<colgroup>
			<col width='8%' />
			<col width='*%' />
			<col width='15%' />
			<col width='15%' />
			<col width='10%' />
			<col width='10%' />
		</colgroup>
		<thead>
	<tr>
	<th>문서번호</th>
	<th>제목</th>
	<th>작성자</th>
	<th>제출일</th>
	<th>문서분류</th>
	<th>상태</th>
	
	</tr>
	</thead>
	
	<c:set var="num" value="${page.total-page.start+1 }"></c:set>
	
	<c:forEach var="apv" items="${listApv }">
		<tr>
			<td>${apv.rn}</td>
			<td><a href="myApvDetail?app_num=${apv.app_num}">${apv.app_title}</a></td><!-- 제목인데 나중에 추가 로 넣음 -->
			<td>${apv.emp_name}</td>
			<td><fmt:formatDate pattern="yyyy/MM/dd" value="${apv.app_date}"/></td>
			<c:if test="${apv.comu_app != null}">
				<td>근태</td>
			</c:if>
			<c:if test="${apv.docs_app != null}">
				<td>문서</td>
			</c:if>
			<td>${apv.app_prg }</td>
		</tr>
		<c:set var="num" value="${num - 1}"></c:set>
	
	</c:forEach>
	
	</table>
	</div>
	<div>
		<ul class="pagination justify-content-center">	
			<c:if test="${page.startPage > page.pageBlock }">
				<a class="page-link" href="myApvList?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<a class="page-link" href="myApvList?currentPage=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage }">
				<a class="page-link" href="myApvList?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
			</c:if>	
		</ul> <!-- Paging end -->

		<div align="center">
			<form id="goSearch" method="POST" action="<%=context%>/apvList/search"> </form>
				
				<input type="checkbox" id="cate1" value="1" > 문서결제문서
				<input type="checkbox" id="cate2" value="2" > 근태결제문서 <br>
				
				
				
				<div class="group" style="align:center;">
				<select class="btn btn-outline-primary dropdown-toggle" id="condition">
					<option value="title">제목</option>
					<option value="writer">제출자</option>
					<option value="apvNum">문서번호</option>
				</select>
						   
					<input class="btn btn-outline-primary" id="word" type="text" placeholder="검색어 입력" aria-label="Search" aria-describedby="basic-addon2">
					<button class="btn btn-outline-primary" id="search" onclick="search()"><i class="fas fa-search fa-sm"></i></button>
					<!-- <button onclick="resetSc()">검색 초기화</button> --> 
				</div>
		</div>
	
	</div>

			
	


</body>
</html>