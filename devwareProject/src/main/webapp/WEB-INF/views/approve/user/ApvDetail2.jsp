<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

.aa {
width:100px;
}
.tt{
height: 60px;
}

.body{
margin: 50px;
}

</style>

  <!-- 헤드 네비게이션 효과 -->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/board/boardWriteForm.css" rel="stylesheet">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>

</head>
<body  id="body" class="body">


<div class="container">


	<h1>일반결제</h1>

	<div class="text-right">
		<table border="1" style="display: inline-block">
		
		<tr>
		<td class="tt" rowspan='3'>결재</td>
		<td class="aa">
			<c:choose>
			
				<c:when test="${ apvDto.rank_name == null }">입사대기</c:when>
				<c:otherwise>${ apvDto.rank_name }</c:otherwise>
				
			</c:choose>
		</td>
		
		<td class="aa">
			<c:choose>
			
				<c:when test="${ apvDto.rank_name1 == null }"><c:if test="${ not empty apvDto.member_name1 }">입사대기</c:if></c:when>
				<c:otherwise>${ apvDto.rank_name1 }</c:otherwise>
				
			</c:choose>
		</td>
		<td class="aa">
			<c:choose>
			
				<c:when test="${ apvDto.rank_name2 == null }"><c:if test="${ not empty apvDto.member_name2 }">입사대기</c:if></c:when>
				<c:otherwise>${ apvDto.rank_name2 }</c:otherwise>
				
			</c:choose>
		</td>
				<td class="aa">
			<c:choose>
			
				<c:when test="${ apvDto.rank_name3 == null }"><c:if test="${ not empty apvDto.member_name3 }">입사대기</c:if></c:when>
				<c:otherwise>${ apvDto.rank_name3 }</c:otherwise>
				
			</c:choose>
		</td>
		</tr>
		
		
		
		<tr>
		
		<td>${ apvDto.member_name }</td>
		<td id="authName1">${ apvDto.member_name1 }</td>
		<td id="authName2">${ apvDto.member_name2 }</td>
		<td id="authName3">${ apvDto.member_name3 }</td>
		
		</tr>
		
				<tr>
		
		<td>제출</td>
		<td id="authName1">${ apvDto.apv_auth_name1 }</td>
		<td id="authName2">${ apvDto.apv_auth_name2 }</td>
		<td id="authName3">${ apvDto.apv_auth_name3 }</td>
		
		</tr>
		
		</table>
	</div>
	
	
	<div>
	<table border="1">
	
	<tr>
	<th>문서상태</th>
	
			<c:choose>
				<c:when test="${ empty apvDto.apv_auth_name3 }">
					<c:choose>
						<c:when test="${ empty apvDto.apv_auth_name2 }">
							<td>${ apvDto.apv_auth_name1 }</td>
						</c:when>
						<c:when test="${ apvDto.approval_auth1 == 2 }">
							<td>${ apvDto.apv_auth_name1 }</td>
						</c:when>
						<c:otherwise>
							<td>${ apvDto.apv_auth_name2 }</td>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:when test="${ apvDto.approval_auth2 == 2 }">
					<td>${ apvDto.apv_auth_name2 }</td>
				</c:when>
				<c:otherwise>
					<td>${ apvDto.apv_auth_name3 }</td>
				</c:otherwise>
			</c:choose>
	
	<th>문서번호</th>
	<td>${ apvDto.approval_cate }_${ apvDto.approval_id }</td>
	</tr>
	
	<tr>
	<th>기안일자</th>
	<td colspan="3"><fmt:formatDate value="${ apvDto.approval_indate }"  pattern="yyyy-MM-dd HH:mm:ss"/></td>
	</tr>
	
	<tr>
	<th>결재구분</th>
	<td colspan="3">${ apvDto.apv_cate_name }</td>
	</tr>
	
	<tr>
	<th>기안부서</th>
	<td colspan="3">
		<c:choose>
			
			<c:when test="${ apvDto.department_name == null }">발령대기</c:when>
			<c:otherwise>${ apvDto.department_name }</c:otherwise>
				
		</c:choose>
	</td>
	</tr>
	
	<tr>
	<th>기안담당</th>
	<td colspan="3">${ apvDto.member_name }&nbsp;&nbsp;${ apvDto.rank_name }</td>
	</tr>
	
	<tr>
	<th>제목</th>
	<td colspan="3">${ apvDto.approval_title }</td>
	</tr>
	
	<tr>
	<td colspan="4">${ apvDto.approval_content }</td>
	</tr>
	
	</table>
	</div>
	<div>
	
	<!-- 파일 다운로드 -->
	<a href="${pageContext.request.contextPath }/approval/down?path=${ apvDto.approval_filepath }">${ apvDto.approval_filename }</a>
	
	</div>
	
	<div class="text-right">
		<p style="font-weight: bold;">(주)그룹웨어</p>
	</div>

	<table border="1" >
	
	<tr>
	<th rowspan="3">결재기록</th>
	<td style="height: 30px;"><c:if test="${ not empty apvDto.approval_auth_date1 }">[<fmt:formatDate value="${ apvDto.approval_auth_date1 }"  pattern="yyyy-MM-dd HH:mm:ss"/>]&nbsp;&nbsp;${ apvDto.department_name1 }&nbsp;${ apvDto.member_name1 }&nbsp;${ apvDto.rank_name1 }&nbsp;<Strong>${ apvDto.apv_auth_name1 }</Strong></c:if></td>
	</tr>
	<tr>
	<td style="height: 30px;"><c:if test="${ not empty apvDto.approval_auth_date2 }">[<fmt:formatDate value="${ apvDto.approval_auth_date2 }"  pattern="yyyy-MM-dd HH:mm:ss"/>]&nbsp;&nbsp;${ apvDto.department_name2 }&nbsp;${ apvDto.member_name2 }&nbsp;${ apvDto.rank_name2 }&nbsp;<Strong>${ apvDto.apv_auth_name2 }</Strong></c:if></td>
	</tr>
	<tr>
	<td style="height: 30px;"><c:if test="${ not empty apvDto.approval_auth_date3 }">[<fmt:formatDate value="${ apvDto.approval_auth_date3 }"  pattern="yyyy-MM-dd HH:mm:ss"/>]&nbsp;&nbsp;${ apvDto.department_name3 }&nbsp;${ apvDto.member_name3 }&nbsp;${ apvDto.rank_name3 }&nbsp;<Strong>${ apvDto.apv_auth_name3 }</Strong></c:if></td>
	</tr>
	
	<c:if test="${ not empty apvDto.approval_return }">
	<th>반려사유</th>
	<td>${ apvDto.approval_return }</td>
	</c:if>

	<c:if test="${ not empty apvDto.approval_cc }">
	<th>임시저장 태그</th>
	<td>${ apvDto.approval_cc }</td>
	</c:if>

	</table>
	
</div>
	

</body>
</html>