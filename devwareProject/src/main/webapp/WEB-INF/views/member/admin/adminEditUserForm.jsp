<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
		
		var id_check = false;
		
		//자동으로 도메인값을 넣어주는 함수 
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
		}
		
		//회원 가입 유효성 체크 
		function updateUpCheck()
		{	
			var check = true;
			var address = $('#postcode').val() + " " + $('#address').val() + " /" + $('#detailAddress').val();
			var email = $('#user_email1').val() + "@" +  $('#user_email2').val()
			
			alert(address);
			alert(email);
			
			$('#emp_address').attr('value', address);
			$('#emp_email').attr('value', email);
			
			if($('#emp_passwd').val() != $('#chk_emp_passwd').val())
			{
				alert('패스워드가 일치하지 않습니다. 다시 입력해주세요.');
				check = false;
			}
			
			if($('#emp_passwd').val().length < 8)
			{
				alert('패스워드는 보안상의 이유로 8글자 이상 입력해주세요');
				check = false;
			}
			
			if(check == false)
			{
				alert("체크 항목들을 확인해 주세요");
				return false;
			}
		}
		
		//주소 가져오기
		function DaumPostcode() {
			new daum.Postcode({
				oncomplete: function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수

					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}

					// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					if(data.userSelectedType === 'R'){
						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
							extraAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if(data.buildingName !== '' && data.apartment === 'Y'){
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if(extraAddr !== ''){
							extraAddr = ' (' + extraAddr + ')';
						}
						// 조합된 참고항목을 해당 필드에 넣는다.
						document.getElementById("extraAddress").value = extraAddr;

					} else {
						document.getElementById("extraAddress").value = '';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('postcode').value = data.zonecode;
					document.getElementById("address").value = addr;

					// 커서를 상세주소 필드로 이동한다.
					document.getElementById("detailAddress").focus();

					// 우편변호와 도로명주소에 'focus' class 추가
					document.getElementById("postcode").parentNode.classList.add('focus');
					document.getElementById("address").parentNode.classList.add('focus');
				}    
			}).open();
		}

		$(function()
		{	
			//이메일 값 나누기
			var email = '${userEmp.emp_email}';
			var user_email = email.split('@');
			var user_email1 = user_email[0];
			var user_email2 = user_email[1];
			
			$('#user_email1').attr('value', user_email1);
			$('#user_email2').attr('value', user_email2);
			
			//주소 값 불러온 후 나눠서 넣기
			var address1 = '${userEmp.emp_address}';
			var index1 = address1.indexOf(' ');
			var index2 = address1.indexOf('/');
			
			var postcode = address1.substr(0, index1);
			var address =  address1.substr(index1,index2-index1);
			var detailAddress = address1.substr(index2+1);
			
			$('#postcode').attr('value', postcode);
			$('#address').attr('value', address);
			$('#detailAddress').attr('value', detailAddress);
			
			if('${result}' == 1)
			{
				alert("회원 정보 변경에 성공했습니다.");
			}
			else if('${result}' == 2)
			{
				alert("회원 정보 변경에 실패했습니다.");
			}
			
		});	
