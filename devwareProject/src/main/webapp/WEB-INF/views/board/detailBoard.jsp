<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Insert title here</title>
<!-- 헤드 네비게이션 효과 -->
<link
	href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/board/boardWriteForm.css"
	rel="stylesheet">

<!-- include libraries(jQuery, bootstrap) -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>

<script type="text/javascript">
$(function(){
	$(document).on("click",".reply-btn",function(){
		var replyFormLength= $("#reply"+$(this).attr("id"));
		if(replyFormLength.html().length>0)
		{
			replyFormLength.html("");
		}else{
			writeReply($(this).attr("id"));
		}
			
	})
})


function writeReply(brd_num){
	
	var str = "<form class='mb-4'.id='reply_form' action='/writeBoardReply' method='post'>";
	str+= "<textarea id='brd_content' name='brd_content' class='form-control' rows='3' placeholder='댓글을 입력해주세요'></textarea>";
    str+= "<div align='right'><input type='submit' class='btn btn-primary' value='등록'></div>";
    str+= "</form>";
    
    $("#reply"+brd_num).html(str);
	
}




</script>




</head>
<body>
	<h2>${board.brd_title }</h2>
	<br>
	<h5>${board.dept_name }${board.emp_name } &emsp; ${board.brd_date}</h5>
	<hr>
	${board.brd_content } ${board.brd_content } ${board.brd_content }
	${board.brd_content }

	<div class="upload_File">
		<첨부파일 구현>
	</div>
	<hr>
	
	 <!-- Comments section-->
           <section class="mb-5">
               <div class="card bg-light">
                   <div class="card-body">
                      
                       <!-- Comment form-->
                       <form class="mb-4" id="reply_form" name="reply_form" action="/writeBoardReply" method="post">
                       <textarea id="brd_content" name="brd_content" class="form-control" rows="3" placeholder="댓글을 입력해주세요"></textarea>
                       <input type="hidden" name="brd_type" 	value="${brd_type }">
					   <input type="hidden" name="brd_ref"		value="${brd_ref}">
					   <input type="hidden" name="brd_level"	value="${brd_level}">
                       <div style="margin-top: 5px" align="right"><input type="submit" class="btn btn-primary" value="등록"></div>
                       </form>
                       
                       <!-- Comment with nested comments-->
                       <div class="d-flex mb-4">
                           <!-- Parent comment-->
                           <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
                           <div class="ms-3">
                               <div class="fw-bold">Commenter Name</div>
                               If you're going to lead a space frontier, it has to be government; it'll never be private enterprise. Because the space frontier is dangerous, and it's expensive, and it has unquantified risks.
                              <!--  Child comment 1 -->
                          </div>
                      </div>
                       
                     	 <!-- Single comment-->
                      <div style="margin-left:35px" class="d-flex mb-4">
                          <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
                          <div class="ms-3">
                              <div class="fw-bold">${board.dept_name } ${board.emp_name }</div>
                              ${board.brd_content}
                              ${board.brd_date} &nbsp; <a class='reply-btn' id='${board.brd_num }' >답글쓰기</a>
                         </div>
                      </div>
                      
                      <div id="reply${board.brd_num }">
                      	 <!-- <form class="mb-4" id=reply_form action="/writeBoardReply" method="post">
                       <textarea id="brd_content" name="brd_content" class="form-control" rows="3" placeholder="댓글을 입력해주세요"></textarea>
                       <div align="right"><input type="submit" class="btn btn-primary" value="등록"></div>
                       </form>   --> 
                      </div>
                      <div style="margin-left:35px" class="d-flex mb-4">
                          <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
                          <div class="ms-3">
                              <div class="fw-bold">${board.dept_name } ${board.emp_name }</div>
                              ${board.brd_content}
                              ${board.brd_date} &nbsp; <a class='reply-btn' id='${board.brd_num }' >답글쓰기</a>
                         </div>
                      </div>
                       
       
                        
                        
                          <!-- Comment form -->
                                       
                   
                   </div>
               </div>
           </section>
	
	

	<div align="right">
		<button class="btn btn-primary btn-lg"
			onclick="location.href='/typeBoardList?brd_type=${board.brd_type}'">목록</button>
	</div>

	
</body>







</html>