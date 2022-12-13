<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
	<script type="text/javascript">
		function checkData()
		{
			var check = true;
			
			var v_emp_num = $('#emp_num').val();
			var v_emp_name = $('#emp_name').val();
			
			if(isNaN(v_emp_num)) 
			{ 
				alert("사번은 숫자를 입력해주세요"); 
				check = false;
			} 
			
			if(!isNaN(v_emp_name)) 
			{ 	
				alert("이름은 문자를 입력해주세요"); 
				check = false;
			}
			
			if(v_emp_num.length != 7)
			{
				alert("사번은 7자리로 [입사년도 + 부서 번호 + 카운트번호] 형식으로 입력해 주세요")	
				check = false;
			}
			
			if(check == false)
			{
				alert("입력값을 수정해서 다시 입력해주세요");
				return false;
			}
		}
		
		
		$(function()
		{		
			if('${result}' == 1)
			{
				alert("사원 리스트에 등록 성공했습니다.");
			}
			else if('${result}' == 2)
			{
				alert("사원 리스트에 등록 실패했습니다. 입력정보를 다시 확인해 주세요");
			}
		});	
	</script>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
		<h2>유저 등록하기</h2>
		<div class="container-fluid">
			<form action="/createUserList">
				<table class="table table-hover text-center">
					<tr>
						<th>사원 이름</th>
						<td><input type="text" id="emp_name" name="emp_name"></td>
					</tr>
					
					<tr>
						<th>사원 번호<br><sub>사번 형식: [입사년도[2]+ 부서 번호[2] + 카운트번호[3]]</sub></th>
						<td><input type="text" id="emp_num" name="emp_num"></td>
					</tr>
					
					<tr>
						<th>입사일</th>
						<td><input type="date" id="emp_hire_date" name="emp_hire_date"></td>
					</tr>
					
					<tr> 
						<th>부서</th>
						<td>	
							<select name="dept_num" id="dept_num">
								<c:forEach var="dept" items="${deptlist}">
									<option value="${dept.dept_num}">${dept.dept_name}</option>
								</c:forEach>
							</select>					
						</td>
					</tr>
					
					<tr>
						<th>직책</th>
						<td>
							<select name="position_num" id="position_num">
								<c:forEach var="pos" items="${poslist}">
									<option value="${pos.position_num}">${pos.position_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					
					<tr>
						<th>권한 등급</th>
						<td>
							<select name="auth_num" id="auth_num">
								<c:forEach var="auth" items="${authlist}">
									<option value="${auth.auth_num}">${auth.auth_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
			
					<tr>
						<th>상태</th>
						<td>
							<select name="status_num" id="status_num">
								<c:forEach var="status" items="${statuslist}">
									<option value="${status.status_num}">${status.status_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				
				<div style=" text-align: center;" class="form-group" id="sendBut">
					<button type="submit" class="btn btn-primary btn-lg" onclick="return checkData()">등록하기</button>
				</div>
				
			</form>
			
		</div>
</body>
</html>