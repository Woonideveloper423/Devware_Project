<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
<meta charset="UTF-8">
<title>문서결재</title>

<style>

.aa {
width:100px;
}
.tt{
height: 60px;
}

</style>

  <!-- 헤드 네비게이션 효과 -->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/board/boardWriteForm.css" rel="stylesheet">


<!-- include libraries(jQuery, bootstrap) -->
<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
 --><script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- jQuery -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<!-- summernote -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>

<script type="text/javascript">



$(document).ready(function(){

	$('#summernote').summernote({
		  lang: 'ko-KR',
	      height: 200,
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
	  


}) // ready end


var doubleSubmitFlag = true;


function sendApv(){

	var check = true;
	
	if($('#authId1').val() == ''){
		alert('결재라인을 선택해주세요')
		check = false;
		return;
	}
	if(($('#app_title').val()).trim() == ''){
		alert('제목을 입력해주세요')
		check = false;
		return;
	}
	if(($('#summernote').val()).trim() == ''){
		alert('내용을 입력해주세요')
		check = false;
		return;
	}
	
	if(confirm('제출 이후에는 삭제하실 수 없습니다.\n정말 제출 하시겠습니까?')){
		if(doubleSubmitFlag){
			
		
			
			/* alert("첫번째"+$('#authId1').val());
			alert($('#authId2').val());
			alert($('#authId3').val());
			
			alert("두번쨰"+$('#authName_ath1').val());
			alert($('#authName_ath2').val());
			alert($('#authName_ath3').val());
			
			$("#sendApv").attr("action", "${pageContext.request.contextPath}/writeApprove"); // attribute setting
			$('#sendApv').submit(); */
			doubleSubmitFlag = false;

			$.ajax({
				url : "<%=context%>/writeApprove",
				type : 'post',
				data : { 	
							"prg_name1"  : $('#authName_ath1').val(),
							"prg_name2"	 : $('#authName_ath2').val(),
							"prg_name3"	 : $('#authName_ath3').val(),
							
							"prg_num1" 	 : $('#authId1').val(),
							"prg_num2" 	 : $('#authId2').val(),
							"prg_num3" 	 : $('#authId3').val(),
							
							app_title 	 : $('#app_title').val(),
							app_content  : $('#summernote').val(),
							docs_app 	 : $('#docs_app').val(),
						},
				success:function(data){
					alert('성공한듯?')
		 			location.replace("<%=context%>/myApvList");
		 			
				} ,
				error: function (err) {
					//400과 404를 제외한 에러가 발생했을시
						if(err.status !== 400 && err.status !== 404){
							alert(`네트워크 오류로 서버와의 통신이 실패하였습니다.${err.status}`);
						}
				} 
				
			});
		}else{
			return;
		}
	}else{
		return;
	}
}// sendApv end  

function selectMem(){
	window.open('${pageContext.request.contextPath}/pikAuthMem','결제자선택','width=1100 , height=500 ,resizable = no, scrollbars = no');
} // selectMem end 

</script>

</head>
<body>

<div class="container">
<div class="container-fluid">
		<!-- 게시글 -->
 	<div class="col-lg-12">
 			
              <div class="card" >
                <div class="card-header py-3" align="center">
                  <h4><strong>[일반결재 작성]</strong></h4> 
     <table class="table table text-center">
       <tr><td><strong>기안담당</strong>
	${ empForSearch.emp_name }
	
	<!-- 관리부서 -->
	<c:choose>
	
	<c:when test="${ empty sessionScope.empForSearch.position_name }">관리자</c:when>
	<c:otherwise>${ empForSearch.emp_name }</c:otherwise>
	
	</c:choose></td>
	<td><strong>기안부서 </strong>
	
	<c:choose>
	
	<c:when test="${ sessionScope.empForSearch.dept_name == null }">관리자</c:when>
	<c:otherwise>${ empForSearch.emp_name }</c:otherwise>
	
	</c:choose></td>
	
	<%
	  String Date = new java.text.SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date());
	%>
	<td><strong>기안일자</strong> <%=Date %></td>
	
	</tr>
     </table>
                 
                </div>
                
                
                
                <div class="card-body text-center">
                 
                 <!-- 결제칸 -->
    <input type="hidden" id="authDept1" name="authDept1" value="${ empForSearch.dept_name }">
	<input type="hidden" id="authDept2" name="authDept2" value="${ empForSearch.dept_name }">
	<input type="hidden" id="authDept3" name="authDept3" value="${ empForSearch.dept_name }">
	
    <table>
	<tr><td width="50%">
	<div class="float-center">
		<button class="btn btn-outline-primary" onclick="selectMem()">결재라인 추가</button>
	</div>
	</td>
	
	    <form id="sendApv" method="POST" enctype="multipart/form-data"> <!-- ============================================================================================================================================================= -->
  
	<td width="50%">
	<div class="float-right">
	<table border="1" style="display: inline-block">
	
	<tr>
		<td class="tt" rowspan='3'>결재</td>
		<td class="aa">작성자</td>
		<td id="authRank1" class="aa"></td>
		<td id="authRank2" class="aa"></td>
		<td id="authRank3" class="aa"></td>
	</tr>
	
	<tr>
		<td>${ sessionScope.empForSearch.emp_name }멤버 이름</td>
		<td id="authName1"></td>
		<td id="authName2"></td>
		<td id="authName3"></td>
	</tr>
	
	<tr>
		<td>${ sessionScope.empForSearch.emp_num }숫자</td>
		<td id="apv_mem1"></td>
		<td id="apv_mem2"></td>
		<td id="apv_mem3"></td>
	</tr>
	
	</table>
	</div>
  	
	<tr><td align="left">
		<select class="btn btn-outline-primary  btn-sm" id="docs_app" name="docs_app">
			<option value=100 selected="selected">보고서</option>
			<option value=200>기안서</option>
			<option value=300>결재서</option>
			<option value=400>기획서</option>
			<option value=500>계획서</option>
			<option value=600>일반결재서</option>
		</select>
	</td></tr>
	<tr><td colspan="2" align="left">
	
		<!-- 결제칸 끝 -->
		<hr>
           		<!-- 결재기록 --> 

	<input type="hidden" id="authId1" name="approval_mem1" >
	<input type="hidden" id="authId2" name="approval_mem2" >
	<input type="hidden" id="authId3" name="approval_mem3" > 
	
	<input type="hidden" id="authName_ath1" name="authName_ath1" >
	<input type="hidden" id="authName_ath2" name="authName_ath2" >
	<input type="hidden" id="authName_ath3" name="authName_ath3" > 
	
	&nbsp;제목 : <input class="form-control" id="app_title" type="text" name="app_title" ">
	<br>
	
	<div>
		<textarea class="form-control" id="summernote" name="app_content" ></textarea> <br>
	</div>
	
	
	<label for="file">첨부:</label><input type="file" name="file" "/>
	  <hr>
         <div class="container" align="center">
		<input class="btn btn-outline-primary" type="button" value="뒤로가기" onclick="history.back(-1);">
		<button class="btn btn-outline-primary" onclick="sendApv()">제출하기</button>
		<!-- <input class="btn btn-outline-primary" type="submit" value="제출하기" > -->
			<div><br></div>
	</div>        
	
	
	
</form>       
		
                  
                  
                
		
			</div> 

	</div>
		</div>
		</div>
		
		
		<!-- ---------------------------------------------------------- -->

	
 <!-- ============================================================================================================================================================= -->
	
	
<script type="text/javascript">
	
	function selectMem() {
		window.open('${pageContext.request.contextPath}/pikAuthMem','결제자선택','width=1100, height=500 ,resizable = no, scrollbars = no');
	}

	</script>

</body>
</html>