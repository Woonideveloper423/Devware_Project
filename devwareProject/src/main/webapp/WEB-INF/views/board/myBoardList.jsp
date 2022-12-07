<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="author" content="colorlib.com">
<title>사내 게시판</title>
 <!-- 헤드 네비게이션 효과 -->
 
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/board/searchForm.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet" />
  
 
</head>
<body>

	<div class="body_box">
			<!-- 게시판 title 분기 -->
			<div class="titlebox" align="center">
				<c:choose>
					<c:when test="${brd_type == 5 }"><h2>My 게시글 목록</h2></c:when>
					<c:otherwise><h2>오류 게시판</h2></c:otherwise>
				</c:choose>		
			</div>
			<hr>
			 
			<!-- 검색폼 -->
			<div class="s003">
		      <form>
		        <div class="inner-form">
		          <div class="input-field first-wrap">
		            <div class="input-select">
		              <select   data-trigger="" name="choices-single-defaul">
		                <option selected="selected">작성자</option>
		                <option>제목</option>
		                <option>댓글</option>
		              </select>
		            </div>
		          </div>
		          <div class="input-field second-wrap">
		            <input id="search" type="text" placeholder="검색어를 입력하세요"/>
		          </div>
		          <div class="input-field third-wrap">
		            <button class="btn-search" type="button">
		              <svg class="svg-inline--fa fa-search fa-w-16" aria-hidden="true" data-prefix="fas" data-icon="search" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
		                <path fill="currentColor" d="M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z"></path>
		              </svg>
		            </button>
		          </div>
		        </div>
		      </form>
		    </div>
			
			
			
			<!-- 게시글 필터항목 -->
		  <c:set var="num" value="${page.total-page.start+1 }"></c:set>
		   
		   <ul style="margin-top: 10px; margin-left: 36.3%; text-align: center;" class="nav">
			  <li  class="nav-item">
			    <a class="nav-link active" aria-current="page" href="#"><span style="font-size: 20px;">최신순</span></a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#"><span style="font-size: 20px;">조회순</span></a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="#"><span style="font-size: 20px;">댓글많은순</span></a>
			  </li>
			</ul>
		   
		   <!--  게시글 목록 -->
		     <table style="margin-top: 20px"  class="table table-hover" >
		   		<thead align="center">
		   		<tr>
		   			<th>글번호</th>
		   			<th>제목</th>
		   			<th>작성자</th>
		   			<th>댓글 수</th>
		   			<th>조회 수</th>
		   			<th>작성일</th>
		   			<th>분류</th>
		   		</tr>
		   		</thead>
		   		<tbody align="center">
		   		<c:forEach var="board" items="${brdCheckList}">
			   		<tr>
			   			<td>${num }</td>
			   			<td align="center"><a href="/board/detail?emp_num=${board.emp_num }&brd_type=${board.brd_type }&brd_num=${board.brd_num}">${board.brd_title }</a></td>
			   			<td>${board.dept_name } ${board.emp_name }</td>
			   			<td>${board.reply_cnt}</td>
			   			<th>0</th>
			   			<th>${board.brd_date }</th>
			   			<c:choose>
			   			<c:when test="${board.brd_type==1 }"><th>사내게시판</th></c:when>
			   			<c:when test="${board.brd_type==2 }"><th>${board.dept_name } 게시판</th></c:when>
			   			<c:when test="${board.brd_type==3 }"><th>Q&A게시판</th></c:when>
			   			<c:when test="${board.brd_type==4 }"><th>스터디&동호회</th></c:when>
			   			</c:choose>
			   		<c:set var="num" value="${num - 1 }"></c:set>
			   		</tr>
		   		</c:forEach>
		   		</tbody>
		   </table>
		   <hr/>
		  <!--  페이징 -->
		   <nav aria-label="Page navigation example">
				  <ul class="pagination pagination-lg justify-content-center">
					  <c:if test="${page.startPage > page.pageBlock }">
					  	<li class="page-item"><a class="page-link" href="/board/checkList?currentPage=${page.startPage-page.pageBlock}&brd_type=5">이전</a></li>
					  	
					  </c:if>
					  <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				    	<li class="page-item"><a class="page-link" href="/board/checkList?currentPage=${i }&brd_type=5">${i }</a></li>
				    	
				      </c:forEach>
				  	  <c:if test="${page.endPage<page.totalPage }">
				   		 <li class="page-item"><a class="page-link" href="/board/checkList?currentPage=${page.startPage+page.pageBlock } &brd_type=5">다음</a></li>
				   		
				    </c:if>
				  </ul>
		  </nav>
		   
	</div>
	
	
	 <script src="${pageContext.request.contextPath}/resources/js/extention/choices.js"></script>
	<script type="text/javascript">
	
	/* 	검색폼 관련 js */
      const choices = new Choices('[data-trigger]',
      {
        searchEnabled: false,
        itemSelectText: '',
      });

    </script>		
	
</body>
</html>			
			
			
			
			
			
		   
		   
		 
		
		
	
	



