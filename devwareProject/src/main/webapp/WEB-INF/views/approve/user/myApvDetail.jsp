<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
                       <!-- 일반결재 디테일입니다 -->
<style>
.aa {
	width: 100px;
}

.tt {
	height: 60px;
}


</style>
  <!-- 헤드 네비게이션 효과 -->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/board/boardWriteForm.css" rel="stylesheet">
 
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script> -->

    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  
</head>

<script type="text/javascript">

function authChkBtn(prg_auth){
	const ChkCtn = document.getElementById('chkBtn');
	const ChkInput = document.getElementById('chkInput');
	  var sendData = "";
	  if ( prg_auth == 1 ) {
		  sendData = "1";  
	  } else if  ( prg_auth == 2 ) {
		  sendData = "2";  
	  } else if  ( prg_auth == 3 ) {
		  sendData = "3";  
	  }
	  
	  confirm("결재 하시겠습니까?");
	    $.ajax({
				url  : "<%=context%>/authApprove",
				type : 'post',
				data : 	{
							"sendData" 	: sendData,
							"chkBtn"	: $('#chkBtn').val(),
							"app_num" 	: ${allApv.app_num},
						},
			    success:function(data){
			    	if(ChkCtn.style.display !== 'none') {
			    		ChkCtn.style.display = 'none';
			    		if(ChkInput.style.display == 'none'){
			    			ChkInput.style.display = 'block';
			    		}
			    		
			    		
			  	  }
		} ,
	
	  }); 
	  
		  
	
	
}

</script>
<body id="body">


