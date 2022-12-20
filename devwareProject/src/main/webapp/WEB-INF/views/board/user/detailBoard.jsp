<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>Insert title here</title>
<!-- 헤드 네비게이션 효과 -->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/board/detailBoard.css" rel="stylesheet">

<!-- include libraries(jQuery, bootstrap,sweetalert ) -->
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js'></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>  

<script type='text/javascript'>
$(function(){ 
	getReplyList(${board.qa_status},0);   // 댓글목록 ajax 조회
	
	$('#update_btn').hide(); 
	$('#delete_btn').hide();
	$('#gathering_btn').hide(); 
	
	if(${board.emp_num}==${emp.emp_num}){ // 게시글 삭제 버튼 동적 생성
		$('#delete_btn').show();
	}else{
		$('#delete_btn').hide();
	}
	
	 if(${board.emp_num}==${emp.emp_num}){ // 게시글 수정 버튼 동적 생성
		$('#update_btn').show();
	}else{
		$('#update_btn').hide();
	}
	 
	 if(${board.emp_num}==${emp.emp_num}&&${board.brd_type}==4&&${board.qa_status}==0){ // 모집완료 버튼 동적 이벤트
		 $('#gathering_btn').html("<i class='fa-solid fa-handshake'></i> 모집완료");
		 $('#gathering_btn').show();
	 }else if(${board.emp_num}==${emp.emp_num}&&${board.brd_type}==4&&${board.qa_status}==1){
		 $('#gathering_btn').html("<i class='fa-solid fa-handshake'></i> 모집중");
		 $('#gathering_btn').show();
	 }else{
		 $('#gathering_btn').hide();
	}
	 
    if(${board.emp_num}==${emp.emp_num}){ // 게시글 수정 버튼 동적 생성
		$('#update_btn').show();
	}else{
		$('#update_btn').hide();
	}
	  
	$(document).on('click','.re_reply_btn',function(){ // 답글쓰기 버튼 이벤트
		var brdNum=$(this).attr('id');
		var replyFormLength= $('#reply'+$(this).attr('id'));
		if(replyFormLength.html().length>0)
		{
			replyFormLength.html(''); 
		}else{
			writeReReply(brdNum,$("#step"+brdNum).val(),$("#level"+brdNum).val());
		}
		console.log($(this).attr('id'));
	})
 	
	$(document).on('click','.save_attachBtn',function(){
 		console.log($(this).attr('id'));
 		console.log($(this).attr('name'));		
 		location.href='/saveAttach?saveName='+$(this).attr('id')+'&realName='+$(this).attr('name');
 	})
	});	
	
	$(document).on('click','.choice_reply_btn',function(){ // 답변 체택 버튼 이벤트
		var step=$(this).attr('id');
		getReplyList(1,step);
	})
	
	function getReplyList(qa_status,brd_re_step){ // 댓글 리스트 ajax 이벤트
		var	replyData = $('#reply_info').serialize();
		console.log(replyData);
		replyData+="&qa_status="+qa_status
		console.log(replyData);
		replyData+="&brd_re_step="+brd_re_step
        $.ajax({
            url:'/replies',
            type:'GET',
            data: replyData,
            dataType:'JSON',
            success : function(data){
            	
                console.log(data); // ajax 데이터 확인용
            	console.log(data.length); // ajax 데이터 확인용
            	
            	replyStr ="";
            	
            	$(data).each(function(){
            		showReplyList(this.dept_name,this.emp_num,this.emp_name,this.emp_gender,this.brd_content,this.brd_date,this.brd_num,this.brd_re_level,this.brd_re_step,this.qa_status);
            	});
            	$('#reply_data').html(replyStr);
            		
         	}, 
            error:function(request,status,error){
                alert('code = '+ request.status + ' message = ' + request.responseText + ' error = ' + error); // 실패 시 처리
            },
            complete : function(data){
				
            }
        });
	}

