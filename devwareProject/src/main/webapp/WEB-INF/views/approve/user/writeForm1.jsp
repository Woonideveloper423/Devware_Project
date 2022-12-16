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
	var prg_name1  = $('#authName_ath1').val();
	
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
		return false;
	}
	if(($('#app_title').val()).trim() == ''){
		alert('제목을 입력해주세요')
		return false;
	}
	if(($('#summernote').val()).trim() == ''){
		alert('내용을 입력해주세요')
		return false;
	}
	var chkConfirm = confirm('제출 이후에는 삭제하실 수 없습니다.\n정말 제출 하시겠습니까?');
	   if (chkConfirm) {

	   }
	   else {
		   return false;
	   }

<%-- 	if(confirm('제출 이후에는 삭제하실 수 없습니다.\n정말 제출 하시겠습니까?')){
		if(doubleSubmitFlag){
			

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
							
							emp_num 	 : ${ sessionScope.empForSearch.emp_num }
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
	} --%>
}// sendApv end  

function selectMem(){
	window.open('${pageContext.request.contextPath}/pikAuthMem','결제자선택','width=1100 , height=500 ,resizable = no, scrollbars = no');
} // selectMem end 


function reWritrApv(){

	if($('#authId1').val(${ reWrite.prg_num1 } ) == ''){
		alert('결재라인을 선택해주세요')
		return false;
	}
	if(($('#app_title').val()).trim() == ''){
		alert('제목을 입력해주세요')
		return false;
	}
	if(($('#summernote').val()).trim() == ''){
		alert('내용을 입력해주세요')
		return false;
	}
	
	var chkConfirm = confirm('정말 저장 하시겠습니까?');
	   if (chkConfirm) {

	   }
	   else {
		   return false;
	   }

	<%-- if(confirm('제출 이후에는 삭제하실 수 없습니다.\n정말 제출 하시겠습니까?')){
		 if(doubleSubmitFlag){
			
			doubleSubmitFlag = false;

			$.ajax({
				url : "<%=context%>/reWriteApprove",
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

							emp_num 	 : ${ sessionScope.empForSearch.emp_num }
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
	} --%>
} // reWritrApv end   


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

	<!-- 관리부서 -->
	<c:choose>
	
	<c:when test="${ empty sessionScope.empForSearch.position_name }">관리자</c:when>
	<c:otherwise>${ empForSearch.emp_name }</c:otherwise>
	
	</c:choose></td>
	<td><strong>기안부서 </strong>
	
	<c:choose>
	
	<c:when test="${ sessionScope.empForSearch.dept_name == null }">관리자</c:when>
	<c:otherwise>${ empForSearch.dept_name }</c:otherwise>
	
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

	
    <table>
	<tr><td width="50%">
	<div class="float-center">
		<button class="btn btn-outline-primary" onclick="selectMem()">결재라인 추가</button>
	</div>
	</td>
	<c:choose>
		<c:when test="${reWrite.app_num != null }">
			<form id="sendApv" method="POST" enctype="multipart/form-data" onsubmit="return reWritrApv()" action="<%=context%>/reWriteApprove">
		</c:when>
		<c:otherwise>
			<form id="sendApv" method="POST" enctype="multipart/form-data" onsubmit="return sendApv()" action="<%=context%>/writeApprove">
		</c:otherwise>
	</c:choose>
	     
  
	<td width="50%">
	<div class="float-right">
	<table border="1" style="display: inline-block">
	
	<tr>
		<td class="tt" rowspan='3'>결재</td>
		<td class="aa">작성자</td>
		<td id="authRank1" class="aa">${ reWrite.position_name1 }</td>
		<td id="authRank2" class="aa">${ reWrite.position_name2 }</td>
		<td id="authRank3" class="aa">${ reWrite.position_name3 }</td>
	</tr>
	
	<tr>
		<td>${ sessionScope.empForSearch.emp_name }</td>
		<td id="authName1">${ reWrite.prg_name1 }</td>
		<td id="authName2">${ reWrite.prg_name2 }</td>
		<td id="authName3">${ reWrite.prg_name3 }</td>
	</tr>
	
	<tr>
		<td>${ sessionScope.empForSearch.emp_num }</td>
		<td id="apv_mem1">${ reWrite.prg_num1 }</td>
		<td id="apv_mem2">${ reWrite.prg_num2 }</td>
		<td id="apv_mem3">${ reWrite.prg_num3 }</td>
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

	<!-- 사번  -->
	<input type="hidden" id="apv_mem_ath1" name="prg_num1" value="${ reWrite.prg_num1 }">
	<input type="hidden" id="apv_mem_ath2" name="prg_num2" value="${ reWrite.prg_num2 }">
	<input type="hidden" id="apv_mem_ath3" name="prg_num3" value="${ reWrite.prg_num3 }">
	<!-- 이름  -->
	<input type="hidden" id="authName_ath1" name="prg_name1" value="${ reWrite.prg_name1 }">
	<input type="hidden" id="authName_ath2" name="prg_name2" value="${ reWrite.prg_name2 }">
	<input type="hidden" id="authName_ath3" name="prg_name3" value="${ reWrite.prg_name3 }"> 
	

	<input type="hidden" id="emp_num" name="emp_num" value="${sessionScope.empForSearch.emp_num }">
	<c:if test="${not empty reWrite.app_num }">
		<input type="hidden" id="app_num" name="app_num" value="${reWrite.app_num }">
	</c:if>
							
	
	&nbsp;제목 : <input class="form-control" id="app_title" type="text" name="app_title" value="${ reWrite.app_title }">
	<br>
	
	<div>
		<textarea class="form-control" id="summernote" name="app_content" >${ reWrite.app_content }</textarea> <br>
	</div>
	
	
	<label for="file">첨부:</label><input type="file" name="files" multiple="multiple"/>
	  <hr>
         <div class="container" align="center">
		<input class="btn btn-outline-primary" type="button" value="뒤로가기" onclick="history.back(-1);">
		<c:choose>
			<c:when test="${reWrite.app_num != null }">
				<input class="btn btn-outline-primary" type="submit" value="저장하기">
			</c:when>
			<c:otherwise>
				<input class="btn btn-outline-primary" type="submit" value="제출하기">
			</c:otherwise>
		</c:choose>
		
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