<div class="container">
	<div class="container-fluid text-center">

		<!-- 게시글 -->
 	<div class="col-lg-12">
 			
              <div class="card" >
                <div class="card-header py-3">
                  <h4><strong>[${ allApv.emp_name }]</strong><strong class="m-0 font-weight-bold text-primary"> ${ allApv.app_title }</strong></h4> 
                  <div align="right"><strong>작성일</strong> <fmt:formatDate	value="${ allApv.app_date }" pattern="yyyy-MM-dd HH:mm:ss" /></div>
                </div>
                
                
                
                <div class="card-body text-center">
                 
                 <!-- 결제칸 -->
                 
                  <div class="text-right">
			<table border="1" style="display: inline-block">

				<tr>
					<td class="tt" rowspan='4'>결재</td>
					<td class="aa">${allApv.position_name }</td>
					
					<td class="aa">${allApv.position_name1 }</td>
					<td class="aa">${allApv.position_name2 }</td>
					<td class="aa">${allApv.position_name3 }</td>
				</tr>



				<tr>

					<td>${ allApv.emp_name }</td>
					<td id="authName1">${ allApv.prg_name1 }</td>
					<td id="authName2">${ allApv.prg_name2 }</td>
					<td id="authName3">${ allApv.prg_name3 }</td>

				</tr>

				<tr>

					<td>${ allApv.emp_num }</td>
					<td id="authName1">${ allApv.prg_num1 }</td>
					<td id="authName2">${ allApv.prg_num2 }</td>
					<td id="authName3">${ allApv.prg_num3 }</td>

				</tr>
				<tr>

					<td>제출</td>
					<td id="authCheck1">
						<c:choose>
							<c:when test="${ allApv.prg_num1==sessionScope.empForSearch.emp_num }">
								<c:if test="${ allApv.prg_num1 !=null }">
									<c:choose>
										<c:when test="${allApv.prg_auth1 == '0' }">
											<button id="chkBtn" class="btn btn-outline-primary" type="button" onclick="authChkBtn(1)" value="1">결재</button>
										<input id="chkInput" class="aa" style="display:none; border:none; text-align:right;" value="결재완료">
										</c:when>
										<c:when test="${allApv.prg_auth1 == '1' }">
											결재완료
										</c:when>
									</c:choose>
								</c:if>
							</c:when>
							<c:when test="${allApv.prg_auth1 == '1' }">
								결재완료
							</c:when>
							<c:when  test="${allApv.prg_auth1 == '0' and allApv.prg_num1 != null}">
								미결재
							</c:when>
							<c:otherwise>
								
							</c:otherwise>
						</c:choose>				
					</td>
					<td id="authCheck2">
						<c:choose>
							<c:when test="${ allApv.prg_num2==sessionScope.empForSearch.emp_num }">
								<c:if test="${ allApv.prg_num2 !=null }">
									<c:choose>
										<c:when test="${allApv.prg_auth2 == '0' }">
											<button id="chkBtn" class="btn btn-outline-primary" type="button" onclick="authChkBtn(2)" value="1">결재</button>
											<input id="chkInput" class="aa" style="display:none; border:none; text-align:right;" value="결재완료">
										</c:when>
										<c:when test="${allApv.prg_auth2 == '1' }">
												결재완료
										</c:when>
									</c:choose>
								</c:if>
							</c:when>
							<c:when test="${allApv.prg_auth2 == '1' }">
									결재완료
							</c:when>
							<c:when  test="${allApv.prg_auth2 == '0' and allApv.prg_num2 != null}">
								미결재
							</c:when>
							<c:otherwise>
								
							</c:otherwise>
						</c:choose>	
					</td>
					<td id="authCheck3">
						<c:choose>
							<c:when test="${ allApv.prg_num3==sessionScope.empForSearch.emp_num }">
								<c:if test="${ allApv.prg_num3 !=null }">
									<c:choose>
										<c:when test="${allApv.prg_auth3 == '0' }">
											<button id="chkBtn" class="btn btn-outline-primary" type="button" onclick="authChkBtn(3)" value="1">결재</button>
											<input id="chkInput" class="aa" style="display:none; border:none; text-align:right;" value="결재완료">
										</c:when>
										<c:when test="${allApv.prg_auth3 == '1' }">
												결재완료
										</c:when>
									</c:choose>
								</c:if>
							</c:when>
							<c:when test="${allApv.prg_auth3 == '1' }">
									결재완료
							</c:when>
							<c:when  test="${allApv.prg_auth3 == '0' and allApv.prg_num3 != null}">
								미결재
							</c:when>
							<c:otherwise>
								
							</c:otherwise>
						</c:choose>	
					</td>

				</tr>

			</table>
		</div>
		<!-- 결제칸 끝 -->
                  
                  
                  
                  
                  <hr>
                  <div style="height:450px; overflow:auto;">
                  
                  <c:choose>
					<c:when test="${ allApv.comu_app != ''}">
						근태
						<table class="table table-hover" border="1">
							<tr>
								<th width="20%">문서상태</th>
								<td>${ allApv.app_prg }</td>
			
								<th>문서번호</th>
								<td>${ allApv.emp_num }_${ allApv.app_num }</td>
							</tr>
			
							<tr>
								<th>제출일자</th>
								<td colspan="3"><fmt:formatDate	value="${ allApv.app_date }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							</tr>
			
							<tr>
								<th>결재구분</th>
								<td colspan="3">${ allApv.prg_status }</td>
							</tr>
			
							<tr>
								<th>요청기간</th>
								<c:choose>
								
									<c:when test="${ fn:contains(apvDto.approval_cc, '1_wholeVacat') }">
									<td colspan="3">[연차]&nbsp;<fmt:formatDate value="${ apvDto.approval_startdate }"  pattern="yyyy-MM-dd"/>&nbsp;~&nbsp;<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/></td>
									</c:when>
									<c:when test="${ fn:contains(apvDto.approval_cc, '2_halfVacat_AM') }">
									<td colspan="3">[반차 AM] &nbsp;<fmt:formatDate value="${ apvDto.approval_startdate }"  pattern="yyyy-MM-dd"/> 09:00&nbsp;~&nbsp;<fmt:formatDate value="${ apvDto.approval_enddate }"  pattern="yyyy-MM-dd"/> 13:00</td>
									</c:when>
									<c:when test="${ fn:contains(apvDto.approval_cc, '2_halfVacat_PM') }">
									<td colspan="3">[반차 PM]&nbsp;<fmt:formatDate value="${ apvDto.approval_startdate }"  pattern="yyyy-MM-dd"/> 14:00&nbsp;~&nbsp;<fmt:formatDate value="${ apvDto.approval_enddate }"  pattern="yyyy-MM-dd"/> 18:00</td>
									</c:when>
								
								</c:choose>
							</tr>
			
							<tr>
								<th>제출자</th>
								<td colspan="3">${ allApv.emp_name }&nbsp;&nbsp;${ allApv.position_name }</td>
							</tr>
			
							<tr>
								<th>제목</th>
								<td colspan="3">${ allApv.app_title }</td>
							</tr>
			
							<tr>
								<td colspan="4" height=100px>${ allApv.app_content }</td>
							</tr>
						</table>
					</c:when>
					
					<c:when test="${ allApv.docs_app != ''}">
						문서
						<table class="table table-hover" border="1">
							<tr>
								<th width="20%">문서상태</th>
								<td>${ allApv.app_prg }</td>
			
								<th>문서번호</th>
								<td>${ allApv.emp_num }_${ allApv.app_num }</td>
							</tr>
			
							<tr>
								<th>기안일자</th>
								<td colspan="3"><fmt:formatDate	value="${ allApv.app_date }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							</tr>
			
							<tr>
								<th>결재구분</th>
								<td colspan="3">${ allApv.prg_status }</td>
							</tr>
			
							<tr>
								<th>기안부서</th>
								<td colspan="3">${ allApv.dept_name }</td>
							</tr>
			
							<tr>
								<th>기안담당</th>
								<td colspan="3">${ allApv.emp_name }&nbsp;&nbsp;${ allApv.position_name }</td>
							</tr>
			
							<tr>
								<th>제목</th>
								<td colspan="3">${ allApv.app_title }</td>
							</tr>
			
							<tr>
								<td colspan="4" height=100px>${ allApv.app_content }</td>
							</tr>
						</table>
					</c:when>
                  
                  
             
				</c:choose>
			<hr>
			<!-- 결재기록 --> 
			<table class="table table" border="1">

			<c:if test="${ not empty allApv.prg_return }">
				<th>반려사유</th>
				<td>${ allApv.prg_return }</td>
			</c:if>

		</table>
		
			<div>
			<p align="right" style="font-weight: bold;">(주)DevWare</p>
		</div>
		
			</div> 
			<!-- 텍스트바 -->
              <hr>
                  <%-- <div><strong>[첨부파일]</strong>   <a href="${pageContext.request.contextPath }/approval/down?path=${ allApv.approval_filepath }">${ allApv.approval_filename }</a></div> --%><br>
				<div class="container">
					
				<div class="float-left">
		<button class="btn btn-outline-primary"  onclick="history.back()">뒤로</button>
		<input class="btn btn-outline-primary"  type="button" value="인쇄" onclick="window.print()" />

	</div>

	<c:if test="${ allApv.emp_num == sessionScope.empForSearch.emp_num}">
		<c:choose>
			<c:when test="${ allApv.prg_return == null}">
				<c:if test="${ allApv.docs_app != ''}">
						<button class="btn btn-outline-primary"  onclick="location.href='/reWrite?app_num=${allApv.app_num}'">재수정</button>
				</c:if>
				
				<c:if test="${ allApv.comu_app != ''}">
					<button class="btn btn-outline-primary" onclick="delBtn()">근태취소</button>
				</c:if>
			</c:when>
			<c:when test="${ allApv.prg_return != null}">
				<button class="btn btn-outline-primary" onclick="delRtnBtn()">삭제</button>
			</c:when>
		</c:choose>
	</c:if>
	<c:if test="${ allApv.prg_num1 == sessionScope.empForSearch.emp_num}">
		<c:if test="${ allApv.prg_return == null}">
			<button class="btn btn-outline-primary"  type="button" id="modal_opne_btn">반려</button>
		</c:if>
	</c:if>
	<c:if test="${ allApv.prg_num2 == sessionScope.empForSearch.emp_num}">
		<c:if test="${ allApv.prg_return == null}">
			<button class="btn btn-outline-primary"  type="button" id="modal_opne_btn">반려</button>
		</c:if>
	</c:if>
	<c:if test="${ allApv.prg_num3 == sessionScope.empForSearch.emp_num}">
		<c:if test="${ allApv.prg_return == null}">
			<button class="btn btn-outline-primary"  type="button" id="modal_opne_btn">반려</button>
		</c:if>
	</c:if>
	
	<!-- 반려 사유 -->
	<div class="modal" id="returning">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">반려</h4>
					<button class="btn btn-outline-primary"  type="button" class="close float-right"
						data-dismiss="modal" id="modal_close_btn">&times;</button>
				</div>

				<div class="form-group">
					<div class="modal-body">
						<h5>
							<label>반려 사유를 입력해주세요.</label>
						</h5>
						<form onsubmit="return returnChkBtn()"  method="POST" action="<%=context%>/returnApprove">
							<input type="hidden" id="app_num" name="app_num" value="${allApv.app_num }">		
							<input class="form-control" name="apv_return" type="text" id="apv_return" />
							
						
					</div>
					<div class="modal-footer">
						<button class="btn btn-outline-primary"  type="submit">제출</button>
					</div>
						</form>
				</div>
                </div>
              </div>
			
            </div>
          </div>
				</div>
			</div>
	</div>
</div>
                  
                  
                  
            
 </div>   

</body>

<script type="text/javascript">
function returnChkBtn(){
	if(($('#apv_return').val()).trim() == ''){
		alert('내용을 입력해주세요')
		return false;
	}
	var chkConfirm = confirm('반려 이후 결재 작성자 이외에 확인 할수 없습니다.\n반려 하시겠습니까?');
	   if (chkConfirm) {
		   
	   }
	   else {
		   return false;
	   }
}

function delBtn(){
	var chkConfirm = confirm('근태 문서를 삭제 하시겠습니까?');
	   if (chkConfirm) {
		   location.href="<%=context%>/delApv?app_num=${allApv.app_num}";
	   }
	   else {
		   return false;
	   }
}

function delRtnBtn(){
	var chkConfirm = confirm('반려된 문서를 삭제 하시겠습니까?');
	   if (chkConfirm) {
		   location.href="<%=context%>/delApv?app_num=${allApv.app_num}";
	   }
	   else {
		   return false;
	   }
}

	document.getElementById("modal_opne_btn").onclick = function() {
	    document.getElementById("returning").style.display="block";
	}
	
	document.getElementById("modal_close_btn").onclick = function() {
	    document.getElementById("returning").style.display="none";
	}   

</script>
</html>