function showReplyList(dept_name,emp_num,emp_name,emp_gender,brd_content,brd_date,brd_num,brd_re_level,brd_re_step,qa_status){ // 게시물 댓글 목록 출력 함수
	replyStr+="<div style='margin-left:"+ (parseInt(brd_re_level) * 30) +"px' class='d-flex mb-4'>";
	replyStr+="<input type='hidden' id='step"+brd_num+"'  value='"+brd_re_step+"'>";
	replyStr+="<input type='hidden' id='level"+brd_num+"' value='"+brd_re_level+"'>";
	replyStr+="<div class='flex-shrink-0'>";
    if(parseInt(brd_re_level)>=2){
  		replyStr+="&#8627;&nbsp;&nbsp;";}
    if(emp_gender=='남'){
		replyStr+="<img class='rounded-circle' src='${pageContext.request.contextPath}/resources/css/images/man.png' alt='...' /></div>";
	}
    else if(emp_gender=='여'){
		replyStr+="<img class='rounded-circle' src='${pageContext.request.contextPath}/resources/css/images/female.png' alt='...' /></div>";	
	}
	replyStr+="<div class='ms-3'>";
	replyStr+="<div class='fw-bold'><b>" +dept_name+"&nbsp;&nbsp;"+emp_name+"</b>";
	if(parseInt(qa_status)==1){
		replyStr+="&nbsp;&nbsp;<i class='fa-regular fa-circle-check' style='color: #03C75A;'></i><b style='color: #03C75A;'> 채택답변 </b>";
	}
	replyStr+="</div>";
	replyStr+=brd_content;
	replyStr+="<br>"+brd_date+"&nbsp; <a href='#' onclick='return false'; class='re_reply_btn' id='"+brd_num+"'>답글쓰기</a>";
	if(${board.emp_num}==${emp.emp_num}&&${board.brd_type}==3&&parseInt(brd_re_level)==1&&parseInt(qa_status)==0){
		replyStr+="&nbsp;&nbsp;<a href='#' onclick='return false'; class='choice_reply_btn' id='"+brd_re_step+"'><i class='fa-solid fa-circle-check'></i>답변 채택</a>";
	}
	replyStr+="</div> </div>";
	replyStr+="<div id='reply"+brd_num+"'>";
	replyStr+="</div>";
}
    
function writeReReply(brd_num,step,level){ // 답글 등록폼 show 이벤트

	var str= "<form class='mb-4' id='re_reply_form'name='re_reply_form' action='/ajaxWriteReply' method='post'>";
  		str+="<textarea id='brd_content' name='brd_content' class='form-control reReply_content' rows='3' placeholder='답글을 입력해주세요'></textarea>";
	    str+="<input type='hidden' name='brd_type' 	value='${board.brd_type}'>";
	    str+="<input type='hidden' name='brd_ref'	value='${board.brd_ref}'>";
	    str+="<input type='hidden' name='brd_re_level'	value='"+level+"'>";
	    str+="<input type='hidden' name='emp_num'	value='${emp.emp_num}'>";
	   	str+="<input type='hidden' name='brd_re_step'	value='"+step+"'>" ; 
	   	str+="<input type='hidden' name='brd_num'	value='${board.brd_num}'>";
	    str+="<input type='hidden' name='dept_num' 	value='${emp.dept.dept_num}'>";
	   	str+="<div style='margin-top: 5px' align='right'><button type='button' name='re_reply_btn' id='re_reply_btn'  class='btn btn-primary' onclick='reReplyBtn()'><i class='fa-solid fa-pen'></i>등록</button></div>";
	   	str+="</form>";
	
	$('#reply'+brd_num).html(str); 
	
}	
function chkreplyValue(id,msg){ // 댓글 입력 유효성 체크
	if ($.trim($(id).val()) =="") {
		Swal.fire({
			  icon: 'warning',
			  text: msg + ' 입력해 주세요.',
			  position: 'top'
			})
		$(id).focus();
		return false;
	}
	return true;
} 
	
