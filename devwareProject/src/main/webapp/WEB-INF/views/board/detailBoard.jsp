<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>Insert title here</title>
<!-- 헤드 네비게이션 효과 -->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/board/boardWriteForm.css" rel="stylesheet">

<!-- include libraries(jQuery, bootstrap) -->
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js'></script>

<script type='text/javascript'>

$(function(){ 
	getReplyList();   // 댓글목록 ajax 조회
	$('#delete_btn').hide();
	 if(${board.emp_num}==${emp.emp_num}){ // 게시글 삭제 버튼 동적 생성
		$('#delete_btn').show();
	}else{
		$('#delete_btn').hide();
		
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
 	
	});	

	function getReplyList(){ // 댓글 리스트 ajax 이벤트
		var	replyData = $('#detail_info').serialize();
		console.log(replyData);
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
            		showReplyList(this.dept_name,this.emp_name,this.brd_content,this.brd_date,this.brd_num,this.brd_re_level,this.brd_re_step);
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
	
function showReplyList(dept_name,emp_name,brd_content,brd_date,brd_num,brd_re_level,brd_re_step){ // 게시물 댓글 목록 출력 함수
	replyStr+="<div style='margin-left:"+ (parseInt(brd_re_level) * 30) +"px' class='d-flex mb-4'>";
	replyStr+="<input type='hidden' id='step"+brd_num+"'  value='"+brd_re_step+"'>";
	replyStr+="<input type='hidden' id='level"+brd_num+"' value='"+brd_re_level+"'>";
	replyStr+="<div class='flex-shrink-0'><img class='rounded-circle' src='https://dummyimage.com/50x50/ced4da/6c757d.jpg' alt='...' /></div>";
	replyStr+="<div class='ms-3'>";
	replyStr+="<div class='fw-bold'>" +dept_name+"&nbsp;&nbsp;"+emp_name+"</div>";
	replyStr+=brd_content;
	replyStr+="<br>"+brd_date+"&nbsp; <a href='#' onclick='return false'; class='re_reply_btn' id='"+brd_num+"'>답글쓰기</a>";
	replyStr+="</div> </div>";
	replyStr+="<div id='reply"+brd_num+"'>";
	replyStr+="</div>";
}
    

function writeReReply(brd_num,step,level){ // 답글 등록폼 show 이벤트

	var str="<form class='mb-4' id='re_reply_form'name='re_reply_form' action='/ajaxWriteReply' method='post'>";
  		str+="<textarea id='brd_content' name='brd_content' class='form-control' rows='3' placeholder='답글을 입력해주세요'></textarea>";
	    str+="<input type='hidden' name='brd_type' 	value='${board.brd_type}'>";
	    str+="<input type='hidden' name='brd_ref'	value='${board.brd_ref}'>";
	    str+="<input type='hidden' name='brd_re_level'	value='"+level+"'>";
	    str+="<input type='hidden' name='emp_num'	value='${emp.emp_num}'>";
	   	str+="<input type='hidden' name='brd_re_step'	value='"+step+"'>" ; 
	   	str+="<input type='hidden' name='brd_num'	value='${board.brd_num}'>";
	    str+="<input type='hidden' name='dept_num' 	value='${emp.dept.dept_num}'>";
	   	str+="<div style='margin-top: 5px' align='right'><button type='button' name='re_reply_btn' id='re_reply_btn'  class='btn btn-primary' onclick='reReplyBtn()'>등록</button></div>";
	   	str+="</form>";
	
	$('#reply'+brd_num).html(str); 
	
}	
	
function replyBtn(){  // 댓글 등록 ajax 이벤트
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
                getReplyList(); //댓글 리스트 갱신
                
            },
            error:function(request,status,error){
                alert('code = '+ request.status + ' message = ' + request.responseText + ' error = ' + error); // 실패 시 처리
            },
            complete : function(data){
				
            }
        });

   }
function reReplyBtn(){  // 답글 등록 ajax 이벤트
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
                getReplyList(); // 댓글 리스트 갱신
                
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
    </script>
</head>
<body>
	<!--  게시글 정보 GET form -->
	<form id='detail_info' name='detail_info' method="get">                             
		<input type="hidden" name="brd_type" value="${board.brd_type }">
		<input type="hidden" name="brd_num"  value="${board.brd_num }">
		<input type="hidden" name="dept_num" value="${emp.dept.dept_num}">
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
	${board.brd_content } 
	
	<div class='upload_File'>
		<첨부파일 구현>
	</div>
	</div>
	<hr>
	
	 <!-- 댓글영역 section	-->
           <section class='mb-5'>
               <div class='card bg-light'>
                   <div class='card-body'>
                    
                       <!-- 댓글 작성 폼-->
                       <form class='mb-4' id='reply_form'name='reply_form'  action="/reply/write" method='post'>
	                       <textarea id='brd_content' name='brd_content' class='form-control' rows='3' placeholder='댓글을 입력해 주세요.'></textarea>
	                       <input type='hidden' name='brd_type' 	value='${board.brd_type }'>
						   <input type='hidden' name='brd_ref'		value='${board.brd_ref}'>
						   <input type='hidden' name='brd_re_level'	value='${board.brd_re_level}'>
						   <input type='hidden' name='emp_num'		value='${emp.emp_num}'>
						   <input type='hidden' name='brd_re_step'	value='${board.brd_re_step}'>
						   <input type='hidden' name='dept_num' 	value='${emp.dept.dept_num }'> 
						   <input type='hidden' name='brd_num' 	value='${board.brd_num}'> 
	                       <div style='margin-top: 5px' align='right'><button type='button' name='reply_btn' id='reply_btn'  class='btn btn-primary' onclick='replyBtn()'>등록</button></div>
                       </form>
                       <!-- 댓글 List 영역(javascript 구현) -->
                      <div class='reply_data' id='reply_data'></div>
                          </div>
               </div>
           </section>           	 
     
     <!-- 게시글 목록,삭제,수정 버튼 div -->
     <div align='right'>
		<button class='btn btn-primary btn-lg' onclick="location.href='/board/checkList?brd_type=${board.brd_type}'">
		<i class="fa-solid fa-list"></i>목록</button>
		<!-- 삭제 trigger modal -->
		<button id='delete_btn' class="btn btn-danger btn-lg" data-toggle="modal" data-target="#exampleModal"><i class="fa-solid fa-trash"></i>삭제</button>
		<!-- 삭제 Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel"><i class="fa-solid fa-circle-exclamation"></i>게시물 삭제</h5>
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
	</div>
	

	
	

				

	
</body>
</html>            			
                          	 
                     	
    
	
	

	         
         
            	
            	
            	
            	
            	
  
