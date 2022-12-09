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
   
  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <script src="https://kit.fontawesome.com/5aa66a35d0.js" crossorigin="anonymous"></script>
<title>사내 게시판</title>
 <!-- 헤드 네비게이션 효과 -->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/board/searchForm.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet" />
  
 <!-- include libraries(jQuery, bootstrap) -->
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js'></script>
<script type="text/javascript">
 $(function(){  // 게시글 목록 불러오기
	getBoardList();

}) 
function getBoardList(currentPage){ // 게시글 목록 출력
	$.ajax({
        url:'/board/ajaxCheckList',
        type:'GET',
        data: {"brd_type":'${brd_type}',"currentPage":currentPage},
        dataType:'JSON',
        success : function(data){
        	/* alert("목록조회 성공"); */
            console.log(data); // ajax 데이터 확인용
        	brdListStr ="";
        	$(data.brdCheckList).each(function(){
        		brdListStr+="<tr>";
        		brdListStr+="<td>"+this.rn+"</td>";
        		brdListStr+="<td align='center'><a href='/board/detail?emp_num="+this.emp_num+"&brd_type="+parseInt(this.brd_type)+"&brd_num="+parseInt(this.brd_num)+"'>"+this.brd_title+"</a></td>";
        		brdListStr+="<td>"+this.dept_name+" "+this.emp_name+"</td>";
        		brdListStr+="<td>"+this.reply_cnt+"</td>";
        		brdListStr+="<th>"+this.brd_view+"</th>";
        		brdListStr+="<th>"+this.brd_date+"</th>";
        		brdListStr+="<th>"+this.brd_type+"</th>";
        		brdListStr+="</tr>";
        	});
        	$('#tbody').html(brdListStr);
        	
        	//페이징
        	var pageInfo = "";
    		var startPage = parseInt(data.page.startPage);
    		var endPage   = parseInt(data.page.endPage);
    		var blockSize   = parseInt(data.page.pageBlock);
    		var pageCnt = parseInt(data.page.totalPage);
    		var currentPage = parseInt(data.page.currentPage)
    		if(startPage > blockSize){
    			pageInfo+="<li class='page-item'><a class='page-link' href='javascript:void(0)'";
    			pageInfo+="onclick=getBoardList("+startPage-blockSize+")>이전</a></li>";
    		}
    		for(startPage ; startPage<=endPage ; startPage++){
    				pageInfo+="<li class='page-item'><a class='page-link' href='javascript:void(0)'";
    				pageInfo+="onclick=getBoardList("+startPage+")>"+startPage+"</a></li>";
    		}
    		if(endPage < pageCnt){
    			pageInfo+="<li class='page-item'><a class='page-link' href='javascript:void(0)'";
    			pageInfo+="onclick=getBoardList("+startPage+blockSize+")>다음</a></li>";
    		}
    		$('#pagingNation').html(pageInfo);
     		
        }, 
        
     	error:function(request,status,error){
            alert('code = '+ request.status + ' message = ' + request.responseText + ' error = ' + error); // 실패 시 처리
        },
        complete : function(data){
			
        }
    });
}

</script> 
</head>
<body>
	<div class="body_box">
			<!-- 게시판 title 분기 -->
			<div class="titlebox" align="center">
				<c:choose>
					<c:when test="${brd_type == 1 }"><h2>사내 게시판</h2></c:when>
					<c:when test='${brd_type == 2 }'><h2>${emp.dept.dept_name} 게시판</h2></c:when>	
					<c:when test="${brd_type == 3 }"><h2>Q&A 게시판</h2></c:when>
					<c:when test="${brd_type == 4 }"><h2>스터디&동호회 게시판</h2></c:when>
				<c:otherwise><h2>오류 게시판</h2></c:otherwise>
				</c:choose>		
			</div>
			<hr>
			 
			<!-- 검색폼 -->
			<div class="s003">
		      <form id=search_form>
		        <div class="inner-form">
		          <div class="input-field first-wrap">
		            <div class="input-select">
		              <select   data-trigger="" name='select_type'>
		                <option value='W' selected="selected">작성자</option>
		                <option value='T'>제목</option>
		                <option value='WT'>제목+작성자</option>
		              </select>
		            </div>
		          </div>
		          <div class="input-field second-wrap">
		            <input id="keyword_input" type="text" name='keyword' placeholder='검색어를 입력하세요'/>
		          </div>
		          <div class="input-field third-wrap">
		            <button class="btn-search">
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
		   			<th>유형</th>
		   		</tr>
		   		</thead>
		   		<tbody id="tbody" align="center">
		   		<%-- <c:forEach var="board" items="${brdCheckList}">
			   		<tr>
			   			<td>${num }</td>
			   			<td align="center"><a href="/board/detail?emp_num=${board.emp_num }&brd_type=${board.brd_type }&brd_num=${board.brd_num}">${board.brd_title }</a></td>
			   			<td>${board.dept_name } ${board.emp_name }</td>
			   			<td>${board.reply_cnt}</td>
			   			<th>0</th>
			   			<th>${board.brd_date }</th>
			   			<th>${board.brd_type }</th>
			   			
			   		<c:set var="num" value="${num - 1 }"></c:set>
			   		</tr>
		   		</c:forEach> --%>
		   		</tbody>
		   </table>
		   <hr/>
		   
		   <div class="paging-menu">
			  <!--  페이징 -->
			   <nav  aria-label="Page navigation example">
					  <ul id='pagingNation' class="pagination pagination-lg justify-content-center">
					  </ul> 
			  </nav>
			  <div align="right">
			<button class='btn btn-primary btn-lg' onclick="location.href='/board/WriteForm?brd_type=${brd_type}'">
			<i class="fa-solid fa-pen">글쓰기</i></button>
			 </div> 
		 </div>
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
			
			
			
			
			
		   
		   
		 
		
		
	
	



