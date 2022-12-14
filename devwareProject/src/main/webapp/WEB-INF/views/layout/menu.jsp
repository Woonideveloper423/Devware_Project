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
	url: '${ pageContext.request.contextPath }/approval/user/notAuthApvCount',
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
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/auth_finder">
		<i class="fa-brands fa-dev"></i>
        <div class="sidebar-brand-text mx-3" style="font-size: 20px;">DEVWARE</div>
      </a>
     
     
      <!-- Divider -->
      <hr class="sidebar-divider my-0">

 	  <li class="nav-item active">
       	  <a class="nav-link" href="${pageContext.request.contextPath}/board/checkList?brd_type=6">
           <i class="fa-solid fa-bullhorn"></i>
          <span style="font-size: 15px;">????????????</span></a>
      </li>
      <hr class="sidebar-divider">
      
   	  <!-- ???????????? -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-pen-nib"></i>
          <span style="font-size: 15px;">????????????</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">??????:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/writeForm1">????????????</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/writeForm2">??????/????????????</a>
            <div class="collapse-divider"></div>
            <h6 class="collapse-header">?????????:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/myApvList?currentPage=1">????????????</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/notAuthApvList?currentPage=1">??????????????? (<span id="apvCount"></span>)</a>
           
          </div>
        </div>
      </li>

      <!-- ???????????? -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-envelope"></i>
          <span style="font-size: 15px;">????????????</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">????????????:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/mail/mailWriteForm">?????? ?????????</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/mail/MailList?listType=1">?????? ????????? (<span id="menu_email_count">0</span>)</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/mail/MailList?listType=0">?????? ?????????</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/mail/MailList?listType=2">?????? ?????????</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/user/mail/MailList?listType=3">?????????</a>
                   
          </div>
        </div>
      </li>
      
      

       <!-- ???????????? -->
        <li class="nav-item">
        <a class="nav-link" href="/user/showCalendar">
          <i class="fas fa-calendar-alt"></i>
          <span style="font-size: 15px;">??? ?????? ??????</span></a>
      	</li>
      
      <!-- ???????????? -->
        <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/user/commute">
          <i class="fas fa-building"></i>
          <span style="font-size: 15px;">????????????</span></a>
      </li>
      
      <!-- ????????? -->
     <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseThree" aria-expanded="true" aria-controls="collapseThree">
        <i class="fa-solid fa-clipboard"></i>
        <span style="font-size:15px;">???????????????</span>
        </a>
        <div id="collapseThree" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">???????????????:</h6>
            <a class="collapse-item" href="/board/checkList?brd_type=1">?????? ?????????</a>
            <a class="collapse-item" href="/board/checkList?brd_type=2">${emp.dept.dept_name} ?????????</a>
            <a class="collapse-item" href="/board/checkList?brd_type=5">My ????????? ??????</a>
             <h6 class="collapse-header">????????????:</h6>
            <a class="collapse-item" href="/board/checkList?brd_type=3">Q&A?????????</a>
            <a class="collapse-item" href="/board/checkList?brd_type=4">?????????&?????????</a>
          </div>
        </div>
      </li>

      
      <!-- ?????? ?????? -->
     <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsemem1" aria-expanded="true" aria-controls="collapsemem1">
          <i class="fa-solid fa-bookmark"></i>
          <span style="font-size: 15px;">?????? ??????</span>
        </a>
        <div id="collapsemem1" class="collapse" aria-labelledby="headingmem" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
             <a class="collapse-item" href="/user/showRoomList">????????? ??????</a>         
           </div>
        </div>
      </li>

     <!-- ????????? -->
      <hr class="sidebar-divider">

    
   	  <!-- ??? ?????? -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsemem" aria-expanded="true" aria-controls="collapsemem">
          <!-- <i class="fas fa-fw fa-wrench"></i> -->
          <i class="fas fa-id-card"></i>
          <span style="font-size: 15px;">??? ????????????</span>
        </a>
        <div id="collapsemem" class="collapse" aria-labelledby="headingmem" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <c:choose>
            	<c:when test="${emp.auth_num eq 0}">
            		 <a class="collapse-item" href="/admin/adminMyPageForm">??? ??????</a>
            	</c:when>
            	<c:otherwise>
            		 <a class="collapse-item" href="/user/userMyPageForm">??? ??????</a>
            	</c:otherwise>
            </c:choose>
            
            <a class="collapse-item" href="${pageContext.request.contextPath}/board/checkList?brd_type=5">??? ?????????</a>            
          
          </div>
        </div>
      </li>
      
      <!-- ????????? -->
      <hr class="sidebar-divider">
      
      <!-- ????????? ?????? -->
      <c:if test="${emp.auth_num eq 0}">
      	<li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
	          <!-- <i class="fas fa-fw fa-wrench"></i> -->
	          <i class="fas fa-cog"></i>
	          <span style="font-size: 15px;">?????????</span>
	        </a>
	        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
		        <div class="bg-white py-2 collapse-inner rounded">
		          
		            <div class="collapse-divider"></div>
		            <h6 class="collapse-header">??????  & ?????? ??????:</h6>
		            <a class="collapse-item" href="/admin/userlist">?????? ?????? ??? ??????</a>
		            <a class="collapse-item" href="/admin/createUserListForm">?????? ????????? ??????</a>
		            
		           	<div class="collapse-divider"></div>
		            <h6 class="collapse-header">????????? ??????:</h6>
		            <a class="collapse-item" href="/admin/manageCalendarMain">?????? ????????? ?????? ??? ??????</a>		           		     
	          	</div>
        	</div>
      </li>
      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">
      </c:if>

    

    </ul>
    <!-- ????????? ?????? -->


</div>
 

</body>

</html>