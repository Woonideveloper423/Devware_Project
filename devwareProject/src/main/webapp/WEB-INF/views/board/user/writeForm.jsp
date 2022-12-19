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
  <link href="${pageContext.request.contextPath}/resources/css/board/writeForm.css" rel="stylesheet">

  <!-- include libraries(jQuery, bootstrap,sweetalert) -->
  <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
  <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>  

  <!-- include summernote css/js -->
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	
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
<script type="text/javascript">
	
	let fileIdx = 0; /*[- 파일 인덱스 처리용 전역 변수 -]*/
	function addFile() {
	
		const fileDivs = $('div[data-name="fileDiv"]');
		if (fileDivs.length > 2) {
			alert('파일은 최대 세 개까지 업로드 할 수 있습니다.');
			return false;
		}
		fileIdx++;
		console.log(fileIdx);
			
			var	fileHtml = "<div data-name='fileDiv' class='form-group filebox bs3-primary'>";
			    fileHtml +="<label for='file_"+ fileIdx +"'class='col-sm-2 control-label'></label>";
			    fileHtml +="<div class='col-sm-10'>";
				fileHtml +="<input type='text' class='upload-name' value='파일 찾기' readonly />";
				fileHtml +="<label for='file_"+ fileIdx +"' class='control-label'>찾아보기</label>";
				fileHtml +="<input type='file' name='files' id='file_"+ fileIdx +"' class='upload-hidden' onchange='changeFilename(this)' />";
				fileHtml +="<button type='button' onclick='removeFile(this)' class='btn btn-bordered btn-xs visible-xs-inline visible-sm-inline visible-md-inline visible-lg-inline'>";
				fileHtml +="<i class='fa fa-minus' aria-hidden='true'></i>";
				fileHtml +="</button>";
				fileHtml +="</div>";
				fileHtml +="</div>";
		
		$('#btnDiv').before(fileHtml);
	}
	
	function removeFile(elem) {

		const prevTag = $(elem).prev().prop('tagName');
		if (prevTag === 'BUTTON') {
			const file = $(elem).prevAll('input[type="file"]');
			const filename = $(elem).prevAll('input[type="text"]');
			file.val('');
			filename.val('파일 찾기');
			return false;
		}

		const target = $(elem).parents('div[data-name="fileDiv"]');
		target.remove();
	}
	
	function changeFilename(file) {

		file = $(file);
		const filename = file[0].files[0].name;
		const target = file.prevAll('input');
		target.val(filename);
	}
	
	function chkInputValue(id, msg) {
		if ($.trim($(id).val()) =="") {
			Swal.fire({
				  icon: 'warning',
				  text: msg + ' 입력해 주세요.',
				})
			/* 	alert(msg + " 입력해주세요."); */
			$(id).focus();
			return false;
		}
		return true;
	}
	function chkSelectValue(id, msg) {
		if ($.trim($(id).val()) =="") {
			Swal.fire({
				  icon: 'warning',
				  text: msg + ' 선택해 주세요.',
				})
		/* 	 alert(msg + " 선택해주세요.");  */
			$(id).focus();
			return false;
		}
		return true;
	}
	function fn_formSubmit() {
		if (!chkInputValue("#brd_title", "제목을"))
			return;
		if (!chkSelectValue("#brd_type", "작성게시판을"))
			return;
		if (!chkInputValue("#brd_content", "내용을"))
			return;
		$("#board_write").submit();
	}
</script>
</head>
<body>
<c:if test="${msg!=null }">${msg }</c:if>
	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm text-left">
				<br>
				<h2 class="fw-bolder" align="center">게시글  작성</h2>

				<form id="board_write" name="board_write" action="/board/write" method="post" enctype="multipart/form-data">
			
					<div class="form-group">
						<label class="brd_label" for="title">제목:</label> 
						<input  type="text" class="form-control check" id="brd_title" name="brd_title" placeholder="제목을 입력해 주세요" autocomplete="off">
					<p></p>
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
						<select id='brd_type' name='brd_type' class="form-select form-select-lg mb-3 check" aria-label=".form-select-lg example">
						  <option selected="selected" disabled="disabled">게시판 종류</option>
						  <option value='1'>사내게시판</option>
						  <option value='2'>${emp.dept.dept_name} 게시판</option>
						  <option value='3'>Q&A 게시판</option>
						  <option value='4'>스터디&동호회 게시판</option>
						</select>
					<p></p>	
					</div>	
					<div style="margin-top: -20px;" class="form-group">
						<label class="brd_label" for="content">내용:</label>
						<textarea id="brd_content" class="form-control check" name="brd_content" rows="10"></textarea>
					</div>	 
						<!-- 첨부파일 영역 -->
					<div data-name="fileDiv" class="form-group filebox bs3-primary">
						<label for="file_0" class="col-sm-2 control-label">첨부파일</label>
						<div class="col-sm-10">
							<input type="text" class="upload-name" value="파일 찾기" readonly />
							<label for="file_0" class="control-label">찾아보기</label>
							<input type="file" name="files" id="file_0" class="upload-hidden" onchange="changeFilename(this)" />
						
							<button type="button" onclick="addFile()" class="btn btn-bordered btn-xs visible-xs-inline visible-sm-inline visible-md-inline visible-lg-inline">
								<i class="fa fa-plus" aria-hidden="true"></i>
							</button>
							<button type="button" onclick="removeFile(this)" class="btn btn-bordered btn-xs visible-xs-inline visible-sm-inline visible-md-inline visible-lg-inline">
								<i class="fa fa-minus" aria-hidden="true"></i>
							</button>
						</div>
					</div>
					
					 <!-- 작성 -->
					<div id='btnDiv' class="form-submit" align="right">
							<a href="${pageContext.request.contextPath}/board/checkList?brd_type=${enterBrdType}" class="btn-lg btn btn-primary">돌아가기</a>  
							<a style="color: white" class="btn-lg btn btn-primary" onclick="fn_formSubmit()">작성</a>
					</div>

				</form>


				<br>
			</div>
		</div>
	</div>
</body>
</html>
