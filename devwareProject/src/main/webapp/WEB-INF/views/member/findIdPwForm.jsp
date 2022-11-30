<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/basic.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

<script type="text/javascript">
$(function(){
	
	$(document).ready(function(){
		$("input[type='text']:first, input[type='password']:first").focus();
		$("#menu2").hide();
	});
	
	$("#nav_item1").click(function() {
		$("#menu1").show();
		$("#menu2").hide();
	});
	
	//비밀번호 찾기 버튼 클릭시 
	$("#nav_item2").click(function() {
		$("#menu1").hide();
		$("#menu2").show();
	});
	
	// Modal에서 비밀번호 찾기 버튼 눌렀을 때
	$('#find_pw').click(function () {
		// 아이디 찾기에서 입력한 이름과 생년월일을 변수에 저장
		var v_emp_name = $("#emp_name1").val();
		var v_emp_num = $("#emp_num1").val();
		
		// 비밀번호 찾기 tab 클릭
		$("a[href='#menu2']").click();
		
		// 비밀번호 찾기 tab에서 변수에 저장한 값을 input에 넣음
		$("#emp_name2").val(v_emp_name);
		$("#emp_num2").val(v_emp_num);
		
		// Label Zoom 적용
		$("#emp_name2").focus();
		$("#emp_num2").focus();
		$("#emp_id").focus();
    });
	
	$("#btn_find_id").click(function() {
		var check = true;
		
		//매개변수들 
		var v_emp_name = $("#emp_name1").val();
		var v_emp_num = $("#emp_num1").val();
		var v_emp_email = $("#user_email1").val()+"@"+$("#user_email2").val();
		
		if(v_emp_name == "")
		{
			alert("이름을 입력해 주세요");
			check = false;
		}
		
		if(v_emp_num == "")
		{
			alert("사번을 입력해 주세요");
			check = false;
		}
		
		if(isNaN(v_emp_num)) 
		{ 
			alert("사번은 숫자로 입력해주세요"); 
			check = false;
		} 
		
		if(v_emp_email == "@")
		{
			alert("이메일을 입력해 주세요");
			check = false;
		}
		
		if(check == true)
		{
			$.ajax({
				url: "<%=context%>/findId",
				type: 'post',
				data: { emp_name : v_emp_name, 
						emp_num : v_emp_num, 
						emp_email : v_emp_email
				},
				success: function(data){
					if(data.result > 0)
					{
						var result = '<table class="table table-hover text-center">';
						result += data.msg;
						result += '</table>';
						
						$('.modal-body').html(result);
						$("#modal_findId").modal();			
					}
					else{
						alert(data.msg);
					}
				}
			});
		}
	});
	
	$("#btn_find_pw").click(function() {
		var check = true;
		
		//매개변수들 
		var v_emp_name = $("#emp_name2").val();
		var v_emp_num = $("#emp_num2").val();
		var v_emp_id = $("#emp_id").val();
		var v_emp_email = $("#user_email3").val()+"@"+$("#user_email4").val();
		
		//공백 입력시 에러 처리
		if(v_emp_name == "")
		{
			alert("이름을 입력해 주세요");
			check = false;
		}
		
		if(v_emp_num == "")
		{
			alert("사번을 입력해 주세요");
			check = false;
		}
		
		if(v_emp_email == "@")
		{
			alert("이메일을 입력해 주세요");
			check = false;
		}
		
		if(v_emp_id == "")
		{
			alert("아이디를 입력해 주세요");
			check = false;
		}
		
		if(check == true)
		{
			$.ajax({
				url	: "<%=context%>/findPw",
				type: 'post',
				data: {	
					emp_name : v_emp_name,
					emp_id 	 : v_emp_id,
					emp_num	 : v_emp_num,
					emp_email: v_emp_email	
				},
				success: function(data) {
					if(data.result > 0)
					{
						var result = '<table class="table table-hover text-center"><h3>';
						result += data.msg;
						result += '</h3></table>';
						
						$('#result_emp_num').attr('value',data.emp_num);
						$('.modal-body').html(result);
						$("#modal_findPw").modal();			
					}
					else{
						alert(data.msg);
					}
				}
			});
		}
	});
	
	
	//	Label Zoom 효과 - input/select 선택했을 때
	$("input, select").focus(function() {
		// 'textbox' class가 적용된 태그 안에서 input[type="text"], input[type="password"] 검색
		var $input = $('.textbox').find('input[type="text"], input[type="password"]');
		$input.on({
			'focus': function () { // input 태그가 focus를 가지면 'focus' class 추가
				$(this).parent().addClass('focus');
			},
			'blur': function () { // input 태그가 focus를 잃으면
				if ($(this).val() == '') { // input 태그에  값이 없으면 'focus' class 삭제
					$(this).parent().removeClass('focus');                
				}           
			}
		});
		// 'textbox' class가 적용된 태그 안에서 select 검색
		var $select = $('.textbox').find('select');
		$select.on({
			'change': function () { // select 태그 값이 change가 발생하면 'focus' class 추가
				$(this).parent().addClass('focus');
			}
		});
	});
	
});
function changePw()
{	
	var emp_num		   = $('#result_emp_num').val();
	var emp_passwd 	   = $('#passwd').val();
	var emp_passwd_chk = $('#passwd_chk').val();
	
	if($('#passwd').val().length < 8)
	{
		alert('패스워드는 보안상의 이유로 8글자 이상 입력해주세요');
		return false;
	}
	
	if (emp_passwd == emp_passwd_chk)
	{
		$.ajax({
			url : "<%=context%>/changePw",
			type: 'post',
			data: {	emp_passwd , emp_num },
			success: function(data){
				var result = data;
				alert(data);
				if(result == 1)
				{
					alert("암호 변경에 성공했습니다.")
					location.href='<%=context%>/loginForm';
				}
				else{
					alert("암호 변경에 실패했습니다. 다시 입력해주세요");
				}
			}
		});
	}
	else if (emp_passwd != emp_passwd_chk)
	{
		alert("패스워드가 일치하지 않습니다.")
		return false;
	}
}

