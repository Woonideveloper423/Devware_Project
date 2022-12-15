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
<title>근태결재</title>

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

<!-- summernote -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>

  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <script src='${pageContext.request.contextPath}/resources/fullcalendar/lib/moment.min.js'></script>
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
 <link href="${pageContext.request.contextPath}/resources/css/board/boardWriteForm.css" rel="stylesheet">

<script>

$( function() {
     $( "#datepicker1" ).datepicker({
    	
    		   beforeShow: function (textbox, instance) {
    		       var txtBoxOffset = $(this).offset();
    		       var top = txtBoxOffset.top;
    		       var left = txtBoxOffset.left;
    		       var textBoxWidth = $(this).outerWidth();
    		       console.log('top: ' + top + 'left: ' + left);
    		               setTimeout(function () {
    		                   instance.dpDiv.css({
    		                       top: top-190, //you can adjust this value accordingly
    		                       left: left + textBoxWidth//show at the end of textBox
    		               });
    		           }, 0);

    		   }
    	
    });
  } );
  

  $( function() {
	    $( "#halfPick" ).datepicker({
	    	defaultDate: new Date(),
	    	beforeShow: function (textbox, instance) {
			       var txtBoxOffset = $(this).offset();
			       var top = txtBoxOffset.top;
			       var left = txtBoxOffset.left;
			       var textBoxWidth = $(this).outerWidth();
			               setTimeout(function () {
			                   instance.dpDiv.css({
			                       top: top-210, //you can adjust this value accordingly  
			                       left: left//show at the end of textBox
			               });
			           }, 0);

			   }
	    });
	  } );
  
$( function() {
    var dateFormat = "mm/dd/yy",
      from = $( "#from" )
        .datepicker({
        	defaultDate: new Date(),
          changeMonth: true,
          beforeShow: function (textbox, instance) {
		       var txtBoxOffset = $(this).offset();
		       var top = txtBoxOffset.top;
		       var left = txtBoxOffset.left;
		       var textBoxWidth = $(this).outerWidth();
		               setTimeout(function () {
		                   instance.dpDiv.css({
		                       top: top-210, //you can adjust this value accordingly
		                       left: left//show at the end of textBox
		               });
		           }, 0);

		   }
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#to" ).datepicker({
    	  defaultDate: new Date(),
        changeMonth: true,
        beforeShow: function (textbox, instance) {
		       var txtBoxOffset = $(this).offset();
		       var top = txtBoxOffset.top;
		       var left = txtBoxOffset.left;
		       var textBoxWidth = $(this).outerWidth();
		               setTimeout(function () {
		                   instance.dpDiv.css({
		                       top: top-210, //you can adjust this value accordingly  
		                       left: left//show at the end of textBox
		               });
		           }, 0);

		   }
      })
      .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
      });
 
    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
 
      return date;
    }
  } );



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
	  var emp_num = ${sessionScope.empForSearch.emp_num}
	  $.ajax({
          type	: 'POST',
          url	: "${pageContext.request.contextPath}/getVacation",
          data 	: {
        	  		emp_num
         			 },
         dataType : 'json',
          success: function(vacatcion) {
				console.log(vacatcion);
              // Call the "updateEvent" method
              
              $('#leftVacat').text(vacatcion.va_stock);
              
          }
        });
	  
}) // ready end


/* function sendFile(file, el) {
	var form_data = new FormData();
	form_data.append('file', file);
	$.ajax({
  	data: form_data,
  	type: "POST",
  	url: '${ pageContext.request.contextPath}/approval/apv_textImg',
  	cache: false,
  	contentType: false,
  	enctype: 'multipart/form-data',
  	processData: false,
  	success: function(img_name) {
    		$(el).summernote('editor.insertImage', img_name);
  	}
	});
} // sendFile end
 */

 function selectMem() {
		window.open('${pageContext.request.contextPath}/pikAuthMem','결제자선택','width=1100, height=500 ,resizable = no, scrollbars = no');
	} 


function getLength(){
	
	var to = moment($('#to').val())
	var from = moment($('#from').val())

	if(!isNaN(to.diff(from, 'days'))){
		$('#length').text(to.diff(from, 'days')+1);
	}

}

function selectV(){
	var whatV = $('#whatV').val();
	
	if(whatV == '1_wholeVacat'){
		$('#wholeVacat').css('display','block');
		$('#halfVacat').css('display','none');
	}else if(whatV == '2_halfVacat'){
		$('#wholeVacat').css('display','none');
		$('#halfVacat').css('display','block');
	}
}



var doubleSubmitFlag = true;


