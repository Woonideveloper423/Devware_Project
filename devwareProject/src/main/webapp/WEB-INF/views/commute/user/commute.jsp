<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.board{
	padding: 15px;
	margin: 3px;
	border: 1px solid lightgray;
	background-color: #fdfdfd;
}
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

  
<script type="text/javascript">

function startTime(){
	var Now = new Date(); // 현재 날짜 및 시간
	var nowyear = Now.getFullYear(); //년
	var nowMonth = Now.getMonth() + 1; // 월
	var nowDay = Now.getDate(); // 일
	var nowHour = Now.getHours(); // 시
	var nowMins = Now.getMinutes(); // 분
	var nowSecs = Now.getSeconds(); // 초
	
	//일자리 시간에 앞자리 0 추가
	if(nowMonth < 10) {
		nowMonth = "0"+nowMonth;
	}
	if(nowDay < 10) {
		nowDay = "0"+nowDay;
	}
	if(nowHour < 10) {
		nowHour = "0"+nowHour;
	}
	if(nowMins < 10) {
		nowMins = "0"+nowMins;
	}
	if(nowSecs < 10) {
		nowSecs = "0"+nowSecs;
	}
		
	//데베 컬럼
	var emp_num = ${sessionScope.empForSearch.emp_num};//
	var com_date = new Date();
	var com_start = nowyear +""+ nowMonth +""+ nowDay +""+ nowHour +""+ nowMins + "" +nowSecs +"";
	var com_end = null;
	var com_num = nowyear +""+ nowMonth +""+ nowDay
	
	
	var msg = nowyear +"년"+ nowMonth +"월"+ nowDay +"일"+ nowHour +"시"+ nowMins + "분" +nowSecs +"초";
	
	
	alert(msg + "에 출근 기록되었습니다");
	$.ajax({
		url : "<%=context%>/startTime",
		type : 'post',
		data : { 	
					com_start,
					com_end,
					msg,
					emp_num,
					com_date,
					com_num,
					
				},
		dataType : 'json',
		success:function(data){
			location.replace("<%=context%>/user/commute");
 			
		}
	}); 

	
}

function endTime(){
	var Now = new Date(); // 현재 날짜 및 시간
	var nowyear = Now.getFullYear(); //년
	var nowMonth = Now.getMonth() + 1; // 월
	var nowDay = Now.getDate(); // 일
	var nowHour = Now.getHours(); // 시
	var nowMins = Now.getMinutes(); // 분
	var nowSecs = Now.getSeconds(); // 초
	
	//일자리 시간에 앞자리 0 추가
	if(nowMonth < 10) {
		nowMonth = "0"+nowMonth;
	}
	if(nowDay < 10) {
		nowDay = "0"+nowDay;
	}
	if(nowHour < 10) {
		nowHour = "0"+nowHour;
	}
	if(nowMins < 10) {
		nowMins = "0"+nowMins;
	}
	if(nowSecs < 10) {
		nowSecs = "0"+nowSecs;
	}
		
	//데베 컬럼
	var emp_num = 1;
	var com_date = new Date();
	var com_end = nowyear +""+ nowMonth +""+ nowDay +""+ nowHour +""+ nowMins + "" +nowSecs +"";
	var com_num = nowyear +""+ nowMonth +""+ nowDay
	var com_start = null;
	
	
	var msg = nowyear +"년"+ nowMonth +"월"+ nowDay +"일"+ nowHour +"시"+ nowMins + "분" +nowSecs +"초";
	console.log("테스트"+com_num);
	
	$.ajax({
		url : "<%=context%>/findTime",
		type : 'post',
		data : { 	
					emp_num,
					"com_end" : com_end,
					"com_num" : com_num
				},
		dataType : 'json',
 		success:function(commute){
 			var com_end2 = data;
			var endstr = data.substring(0,4) + '년 ' + data.substring(4,6) + '월 ' + data.substring(6,8) + '일 ' + data.substring(8,10) + '시 '+ data.substring(10,12)+ '분 ' + data.substring(12,14) + '초';
			console.log("값전달 ->"+endstr);
			$("#com_end"+com_num).empty();
 			$("#com_end"+com_num).html(endstr);
 			
 			com_start=$("#com_start"+com_num).attr('name');
 
 			
  			$("#com_gap").html(commute.com_workTime);
 			
		} 
	}); 
}

setInterval('time()', 1000);
function time() {
	<%-- console.log("current_time jsp start");
	$.ajax({
		type:"POST",
		url:"<%=context%>/current_time",
		success:function(data){
			var obj = eval('('+data+')');			
			$("#current_time").html(obj.value);				
		}
	}); --%>
	var currentDate = new Date();
    var divClock = document.getElementById("current_time");
     

	var divDate = document.getElementById("current_date");
	var dateMsg = currentDate.getFullYear() + "년 "
	dateMsg += currentDate.getMonth() + 1 + "월";
	dateMsg += currentDate.getDay() + 1 + "일";
	
    var msg = currentDate.getHours()+"시"
    msg += currentDate.getMinutes()+"분";
    msg += currentDate.getSeconds()+"초";
     
    divDate.innerText = dateMsg;
    divClock.innerText = msg;
    setTimeout(time,1000);
}
	
