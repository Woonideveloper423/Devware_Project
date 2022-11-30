<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/basic.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">

function loginCheck()
{
	var v_emp_id = $('#emp_id').val();
	var v_emp_passwd = $('#emp_passwd').val();
	
	if(v_emp_id == "")
	{
		alert("아이디를 입력해주세요 ");
	}
	
	if(v_emp_passwd == "")
	{
		alert("비밀번호를 입력해주세요 ");
	}
	
	$.ajax({
		url : "<%=context%>/login",
		type : 'post',
		data : { 
			emp_id : v_emp_id, 
			emp_passwd : v_emp_passwd
		},
	
		success:function(data)
		{
			if(data.result == 1)
			{
				console.log(JSON.stringify(data));
				alert(data.msg);
				location.href='<%=context%>/auth_finder';
			}
			else
			{
				alert(data.msg);
				alert("아이디 혹은 비밀번호를 다시 확인해주세요");
			}
		}
		
	});
}


$(function(){
	//	페이지 로딩 완료 후 focus 이동 - 처음에 label zoom 효과 안되는 오류 수정(임시방편)
	$(document).ready(function(){
		$("input[type='text']:first, input[type='password']:first").focus();
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

	//	회원가입 중에 오류가 날 때 zoom 관련 css 초기화 되어 다시 설정
	$('input[type=text], input[type=password], select').each(function () {
		if ($(this).val() !== '') { // input 태그가 value값을 가지면 'focus' class 추가
			// label focus
			$(this).closest('.textbox').addClass('focus');
		} else { // input 태그에  value값이 없으면 'focus' class 삭제
			$(this).closest('.textbox').removeClass('focus');
		}
	});
});
</script>

</head>
<body>
<div class="container">
    <div class="row justify-content-center">
    	<div class="col-xl-5 col-lg-12 col-md-9" style="height:100% !important">

	        <div class="card o-hidden border-0 shadow-lg my-5">
	          	<div class="card-body p-0">
	          		<div class="p-5">
	                	<div class="text-center">
	                    	<h1 class="h4 text-gray-900 mb-4">Welcome To DevWare</h1>
	                  	</div>
				                
						<form id="form_login" action="/login" method="post">			
							
							<!-- 아이디 -->
							<div class="form-group textbox">
								<label for="emp_id">아이디를 입력하세요</label>
								<input type="text" class="form-control" id="emp_id" name="emp_id" value="gunhee1234" maxlength="15" required="required">
							</div>
								
							<!-- 비밀번호 -->
							<div class="form-group textbox">
								<label for="emp_passwd">비밀번호를 입력하세요</label>
								<input type="password" class="form-control" id="emp_passwd" name="emp_passwd" value="12341234" maxlength="16" style="ime-mode: disabled;" required="required" >
							</div>
							
							<!-- 로그인 버튼 -->
							<div class="form-group textbox">
								<input type="button" class="btn btn-primary btn-user btn-block" id="btn_login" onclick="loginCheck()" value="로그인">
							</div>
							
						</form>
				     		              
				
				        <hr>
				        <a href="/findIdPwForm" class="btn btn-google btn-user btn-block">아이디 / 비밀번호 찾기</a>				                  
				        <a href="/signUpForm" class="btn btn-facebook btn-user btn-block">회원 가입</a>
				        <hr>
	         		</div>
	       		</div>
	     	</div>
		</div>
    </div>
</div>
</body>
</html>