function sendApv(){
	
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
	
	getLength();
	if(Number($('#length').text()) > Number($('#leftVacat').text())){
		alert('사용 가능한 연차 수를 확인하세요.');
		return;
	}
	
	if($('#leftVacat').text() == 0){
		alert('사용할 연차 수가 없습니다.');
		return;
	}
	
	
	if($('#whatV').val() == '1_wholeVacat'){ // 연차휴가
		if($('#to').val() == '' || $('#to').val() == null){
			alert('요청기간을 선택하세요.')
			return;
		}else if($('#from').val() == '' || $('#from').val() == null){
			alert('요청기간을 선택하세요.')
			return;
		}
	}else{ // 반차
		if($('#halfPick').val() == '' || $('#halfPick').val() == null){
			alert('요청기간을 선택하세요.')
			return;
		}
	}
	
	
	if(confirm('제출 이후에는 삭제하실 수 없습니다.\n정말 제출 하시겠습니까?')){
			console.log($('#length').text())
			$('#countVacat').val($('#length').text());
			
			console.log("approval_cc "+$('#whatV').val())
			var startdate;
			var enddate
			if($('#whatV').val() == '1_wholeVacat'){ // 연차휴가
					alert('연차');
					$('#approval_cc').val($('#whatV').val());
					$('#approval_startdate').val(moment($('#from').val()).format('YYYY-MM-DD')+" ");
					$('#approval_enddate').val(moment($('#to').val()).format('YYYY-MM-DD')+" ");
			}else{ // 반차
				if($(':radio[name="AMPM"]:checked').val() == 'AM'){
					alert('반차 오전');
					$('#approval_cc').val($('#whatV').val()+'_AM');
					$('#approval_startdate').val(new Date(moment($('#halfPick').val()).format('YYYY-MM-DD')+" "+$('#AM_start').val()));
					$('#approval_enddate').val(new Date(moment($('#halfPick').val()).format('YYYY-MM-DD')+" "+$('#AM_end').val()));
				}else if($(':radio[name="AMPM"]:checked').val() == 'PM'){
					alert('반차 오후');
					$('#approval_cc').val($('#whatV').val()+'_PM');
					$('#approval_startdate').val(new Date(moment($('#halfPick').val()).format('YYYY-MM-DD')+" "+$('#PM_start').val()));
					$('#approval_enddate').val(new Date(moment($('#halfPick').val()).format('YYYY-MM-DD')+" "+$('#PM_end').val()));
				}
			}

			
			
			$.ajax({
				url 	: "<%=context%>/writeApprove2",
				type 	: 'post',
				async   : false,
				dataType: "text",
				data 	: { 	
							"prg_name1"  : $('#authName_ath1').val(),
							"prg_name2"	 : $('#authName_ath2').val(),
							"prg_name3"	 : $('#authName_ath3').val(),
							
							"prg_num1" 	 : $('#authId1').val(),
							"prg_num2" 	 : $('#authId2').val(),
							"prg_num3" 	 : $('#authId3').val(),
							
							app_title 	 : $('#app_title').val(),
							app_content  : $('#summernote').val(),
							comu_app 	 : $('#whatV').val(), 
							start_date	 : $('#approval_startdate').val(),
							end_date	 : $('#approval_enddate').val(), 
							emp_num 	 : ${ sessionScope.empForSearch.emp_num },
						},	
				success:function(data){
					location.replace("<%=context%>/myApvList");
		 			
				} ,
				error: function (err) {
					//400과 404를 제외한 에러가 발생했을시
						if(err.status !== 400 && err.status !== 404){
							alert(`네트워크 오류로 서버와의 통신이 실패하였습니다.${err.status}`);
						}
				},

			}); 
	}
}// sendApv end


function timeChk(){
	console.log($('#timeChk').val());
	console.log(moment($('#halfPick').val()).format('YYYY-MM-DD')+" "+$('#timeChk').val());
}


</script>

</head>
<body>
	
<div class="container">
<div class="container-fluid">

		<!-- 게시글 -->
 	<div class="col-lg-12">
 			
              <div class="card" >
                <div class="card-header py-3" align="center">
                  <h4><strong>[휴가결재 작성]</strong></h4> 
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
	
    
    <!-- 감싸는테이블 -->
    <table width="100%">
	<tr><td>
	<div class="float-center">
		<button class="btn btn-outline-primary" onclick="selectMem()">결재라인 추가</button>
	</div>
	
	</td>
<form id="sendApv3" method="POST" enctype="multipart/form-data"> 
  	
		
	<td rowspan="3"> 
	<!-- 내부테이블 -->
	<table border="1" style="display: inline-block">
	
	<tr>
		<td class="tt" rowspan='3'>결재</td>
		<td class="aa">작성자</td>
		<td id="authRank1" class="aa"></td>
		<td id="authRank2" class="aa"></td>
		<td id="authRank3" class="aa"></td>
	</tr>
		
	<tr>
		<td>${ sessionScope.empForSearch.emp_name }</td>
		<td id="authName1"></td>
		<td id="authName2"></td>
		<td id="authName3"></td>
	</tr>
	
	<tr>
		<td>${ sessionScope.empForSearch.emp_num }</td>
		<td id="apv_mem1"></td>
		<td id="apv_mem2"></td>
		<td id="apv_mem3"></td>
	</tr>
	
	</table></td>
	<tr><td>