</script>
<head>
<style type="text/css">
	.form-control {
		display: inline;
		width: 50%;
		height: calc(1.5em + .75rem + 2px);
		padding: .375rem .75rem;
		font-size: 1rem;
		font-weight: 400;
		line-height: 1.5;
		color: #6e707e;
		background-color: #fff;
		background-clip: padding-box;
		border: 1px solid #d1d3e2;
		border-radius: .35rem;
		-webkit-transition: border-color .15s ease-in-out, -webkit-box-shadow
			.15s ease-in-out;
		transition: border-color .15s ease-in-out, -webkit-box-shadow .15s
			ease-in-out;
		transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
		transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out,
			-webkit-box-shadow .15s ease-in-out
		}
		
	#postcode {
		width: 300px;
	}
	
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid">
		<h3>관리자 용 마이페이지</h3>
		<form action="/adminEditUserInfo" method="post">
			<table class="table table-hover text-center">
				<tr>
					<th><label for="emp_num">사번</label></th>
					<td><input type="text"   class="form-control" readonly tabindex="-1" id="emp_num" name="emp_num" value="${userEmp.emp_num}"></td>
				</tr>
				
				<tr>
					<th><label for="emp_name">이름</label></th>
					<td><input type="text"  class="form-control" id="emp_name" name="emp_name" value="${userEmp.emp_name}"></td>
				</tr>
				
				<tr>
					<th><label for="emp_name">아이디</label></th>
					<td><input type="text"   class="form-control" readonly tabindex="-1" id="emp_id" name="emp_id" value="${userEmp.emp_id}"></td>
				</tr>
				
				<tr>
					<th><label for="emp_passwd">비밀번호</label></th>
					<td><input type="password"  class="form-control" id="emp_passwd" name="emp_passwd" value="${userEmp.emp_passwd}"></td>
				</tr>
				
				<tr>
					<th><label for="chk_emp_passwd">비밀번호 재확인</label></th>
					<td><input type="password"  class="form-control" id="chk_emp_passwd" name="chk_emp_passwd" value="${userEmp.emp_passwd}"></td>
				</tr>
				
				<tr>
					<th>성별</th> 
					<td>
						<c:choose>
							<c:when test="${userEmp.emp_gender eq '남'}">
								<input type="radio" name="emp_gender" value="남" checked="checked">남성  
								<input type="radio" name="emp_gender" value="여" onclick="return false">여성  
							</c:when>
							<c:otherwise>
								<input type="radio" name="emp_gender" value="남" onclick="return false">남성  
								<input type="radio" name="emp_gender" value="여" checked="checked">여성
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				
				<tr>
					<th>권한 등급</th>
					<td>
						<select name="auth_num" id="auth_num">
							<c:forEach var="auth" items="${authlist}">
								<c:choose>
									<c:when test="${auth.auth_num eq userEmp.auth_num}">
										<option value="${auth.auth_num}" selected="selected">${auth.auth_name}</option>
									</c:when>
									<c:otherwise>
										<option value="${auth.auth_num}">${auth.auth_name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>직책</th>
					<td>
						<select name="position_num" id="position_num">
							<c:forEach var="pos" items="${poslist}">
								<c:choose>
									<c:when test="${pos.position_num eq userEmp.position_num}">
										<option value="${pos.position_num}" selected="selected">${pos.position_name}</option>
									</c:when>
									<c:otherwise>
										<option value="${pos.position_num}">${pos.position_name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>부서</th>
					<td>
						<select name="dept_num" id="dept_num">
							<c:forEach var="dept" items="${deptlist}">
								<c:choose>
									<c:when test="${dept.dept_num eq userEmp.dept_num}">
										<option value="${dept.dept_num}" selected="selected">${dept.dept_name}</option>
									</c:when>
									<c:otherwise>
										<option value="${dept.dept_num}">${dept.dept_name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>상태</th>
					<td>
						<select name="status_num" id="status_num">
							<c:forEach var="status" items="${statuslist}">
								<c:choose>
									<c:when test="${status.status_num eq userEmp.status_num}">
										<option value="${status.status_num}" selected="selected">${status.status_name}</option>
									</c:when>
									<c:otherwise>
										<option value="${status.status_num}">${status.status_name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<th><label for="user_email">이메일</label></th>
					<td><input type="text" class="form-control" name="user_email1" id="user_email1" required="required"> <br> 
					<input type="text" class="form-control" class="email" name="user_email2" id="user_email2" required="required">
					<select name="email" class="form-control" id="domain_list" onclick="changeDomain()">
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="gmail.com">gmail.com</option>
						<option value="type" selected="selected">직접 입력</option>
					</select></td>
				</tr>
				
				<tr>
					<th><label for="postcode">우편번호</label></th>
					<td><input type="text" class="form-group form-control" id="postcode" name="member_address1" readonly tabindex="-1">
					<input type="button" class="btn btn-primary" onclick="DaumPostcode()" value="우편번호 찾기"></td>
				</tr>
				
				<tr>
					<th><label for="address">주소</label></th>
					<td><input type="text" class="form-control" id="address" name="member_address2" readonly tabindex="-1"></td>
				</tr>
				
				<tr>
					<th><label for="detailAddress">상세주소</label></th>
					<td><input type="text"  class="form-control" id="detailAddress" name="member_address3">
					<input type="hidden" id="extraAddress" placeholder="참고항목"></td>
				</tr>
				
				<tr>	
					<td><input type="submit" onclick="updateUpCheck()" value="수정하기"></td>
				</tr>

			</table>
			<input type="hidden" id="emp_address" name ="emp_address"> 
			<input type="hidden" id="emp_email" name = "emp_email"> 
		</form>
	</div>
</body>
</html>
