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
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	function userlistDeptSearch()
	{
		var deptnum = $('#deptnum').val();
		location.href='<%=context%>/userlistDeptSearch?deptnum='+ deptnum;
	}
	
	function mailCreateDone(emp_num){
		$.ajax(
				{
					url:"/mail/mailCreateDone",
					data:{"emp_num" : emp_num},
					dataType:'text',
					success:function(data){
						if(data == 'success'){
							alert("처리완료");
							$('#mailPermit' + emp_num).html("생성완료")
						}else{
							alert("처리실패")
						}
					}
				}		
		);
	}
</script>
</head>
<body>
	<c:set var="num" value="${page.total-page.start+1 }"></c:set>
	<div class="container-fluid">
		<h3>사원 목록</h3>
		<div>
			부서별 조회:
			<select name="deptnum" id="deptnum">
				<option value="0">전체</option>
				<c:forEach var="dept" items="${deptlist}">
					<option value="${dept.dept_num}">${dept.dept_name}</option>
				</c:forEach>
			</select>
			<button onclick="userlistDeptSearch()">조회하기</button>
		</div>
		<table class="table table-hover text-center">
			<tr><th>사원명</th><th>사원 번호</th><th>사원 아이디</th><th>부서명</th><th>직급</th><th>사용자 등급</th><th>재직 여부</th><th>정보 수정</th><th>사내 메일</th></tr>
			<c:forEach var="emp" items="${emplist}">
				<tr>
					<td>${emp.emp_name}</td>
					<td>${emp.emp_num}</td>
					<td>${emp.emp_id}</td>
					<td>${emp.dept_name}</td>
					<td>${emp.position_name}</td>
					<td>${emp.auth_name}</td>
					<td>${emp.status_name}</td>
					<td><button type="button" class="btn btn-primary" onclick="location.href = '/adminGetUserInfo?emp_num=${emp.emp_num}'">정보 수정</button></td>
					<td id="mailPermit${emp.emp_num}">
						<c:if test="${empty emp.permit_status}">요청 없음</c:if>
						<c:if test="${emp.permit_status eq 0}"><button type="button" class="btn btn-primary" onclick="mailCreateDone(${emp.emp_num})">사내 메일 생성</button></c:if>
						<c:if test="${emp.permit_status eq 1}">생성 완료</c:if>
					</td>
				</tr>
				<c:set var="num" value="${num - 1 }"></c:set>
	
			</c:forEach>
		</table>
		
		<c:choose>
			<c:when test="${deptnum eq 0}">
				<c:if test="${page.startPage > page.pageBlock }">
					<a href="userlist?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
				</c:if>
				<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
					<a href="userlist?currentPage=${i}">[${i}]</a>
				</c:forEach>
				<c:if test="${page.endPage < page.totalPage }">
					<a href="userlist?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
				</c:if>	
			</c:when>
			
			<c:otherwise>
				<c:if test="${page.startPage > page.pageBlock }">
					<a href="userlistDeptSearch?currentPage=${page.startPage-page.pageBlock}&&deptnum=${deptnum}">[이전]</a>
				</c:if>
				<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
					<a href="userlistDeptSearch?currentPage=${i}&&deptnum=${deptnum}">[${i}]</a>
				</c:forEach>
				<c:if test="${page.endPage < page.totalPage }">
					<a href="userlistDeptSearch?currentPage=${page.startPage+page.pageBlock}&&deptnum=${deptnum}">[다음]</a>
				</c:if>	
			</c:otherwise>
		</c:choose>
	
	</div>
</body>
</html>