</td></tr>
	<tr><td align="left">
	<select class="btn btn-outline-primary  btn-sm" id="whatV" onclick="selectV()" value="">
		<option value="1_wholeVacat" selected="selected">연차휴가</option>
		<option value="2_halfVacat">반차</option>
	</select>
	&nbsp;&nbsp;[잔여일 : <span id="leftVacat"></span>일]</td></tr>
	<tr><td colspan="2" align="left">
	
<div id="wholeVacat">
	요청기간 :
	<label for="from">시작일</label>
	<input class="btn btn-outline-primary  btn-sm" size= 10 type="text" id="from" name="from" onchange="getLength()">
	<label for="to">종료일</label>
	<input class="btn btn-outline-primary  btn-sm" size= 10 type="text" id="to" name="to" onchange="getLength()">
	<span>(&nbsp;총&nbsp;<span id="length"></span>일&nbsp;)</span>
</div>

<div style="display:none;">
	<input type="time" id="AM_start" onchange="timeChk()" value="09:00">
	<input type="time" id="AM_end" onchange="timeChk()" value="13:00">
	<input type="time" id="PM_start" onchange="timeChk()" value="14:00">
	<input type="time" id="PM_end" onchange="timeChk()" value="18:00">
	
	<input type="time" id="whole_start" onchange="timeChk()" value="00:00">
	<input type="time" id="whole_end" onchange="timeChk()" value="23:00">
</div>

<div id="halfVacat" style="display: none;">
	요청기간 :
	<input class="btn btn-outline-primary  btn-sm" size=10 type="text" id="halfPick" name="halfPick" >
	<input type="radio" name="AMPM" value="AM" checked="checked">오전
	<input type="radio" name="AMPM" value="PM">오후
</div>
	
	<td></tr>
	
	
	</table>
	</div>
	<hr>


<script type="text/javascript">
	if('${ apvReWrite.approval_cc }' != ''){
		console.log(('${ apvReWrite.approval_cc }').search("1_wholeVacat"))
		if(('${ apvReWrite.approval_cc }').search("1_wholeVacat") != -1){
			$('#from').val('${ stdate }');
			$('#to').val('${ endate }');
			getLength();
		}else{
			$('#whatV').val('2_halfVacat');
			$('#halfPick').val('${ stdate }');
			$('#wholeVacat').css('display','none');
			$('#halfVacat').css('display','block');
		}
	}
</script>

	<div>
	
	<input type="hidden" id="authId1" name="approval_mem1" >
	<input type="hidden" id="authId2" name="approval_mem2" >
	<input type="hidden" id="authId3" name="approval_mem3" > 
	
	<input type="hidden" id="authName_ath1" name="authName_ath1" >
	<input type="hidden" id="authName_ath2" name="authName_ath2" >
	<input type="hidden" id="authName_ath3" name="authName_ath3" > 
	
	<input type="hidden" id="approval_startdate" name="approval_startdate">
	<input type="hidden" id="approval_enddate" name="approval_enddate" >

	&nbsp;제목 : <input class="form-control" id="app_title" type="text" name="app_title" ">
	<br>
	
	<div>
		<textarea class="form-control" id="summernote" name="app_content" ></textarea> <br>
	</div>
	
	  <hr>
         <div class="container" align="center">
		<input class="btn btn-outline-primary" type="button" value="뒤로가기" onclick="history.back(-1);">
		<button class="btn btn-outline-primary" onclick="sendApv(); return false; ">제출하기</button>
		<!-- <input class="btn btn-outline-primary" type="submit" value="제출하기" > -->
			<div><br></div>
	</div>    
	
</form>
	
		
	
	</div>
</div></div></div></div>



<script type="text/javascript">

function tempchk(){
	if(($('#approval_title').val()).trim() == ''){
		alert('제목을 입력해주세요')
		return;
	}
	if(($('#summernote').val()).trim() == ''){
		alert('내용을 입력해주세요')
		return;
	}

	
	if(Number($('#length').text()) > Number($('#leftVacat').text())){
		alert('사용 가능한 연차 수를 확인하세요.');
		return;
	}
	
	if($('#leftVacat').text() == 0){
		alert('사용할 연차 수가 없습니다.');
		return;
	}
	
	if($('#whatV').val() == '1_wholeVacat'){ // 연차휴가
		if($('#to').val() == '' || $('#to').val() == null){
			alert('요청기간을 선택하세요.')
			return;
		}else if($('#from').val() == '' || $('#from').val() == null){
			alert('요청기간을 선택하세요.')
			return;
		}
	}else{ // 반차
		if($('#halfPick').val() == '' || $('#halfPick').val() == null){
			alert('요청기간을 선택하세요.')
			return;
		}
	}
	$('#comment').modal();
}
</script>

</body>
</html>