function replyBtn(){ // 댓글 등록 ajax 이벤트
	if (!chkreplyValue(".reply_content","댓글을"))
		return;
	var	replyData = $('#reply_form').serialize()
		console.log(replyData);
        $.ajax({
            url:'/reply/write',
            type:'POST',
            data: replyData,
            dataType:'JSON',
            success : function(data){
               /*  alert('댓글 성공했음'); */
                console.log(data);
                getReplyList(${board.qa_status},0); //댓글 리스트 갱신
                
            },
            error:function(request,status,error){
                alert('code = '+ request.status + ' message = ' + request.responseText + ' error = ' + error); // 실패 시 처리
            },
            complete : function(data){
				
            }
        });

   }

function reReplyBtn(){// 답글 등록 ajax 이벤트
	if (!chkreplyValue(".reReply_content","답글을"))
		return;
	var	replyData = $('#re_reply_form').serialize()
		console.log(replyData);
        $.ajax({
            url:'/reply/write',
            type:'POST',
            data: replyData,
            dataType:'JSON',
            success : function(data){
             /* alert('답글 성공했음'); */
                console.log(data);
                getReplyList(${board.qa_status},0); // 댓글 리스트 갱신
                
            },
            error:function(request,status,error){
                alert('code = '+ request.status + ' message = ' + request.responseText + ' error = ' + error); // 실패 시 처리
            },
            complete : function(data){
				
            }
        });

   }
   
 function deleteChk(delete_info){  // 게시글 삭제 버튼 클릭 이벤트
	 	delete_info.action="/board/delete";
	 	delete_info.method="POST";
	 	delete_info.submit();
 }
 
 function updateBtn(detail_info){ // 게시글 수정 버튼 클릭 이벤트
	 	detail_info.action="/board/UpdateForm";
	 	detail_info.method="GET";
	 	detail_info.submit();
}
 function statusBtn(detail_info){ // 스터디 모집완료(중) 버튼 클릭 이벤트
	 	detail_info.action="/board/updateStatus";
	 	detail_info.method="POST";
	 	detail_info.submit();
}
 </script>
