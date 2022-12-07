<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String context = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
/* 미결재 알림 */
$.ajax({
	type:'POST',
	url: '${ pageContext.request.contextPath }/approval/notAuthApvCount',
	success: function(data){
		//console.log(data);
		$('#apvCount2').text(data);
		$('#apvCount3').text(data);
	}
})
$.ajax({
	type:"POST",
	url:"${ pageContext.request.contextPath }/email/count",
	success:function(data){
		$("#email_count").html(data);
		$("#menu_email_count").html(data);
		$("#main_email_count").html(data);
		$("#header_email_count").html(data);
		$("#header_email_count2").html(data);
	}
});
setInterval('email()', 30000)

function email(){
	if($("#emp.emp_num").val() == "") {
		$(location).attr("href", "/logoutForm");
	}
	$.ajax({
		type:"POST",
		url:"${ pageContext.request.contextPath }/email/pop3",
		success:function(data){
			$("#email_count").html(data);
			$("#menu_email_count").html(data);
			$("#main_email_count").html(data);
			$("#header_email_count").html(data);
			$("#header_email_count2").html(data);
		}
	});
}
$(document).ready(function() {
	if($("#emp.emp_num").val() == "") {
		$(location).attr("href", "/logoutForm");
	}
});
</script>
</head>
<body>
<input type="hidden" id="header_member_id" value="${sessionScope.member.member_id}"/>
 <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow" style="margin-bottom:0rem !important;">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>
          
		  <div><a href="/auth_finder"><img id="main_file_img" src="${pageContext.request.contextPath}/resources/img/icon.png" alt="사진"  height="60px"></a></div>
	        
          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">
			
          <!-- 채팅 -->
      	 <li class="nav-item">
	      	 <a class="nav-link">
		     	 <i class="fa-solid fa-comments"></i>
     		 </a>
    	 </li> 
    

            <!-- Nav Item - Alerts -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                <!-- 미결재 알람 -->
                <span class="badge badge-danger badge-counter"><span id="apvCount2"></span></span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                  미결재 알림
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-primary">
                      <i class="fas fa-file-alt text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">미결제 알람</div>
                    <span class="font-weight-bold">미결제 문서가(<strong id="apvCount3"></strong>)건 있습니다.<br>확인해주세요! </span>
                  </div>
                </a>
                
                <a class="dropdown-item text-center small text-gray-500" href="${pageContext.request.contextPath}/approval/notAuthApvList?page=1">문서함으로 가기</a>
              </div>
            </li>

            <!-- Nav Item - Messages -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Messages -->
                <span class="badge badge-danger badge-counter"> <span id="header_email_count"></span> <!-- 숫자가 들어갈 공간 -->  </span>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
                <h6 class="dropdown-header">
                  새로운 메일
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                   <div class="icon-circle bg-primary">
                <i class="far fa-envelope text-white"></i>
                   
 </div>
                    
                  </div>
               
                  <div class="font-weight-bold">
                  <div class="small text-gray-500">확인하지 않은 메일</div>
                    <div class="text-truncate">미확인 메일이 (<span id="header_email_count2">0</span>)건 있습니다. <br> 확인해주세요!</div>
                    
                  </div>
                </a>
                
                
                
                <a class="dropdown-item text-center small text-gray-500" href="${pageContext.request.contextPath}/email/receive">받은 메일함으로 가기</a>
              </div>
            </li>

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- 유저 정보 탭 [마이페이지],[로그아웃],[이름 출력] -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${emp.emp_name}님</span>
                
                <i class="fas fa-user"></i>
              </a>
              
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
	           		<!-- 마이 페이지 [분기] 관리자 & 일반 유저 -->
	           		<c:choose>
	           			<c:when test="${emp.auth_num eq 0}">
	           				<a class="dropdown-item" href="/adminMyPageForm">
			                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>내 정보
			                </a>
			            </c:when>
			            
	           			<c:otherwise>
		           			<a class="dropdown-item" href="/userMyPageForm">
			                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>내 정보
			                </a>
	           			</c:otherwise>
	                </c:choose>
	                
	                <a class="dropdown-item" href="${pageContext.request.contextPath}/member/myboard?member_name=${sessionScope.member.member_name}">
	                  <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>내 게시글
	                </a>
                
					<!-- 로그아웃 버튼  -->
	                <div class="dropdown-divider"></div>
		            <a class="dropdown-item" data-toggle="modal" data-target="#logoutModal">
		            <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>로그아웃
		     		</a>
		     		
              </div>
            </li>

          </ul>

        </nav>
		  <!-- 로그 아웃 [모달], 로그아웃 버튼 선택시 모달 창이 나온다. 로그아웃 시에 로그인 창으로 이동한다.-->
		  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		    <div class="modal-dialog" role="document">
		      <div class="modal-content">
		        <div class="modal-header">
		          <h5 class="modal-title" id="exampleModalLabel">로그아웃하시겠습니까?</h5>
		          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
		            <span aria-hidden="true">×</span>
		          </button>
		        </div>
		        <div class="modal-body">로그아웃을 누르시면 현재 세션을 벗어나 로그인 창으로 이동합니다.</div>
		        <div class="modal-footer">
		          <button class="btn btn-outline-primary" type="button" data-dismiss="modal">돌아가기</button>
		          <a class="btn btn-outline-primary" href="/logoutForm">로그아웃</a>
		        </div>
		      </div>
		    </div>
		  </div>        
	</body>
</html>