function changeDomain()
{
	if($('#domain_list').val() == 'type')
	{
		$('#user_email2').val("");
		$('#user_email2').attr("readonly", false);
	}
	else
	{
		$('#user_email2').val($('#domain_list').val());
		$('#user_email2').attr("readonly", true);
	}
	
	if($('#domain_list2').val() == 'type')
	{
		$('#user_email4').val("");
		$('#user_email4').attr("readonly", false);
	}
	else
	{
		$('#user_email4').val($('#domain_list2').val());
		$('#user_email4').attr("readonly", true);
	}
}
</script>


<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.tab-content .active 
{
	padding-left: 0px;
	padding-right: 0px;
}
</style>
</head>
<body>
<div class="container">
	<div class="row justify-content-center">
    	<div class="col-xl-5 col-lg-12 col-md-9" style="height:100% !important">
	    	<div class="card o-hidden border-0 shadow-lg my-5">
	        	<div class="card-body p-0">
	          		<div class="p-5">
	                	
	                	<div class="text-center">
	                    	<h1 class="h4 text-gray-900 mb-4">아이디 / 비밀번호 찾기</h1>
	                	</div>
	                	
	                	<!-- 아이디 비밀번호 선택 바 -->
	                	<ul class="nav nav-tabs textbox">
							<li class="nav-item">
								<a class="nav-link active" id="nav_item1" data-toggle="tab" href="#menu1">아이디 찾기</a>
						    </li>
							<li class="nav-item">
						      	<a class="nav-link" id="nav_item2" data-toggle="tab" href="#menu2">비밀번호 찾기</a>
						    </li>
						</ul>
						
						<!-- 탭 패널  -->
						<div class="tab-content">
							<div id="menu1" class="container tab-pane active"><br>
							    
							    <!-- 이름 -->
								<div class="form-group textbox">
									<label for="emp_name1">이름</label>
									<input type="text" class="form-control" id="emp_name1" name="emp_name" maxlength="12">
								</div>
								
								<!-- 사번 -->
								<div class="form-group textbox">
									<label for="emp_num1">사번</label>
									<input type="text" class="form-control" id="emp_num1" name="emp_num">
								</div>
								
								<!-- 이메일 -->
								<div class="form-group textbox">
									<label for="user_email1">이메일</label>
									<input type="text" class="form-control" name="user_email1" id="user_email1"> <br> 
									<input type="text" class="form-control" placeholder="도메인 입력, @는 자동으로 입력됩니다."  class="email" name="user_email2" id="user_email2">
									<select name="email" class="form-control" id="domain_list" onclick="changeDomain()">
										<option value="naver.com">naver.com</option>
										<option value="daum.net">daum.net</option>
										<option value="gmail.com">gmail.com</option>
										<option value="type" selected="selected">직접 입력</option>
									</select>
								</div>
								
								<!-- 아이디 찾기 버튼 -->
								<div class="form-group textbox">
									<button id="btn_find_id" type="button" class="btn btn-primary">아이디 찾기</button>
								</div>
								
								<div class="form-group textbox">
		 							<a href="/loginForm" class="btn btn-google btn-user btn-block">로그인 창으로 돌아가기 </a>
								</div>
							</div>
							
							
							<div id="menu2" class="container tab-pane active"><br>
							    
							    <!-- 아이디 -->
								<div class="form-group textbox">
									<label for="emp_id">아이디</label>
									<input type="text" class="form-control" id="emp_id" name="emp_id">
								</div>
													    
							    <!-- 이름 -->
								<div class="form-group textbox">
									<label for="emp_name2">이름</label>
									<input type="text" class="form-control" id="emp_name2" name="emp_name" maxlength="12">
								</div>
								
								<!-- 사번 -->
								<div class="form-group textbox">
									<label for="emp_num1">사번</label>
									<input type="text" class="form-control" id="emp_num2" name="emp_num">
								</div>
								
								<!-- 이메일 -->
								<div class="form-group textbox">
									<label for="user_email3">이메일</label>
									<input type="text" class="form-control" name="user_email3" id="user_email3"> <br> 
									<input type="text" class="form-control" placeholder="도메인을 입력해 주세요 @는 자동으로 입력됩니다."  class="email" name="user_email4" id="user_email4">
									<select name="email" class="form-control" id="domain_list2" onclick="changeDomain()">
										<option value="naver.com">naver.com</option>
										<option value="daum.net">daum.net</option>
										<option value="gmail.com">gmail.com</option>
										<option value="type" selected="selected">직접 입력</option>
									</select>
								</div>
								
								<!-- 비밀번호 찾기 버튼 -->
								<div class="form-group textbox">
									<button id="btn_find_pw" type="button" class="btn btn-primary">비밀번호 찾기</button>
								</div>
								
								<div class="form-group textbox">
		 							<a href="/loginForm" class="btn btn-google btn-user btn-block">로그인 창으로 돌아가기 </a>
								</div>
			
							</div>							
						</div>
						
	            	</div>
	        	</div>
	    	</div>
		</div>
	</div>

	<div class="modal fade" id="modal_findId">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      
	     <!-- Modal Header -->
	     <div class="modal-header">
	        <h4 class="modal-title">검색 결과</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	     </div>
	        
	     <!-- Modal body -->
	     <div class="modal-body">
	     
	     </div>
	        
	     <!-- Modal footer -->
	     <div class="modal-footer">
	     	<button type="button" id="find_pw" class="btn btn-primary btn-sm" data-dismiss="modal">비밀번호 찾기</button>
	        <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">닫기</button>
	     </div>
	     
	     </div>
	   </div>
	</div>
	
	<div class="modal fade" id="modal_findPw">
	    <div class="modal-dialog">
	      <div class="modal-content">
	      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title"></h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	        
	        </div>
	        
		    <div class="form-group textbox">
			     <label for="passwd">비밀 번호</label>
			     <input type="password" class="form-control" id="passwd" name="passwd">
			</div>
			        
		    <div class="form-group textbox">
			     <label for="passwd_chk">비밀 번호 확인</label>
			     <input type="password" class="form-control" id="passwd_chk" name="passwd_chk">
			</div>
			
			<input type="hidden" id="result_emp_num">
			
	        <!-- Modal footer -->
	        <div class="modal-footer">
	           	
	           	<button type="button" class="btn btn-primary btn-sm" onclick="changePw()" data-dismiss="modal">비밀번호 변경</button>
				<button type="button" class="btn btn-primary btn-sm" onclick="location.href = '<%=context%>/loginForm'" data-dismiss="modal">로그인 창으로 돌아가기</button>
				
	        </div>
	        
	      </div>
	    </div>
	</div>
</div>
</body>
</html>