</head>
<body>

	<!--  게시글 정보 GET form -->
	<form id='detail_info' name='detail_info' method="get">                             
		<input type="hidden" name="brd_type" value="${board.brd_type }">
		<input type="hidden" name="brd_num"  value="${board.brd_num }">
		<input type="hidden" name="dept_num" value="${emp.dept.dept_num}">
		<input type="hidden" name="emp_num"  value="${emp.emp_num }">
		<input type="hidden" name="brd_title" value="${board.brd_title}">
		<input type="hidden" name="brd_content"  value="${board.brd_content}">
		<input type="hidden" name="qa_status"  value="${board.qa_status}">
		
		<c:forEach items="${board.boardAttachs}"  var="attach_file">
		 	<input type="hidden" name="saveName"  value="${attach_file.file_save_name }">
		 	<input type="hidden" name="realName"  value="${attach_file.file_original_name}">
		</c:forEach> 
	</form>
	
	<form id='reply_info' name='reply_info' method="get">                             
		<input type="hidden" name="brd_type" value="${board.brd_type }">
		<input type="hidden" name="brd_num"  value="${board.brd_num }">
		<input type="hidden" name="dept_num" value="${emp.dept.dept_num}">
		<input type="hidden" name="emp_num"  value="${emp.emp_num }">
		<input type="hidden" name="brd_title" value="${board.brd_title}">
		<input type="hidden" name="brd_content"  value="${board.brd_content}">
		<input type="hidden" name="qa_status"  value="${board.qa_status}">
		
		<c:forEach items="${board.boardAttachs}"  var="attach_file">
		 	<input type="hidden" name="saveName"  value="${attach_file.file_save_name }">
		 	<input type="hidden" name="realName"  value="${attach_file.file_original_name}">
		</c:forEach> 
	</form>
	
	<!-- 게시글 삭제 POST form -->
	<form id='delete_info' name='delete_info'>                             
		<input type="hidden" name="brd_type" value="${board.brd_type }">
		<input type="hidden" name="brd_num"  value="${board.brd_num }">
		<input type="hidden" name="dept_num" value="${emp.dept.dept_num}">
	</form>
	
	<!-- 게시글 상세 -->
	<h2>${board.brd_title }</h2>
	<br>
	
	<div id="board_detail">
	<h5>${board.dept_name } ${board.emp_name } &emsp; ${board.brd_date}</h5>
	<hr>
	
	<div>${board.brd_content}</div>
	<div  align="right"><button id='gathering_btn' type="button" class="btn btn-primary" onclick="statusBtn(detail_info)">
	<i class="fa-solid fa-handshake"></i> 모집완료</button></div>
	<hr>
	
	<!-- 첨부파일  div -->
	<div class='upload_File'>
	<label><i class="fa-solid fa-file-lines"></i> 첨부파일</label><br>
		<c:forEach items="${board.boardAttachs}"  var="attach_file">
		<a style="color: blue;"><c:out value="${attach_file.file_original_name}"></c:out></a>
		     &emsp;<button class="save_attachBtn btn btn-outline-primary" id="${attach_file.file_save_name }" name="${attach_file.file_original_name}">다운로드</button> 
		     &emsp;size : <c:out value="${attach_file.file_size }"></c:out>kb<p>	  
		</c:forEach>
	</div>
	</div>
	<hr>
	
	 <!-- 댓글영역 section	-->
           <section class='mb-5'>
               <div class='card bg-light'>
                   <div class='card-body'>
                    
                       <!-- 댓글 작성 폼-->
                       <form class='mb-4' id='reply_form'name='reply_form'  action="/reply/write" method='post'>
	                       <textarea id='brd_content' name='brd_content' class='form-control reply_content' rows='3' placeholder='댓글을 입력해 주세요.'></textarea>
	                       <input type='hidden' name='brd_type' 	value='${board.brd_type }'>
						   <input type='hidden' name='brd_ref'		value='${board.brd_ref}'>
						   <input type='hidden' name='brd_re_level'	value='${board.brd_re_level}'>
						   <input type='hidden' name='emp_num'		value='${emp.emp_num}'>
						   <input type='hidden' name='brd_re_step'	value='${board.brd_re_step}'>
						   <input type='hidden' name='dept_num' 	value='${emp.dept.dept_num }'> 
						   <input type='hidden' name='brd_num' 	value='${board.brd_num}'> 
	                       <div style='margin-top: 5px' align='right'><button type='button' name='reply_btn' id='reply_btn'  class='btn btn-primary' onclick='replyBtn()'><i class="fa-solid fa-pen"></i>등록</button></div>
                       </form>
                       <!-- 댓글 List 영역(javascript 구현) -->
                      <div class='reply_data' id='reply_data'></div>
                   </div>
               </div>
           </section>           	 
     
     <!-- 게시글 목록,삭제,수정 버튼 div -->
     <div align='right'>
		
		<button id='update_btn' class='btn btn-info btn-lg' onclick="updateBtn(detail_info)">
		<i class="fa-solid fa-pen-to-square"></i>수정</button>
		<!-- 삭제 버튼 및 trigger modal -->
		<button id='delete_btn' class="btn btn-danger btn-lg" data-toggle="modal" data-target="#deleteModal"><i class="fa-solid fa-trash"></i>삭제</button>
		<!-- 삭제 Modal -->
		<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 style="font-weight: bold;" class="modal-title" id="exampleModalLabel"><i style="color: red;" class="fa-solid fa-circle-exclamation"></i>&nbsp;게시물 삭제</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div align="left"  class="modal-body">
		        게시물을 정말 삭제하시겠습니까?
		      </div>
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-primary" onclick="deleteChk(delete_info)">삭제하기</button>
		       	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
		      </div>
		    </div>
		  </div>
		</div>
		<button class='btn btn-primary btn-lg' onclick="location.href='/board/checkList?brd_type=${board.brd_type}'">
		<i class="fa-solid fa-list"></i>목록</button>	
	</div>
	

	
	

				

	
</body>
</html>            			
                          	 
                     	
    
	
	

	         
         
            	
            	
            	
            	
            	
  