</script>
</head>
<body>
<div class="container">
	<div class="container-fluid text-center">

		<!-- 게시글 -->
 	<div class="col-lg-12">
 		
              <div class="card" >
                <div class="card-header py-3">
                
                  <h4 class="m-0 font-weight-bold text-primary"><strong>근태관리</strong></h4><div align="right">	
				<div>
				   <form id="selectDayForm" action="<%=context%>/commuting"></form>          	
				
						<div class="clearfix">
	<div class="float-left">
		<h2><strong><span id="current_date"></span></strong> <strong><span id="current_time"></span></strong></h2>
	</div>	
	 <div class="float-right">
					<input type="hidden" id="commuting_member_id" value="${sessionScope.empForSearch.emp_num}"/>
					<input style="width: 150pt;" type="button" id="startTime" onclick="startTime(); return false;" class="btn btn-outline-success" value="출근"></input>
					<input style="width: 150pt;" type="button" id="endTime" onclick="endTime(); return false;" class="btn btn-outline-success" value="퇴근"></input>
					</div>
					
					</div>
				</div>
			
				</div>
                </div>
                
                <div class="card-body text-center">
                
                  <div class="clearfix">
                  <div class="float-right">
                  
		<%-- <input class="btn btn-outline-primary" type="text" id="halfPick" name="halfPick" onchange="datePick()" value="${ dPick }">
		<button class="btn btn-outline-primary" onclick="previousYear()">이전해</button>
		<button class="btn btn-outline-primary" onclick="previousMonth()">이전달</button>
		<button class="btn btn-outline-primary" onclick="today()">오늘</button>
		<button class="btn btn-outline-primary" onclick="nextMonth()">다음달</button>
		<button class="btn btn-outline-primary" onclick="nextYear()">다음해</button> --%>
	</div></div>
                  <hr>
                   <div style="height:650px; overflow:auto; overflow-x:hidden; overflow-y:auto;" align=left>
                  
                  
	<div class="row board text-center" style="background-color: #dddddd;" >
		<div class="col-sm"><strong>날짜</strong></div>
		<div class="col-sm"><strong>출근시간</strong></div>
		<div class="col-sm"><strong>퇴근시간</strong></div>
		<div class="col-sm"><strong>지각시간</strong></div>
		<div class="col-sm"><strong>근무시간</strong></div>
		<div class="col-sm"><strong>상태</strong></div>
		<div class="col-sm"><strong>근태사유</strong></div>
		<div style="width:8%"><strong></strong></div>
	</div>
	<%-- <c:if test="${commute.com_num.substring(6,8) == status.count }">${commute.com_start }</c:if> --%>
	<c:forEach items="${listCommute}" var="commute">
			<div class="row board text-center">	
				<div class="col-sm">${commute.com_num }</div>	
				<c:if test="${commute.com_start != null }">
	 				<div class="col-sm" id="com_start${commute.com_num }" name="${commute.com_start }">${commute.com_start.substring(8,10) }시 ${commute.com_start.substring(10,12) }분</div>
				</c:if>
				<c:if test="${commute.com_start == null }">
					<div class="col-sm" id="com_start${commute.com_num }"></div>	
				</c:if>
				<c:if test="${commute.com_end != null }">
					<div class="col-sm" id="com_end${commute.com_num }" name="${commute.com_end }">${commute.com_end.substring(8,10) }시 ${commute.com_end.substring(10,12) }분 </div>
				</c:if>
				<c:if test="${commute.com_end == null }">
					<div class="col-sm" id="com_end${commute.com_num }"></div>	
				</c:if>
										
				<div class="col-sm">${commute.com_lateTime }</div>
				<div class="col-sm">${commute.com_workTime }</div>
				<div class="col-sm" id="reason_${status.count}"></div>
				<div style="width:8%" id="reasonBtn_${status.count}">근태사유</div>
			</div>
	</c:forEach>						
</div>
                  
                  <hr>
                 
                
			
                </div>
              </div>
			
            </div>
            </div></div>
	
<%-- 	<c:forEach var="commute" items="${listCommute}">
		<tr><td>${commute.com_num }</td>
			<td id="com_start${commute.com_num }" name="${commute.com_start }">${commute.com_start.substring(0,4) }년 ${commute.com_start.substring(4,6) }월 ${commute.com_start.substring(6,8) }일 ${commute.com_start.substring(8,10) }시 ${commute.com_start.substring(10,12) }분  ${commute.com_start.substring(12,14) }초</td>
			<c:if test="${commute.com_end != null }">
				<td id="com_end${commute.com_num }" name="${commute.com_end }">${commute.com_end.substring(0,4) }년 ${commute.com_end.substring(4,6) }월 ${commute.com_end.substring(6,8) }일 ${commute.com_end.substring(8,10) }시 ${commute.com_end.substring(10,12) }분  ${commute.com_end.substring(12,14) }초</td>
			</c:if>
			<c:if test="${commute.com_end == null }">
				<td id="com_end${commute.com_num }"></td>
			</c:if>
			<td>${commute.com_lateTime }</td>
			<td>${commute.com_workTime }</td>
			<td>상태</td>
			<td>근태사유</td>
		</tr>
	</c:forEach> --%>
	
	
<%-- 	<c:forEach items="${calendar}" var="calendar" >
		<div class="commute" id="commute" >
			<div class="col-sm" id="요일">요일</div>								
			<div class="col-sm" id="출근"></div>
			<div class="col-sm" id="퇴근"></div>
			<div class="col-sm" id="지각"></div>							
			<div class="col-sm" id="근무></div>
			<div class="col-sm" id="상태"></div>
			<div class="col-sm" id="근태사유"></div>
		</div>
	</c:forEach> --%>
</body>
</html>