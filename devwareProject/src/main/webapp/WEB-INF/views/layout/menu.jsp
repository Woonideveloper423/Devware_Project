<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  
  <title>DevWare</title>  
  <script src="https://kit.fontawesome.com/5aa66a35d0.js" crossorigin="anonymous"></script>
  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
  
<%--   <script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
 --%>
  <script src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
  
  <script src="${pageContext.request.contextPath}/resources/js/sb-admin-2.min.js"></script> 
  <script>
function fn_formSubmit(){
	document.form1.submit();	
}

$.ajax({
	type:'POST',
	url: '${ pageContext.request.contextPath }/approval/notAuthApvCount',
	success: function(data){
		//console.log(data);
		$('#apvCount').text(data);
	}
})
</script>
<style>
ul .nav-item {padding-left:7px;}
</style>
</head>

<body>

  <!-- Page Wrapper -->
  <div>

    <!-- Sidebar -->
    <ul class="navbar-nav sidebar sidebar-dark" id="accordionSidebar"">
           <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/member/main">
		<i class="fa-brands fa-dev"></i>
        <div class="sidebar-brand-text mx-3" style="font-size: 20px;">DEVWARE</div>
      </a>
     
     
      <!-- Divider -->
      <hr class="sidebar-divider my-0">

 	  <li class="nav-item active">
       	  <a class="nav-link" href="${pageContext.request.contextPath}/boardList?bgno=2">
          <i class="fas fa-flag"></i>
          <span style="font-size: 15px;">공지사항</span></a>
      </li>
      <hr class="sidebar-divider">
      
   	  <!-- 전자결재 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-pen-nib"></i>
          <span style="font-size: 15px;">전자결재</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">결재:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/approval">일반결재</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/apv_Vacat">근태/휴가결재</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/apv_payment">지출결재</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/approval/tempApvList?page=1">임시저장함</a>
            <div class="collapse-divider"></div>
            <h6 class="collapse-header">결재함:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/approval/myApvList?page=1">내문서함</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/approval/notAuthApvList?page=1">미결재문서 (<span id="apvCount"></span>)</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/approval/yesAuthApvList?page=1">결재완료문서</a>
           
          </div>
        </div>
      </li>

      <!-- 전자메일 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-envelope"></i>
          <span style="font-size: 15px;">전자메일</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">전자메일:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/mail/mailWriteForm">메일 보내기</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/mail/MailList?listType=1">받은 메일함 (<span id="menu_email_count">0</span>)</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/mail/MailList?listType=0">보낸 메일함</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/mail/MailList?listType=2">주요 메일함</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/mail/MailList?listType=3">휴지통</a>
                   
          </div>
        </div>
      </li>
      
      

       <!-- 일정관리 -->
        <li class="nav-item">
        <a class="nav-link" href="/user/showCalendar">
          <i class="fas fa-calendar-alt"></i>
          <span style="font-size: 15px;">내 일정 관리</span></a>
      	</li>
      
      <!-- 근태관리 -->
        <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/commuting/commuting">
          <i class="fas fa-building"></i>
          <span style="font-size: 15px;">근태관리</span></a>
      </li>
      
      <!-- 게시판 -->
     <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
        <i class="fa-solid fa-clipboard"></i>
        <span style="font-size:15px;">전사게시판</span>
        </a>
        <div id="collapseThree" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">사내게시판:</h6>
            <a class="collapse-item" href="/board/checkList?brd_type=1">사내 게시판</a>
            <a class="collapse-item" href="/board/checkList?brd_type=2">${emp.dept.dept_name} 게시판</a>
            <a class="collapse-item" href="/board/checkList?brd_type=5">My 게시글 목록</a>
             <h6 class="collapse-header">커뮤니티:</h6>
            <a class="collapse-item" href="/board/checkList?brd_type=3">Q&A게시판</a>
            <a class="collapse-item" href="/board/checkList?brd_type=4">스터디&동호회</a>
          </div>
        </div>
      </li>

      
      <!-- 자원 요청 -->
     <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsemem1" aria-expanded="true" aria-controls="collapsemem1">
          <i class="fas fa-fw fa-wrench"></i>
          <i class="fa-solid fa-bookmark"></i>
          <span style="font-size: 15px;">자원 요청</span>
        </a>
        <div id="collapsemem1" class="collapse" aria-labelledby="headingmem" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
             <a class="collapse-item" href="/user/showRoomList">회의실 예약</a>
            <a class="collapse-item" href="#"></a>
            <a class="collapse-item" href="#"></a>            
             </div>
        </div>
      </li>

     <!-- 나눔선 -->
      <hr class="sidebar-divider">

    
   	  <!-- 내 정보 -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsemem" aria-expanded="true" aria-controls="collapsemem">
          <!-- <i class="fas fa-fw fa-wrench"></i> -->
          <i class="fas fa-id-card"></i>
          <span style="font-size: 15px;">내 정보관리</span>
        </a>
        <div id="collapsemem" class="collapse" aria-labelledby="headingmem" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <c:choose>
            	<c:when test="${emp.auth_num eq 0}">
            		 <a class="collapse-item" href="/admin/adminMyPageForm">내 정보</a>
            	</c:when>
            	<c:otherwise>
            		 <a class="collapse-item" href="/user/userMyPageForm">내 정보</a>
            	</c:otherwise>
            </c:choose>
            
            <a class="collapse-item" href="${pageContext.request.contextPath}/member/myboard?member_name=${sessionScope.member.member_name}">내 게시글</a>            
          
          </div>
        </div>
      </li>
      
      <!-- 나눔선 -->
      <hr class="sidebar-divider">
      
      <!-- 관리자 메뉴 -->
      <c:if test="${emp.auth_num eq 0}">
      	<li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
	          <!-- <i class="fas fa-fw fa-wrench"></i> -->
	          <i class="fas fa-cog"></i>
	          <span style="font-size: 15px;">관리자</span>
	        </a>
	        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
		        <div class="bg-white py-2 collapse-inner rounded">
		          
		            <div class="collapse-divider"></div>
		            <h6 class="collapse-header">회원  & 인사 관리:</h6>
		            <a class="collapse-item" href="/admin/userlist">사원 조회 및 관리</a>
		            <a class="collapse-item" href="/admin/createUserListForm">사원 리스트 추가</a>
		            
		           	<div class="collapse-divider"></div>
		            <h6 class="collapse-header">캘린더 관리:</h6>
		            <a class="collapse-item" href="/admin/manageCalendarMain">사원 캘린더 조회 및 관리</a>		           		     
	          	</div>
        	</div>
      </li>
      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">
      </c:if>

    

    </ul>
    <!-- 메뉴바 종료 -->


</div>
 

</body>

</html>