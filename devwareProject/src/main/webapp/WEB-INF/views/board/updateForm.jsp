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
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>
	
<script type="text/javascript">
$(document).ready(function(){

	$('#brd_content').summernote({
		  lang: 'ko-KR',
	      height: 400,
	      popover: {
	    	  image:[],
	    	  link:[],
	    	  air:[]
	      } ,
	      toolbar: [
	    	    // [groupName, [list of button]]
	    	    ['style', ['bold', 'italic', 'underline', 'clear']],
	    	    ['font', ['strikethrough', 'superscript', 'subscript']],
	    	    ['fontsize', ['fontsize']],
	    	    ['color', ['color']],
	    	    ['para', ['ul', 'ol', 'paragraph']],
	    	    ['table', ['table']],
	    	    ['insert', ['link', 'picture', 'hr']],
	    	    ['height', ['height']]
	    	  ],
	    	  focus: true,
				callbacks: {
					onImageUpload: function(files, editor, welEditable) {
			            for (var i = files.length - 1; i >= 0; i--) {
			            	sendFile(files[i], this);
			            }
			        }
				}
	  });
}) // SummerNote ready end
</script>
<script>
	function chkInputValue(id, msg) {
		if ($.trim($(id).val()) == "") {
			alert(msg + " 입력해주세요.");
			$(id).focus();
			return false;
		}
		return true;
	}
	function fn_formSubmit() {
		if (!chkInputValue("#brd_title", "글 제목을"))
			return;
		if (!chkInputValue("#brd_content", "글 내용을"))
			return;

		/* $("#writeForm").submit(); */
	}
</script>
</head>
<body>
<c:if test="${msg!=null }">${msg }</c:if>
	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm text-left">
				<br>
				<h2 class="fw-bolder" align="center">게시글 수정</h2>

				<form id="board_update_Info" name="board_update_Info" action="/board/update" method="post" enctype="multipart/form-data">
			
					<div class="form-group">
						<label class="brd_label" for="title">제목:</label> <input placeholder="제목을 입력해 주세요" type="text" class="form-control" id="brd_title" name="brd_title">
					</div>
					<div class="form-group">
						<label class="brd_label" for="brd_label">작성자 정보:</label>
						<input style="width: 130px;" type='text' class="form-control" id="writer_info"  value=" ${emp.dept.dept_name} ${emp.emp_name}" readonly="readonly">
						<input type='hidden' id='dept_num' name='dept_num' value='${emp.dept.dept_num }'>
						<input type='hidden' id='emp_num' name='emp_num' value="${emp.emp_num }">
						<input type='hidden' id='brd_num' name='brd_num' value="${board.brd_num }">
						<input type='hidden' id='brd_type' name='brd_type' value="${board.brd_type}">
					</div>
					<div  class="form-group">
						<label class="brd_label" for="title">작성게시판:</label><br>
						<c:choose>
						<c:when test="${board.brd_type==1}">
						<input  style="width: 130px;" type='text' class="form-control" id="type_name"  value="  사내 게시판" readonly="readonly">
						</c:when>
						<c:when test="${board.brd_type==2}">
							<input style="width: 130px;" type='text' class="form-control" id="type_name" value="${emp.dept.dept_name} 게시판" readonly="readonly">
						</c:when>
						<c:when test="${board.brd_type==3}">
							<input style="width: 130px;" type='text' class="form-control" id="type_name"  value="  Q&A 게시판" readonly="readonly">
						</c:when>
						<c:when test="${board.brd_type==4}">
							<input style="width: 130px;" type='text' class="form-control" id="type_name"  value="스터디&동호회" readonly="readonly">
						</c:when>
						</c:choose>						
					</div>	
					
					<div style="margin-top: -10px;" class="form-group">
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

					<div class="form-submit" align="right">s
							<a href='/board/detail?emp_num=${board.emp_num}&brd_type=${board.brd_type}&brd_num=${board.brd_num}'class="btn-lg btn btn-info">
							<i class="fa-solid fa-rotate-left"></i>돌아가기</a>  
					<button type="submit" id='update_btn' class='btn-lg btn btn-primary'><i class="fa-solid fa-pen" data-toggle="modal" data-target="#updateModal"></i>수정</button>
				</div>	
				</form>
s				<br>
			</div>
		</div>
	</div>
</body>
</html>
