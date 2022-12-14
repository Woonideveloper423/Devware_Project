<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>게시판 글쓰기</title>
  <!-- 헤드 네비게이션 효과 -->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/board/boardWriteForm.css" rel="stylesheet">

  <!-- include libraries(jQuery, bootstrap) -->
  <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
  <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>  

  <!-- include summernote css/js -->
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	
<script type="text/javascript">
$(function(){
	$('#brd_content').summernote({
        placeholder: '내용을 작성하세요',
        height: 400,
        maxHeight: 800
    });

	
});

	
</script>
</head>
<body>
<c:if test="${msg!=null }">${msg }</c:if>
	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm text-left">
				<br>
				<h2 class="fw-bolder" align="center">게시글  작성</h2>

				<form id="boardWrite" name="boardWrite" action="/board/write" method="post" enctype="multipart/form-data">
			
					<div class="form-group">
						<label class="brd_label" for="title">제목:</label> <input placeholder="제목을 입력해 주세요" type="text" class="form-control" id="brd_title" name="brd_title">
					</div>
					<div class="form-group">
						<label class="brd_label" for="brd_label">작성자 정보:</label>
						<input style="width: 120px;" type='text' class="form-control" id="emp_id" name="emp_id" value="${emp.dept.dept_name} ${emp.emp_name}" readonly="readonly">
						<input type='hidden' id='dept_num' name='dept_num' value='${emp.dept.dept_num }'>
						<input type='hidden' id='emp_num' name='emp_num' value="${emp.emp_num }">
						<input type='hidden' id='dept_name' name='dept_name' value="${emp.dept.dept_name }">
						
					</div>
					<div class="form-group">
						<label class="brd_label" for="title">작성게시판:</label><br>
						<select id='brd_type' name='brd_type' class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
						  <option selected="selected" disabled="disabled">게시판 종류</option>
						  <option value='1'>사내게시판</option>
						  <option value='2'>${emp.dept.dept_name} 게시판</option>
						  <option value='3'>Q&A 게시판</option>
						  <option value='4'>스터디&동호회 게시판</option>
						</select>
						
					</div>	
					
					<div style="margin-top: -20px;" class="form-group">
						<label class="brd_label" for="content">내용:</label>
						<textarea id="brd_content" class="form-control" name="brd_content" rows="10"></textarea>
					</div>	 
					
					
					<%-- 첨부파일 로직(추후구현) <div>
						<label for="file" >첨부파일:</label>

						<c:forEach var="listview" items="${listview}" varStatus="status">
							<input type="checkbox" name="fileno"
								value="<c:out value="${listview.fileno}"/>">
							<a href="fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>">
								<c:out value="${listview.filename}" />
							</a>
							<c:out value="${listview.size2String()}" />
							<br />
						</c:forEach>

						<input type="file" name="uploadfile" multiple="#" />
					</div> --%>

					<div class="form-submit" align="right">
							<a href="${pageContext.request.contextPath}/board/checkList?brd_type=${enterBrdType}" class="btn-lg btn btn-primary">돌아가기</a>  
							<input type="submit" class="btn-lg btn btn-primary" onclick="fn_formSubmit()" value="작성">
					</div>

				</form>


				<br>
			</div>
		</div>
	</div>
</body>
</html>
