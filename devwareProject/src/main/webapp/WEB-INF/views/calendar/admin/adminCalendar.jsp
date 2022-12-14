<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String context = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Calendar</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
	
	
	
	<!-- Full Calendar 참조 -->
	<link rel='stylesheet' href='${pageContext.request.contextPath}/resources/fullcalendar/fullcalendar.css' />
	<script src='${pageContext.request.contextPath}/resources/fullcalendar/lib/moment.min.js'></script>
	<script src='${pageContext.request.contextPath}/resources/fullcalendar/fullcalendar.js'></script>
	<script src='${pageContext.request.contextPath}/resources/fullcalendar/lang/ko.js'></script>
</head>
<script type="text/javascript">

var allDay = false;
var aDay = false;


function adChBx() //allTimeCheck 시 
{
	if($('#allDay').is(':checked'))
	{
		$('#start_time').attr('disabled',true);
		$('#end_time').attr('disabled',true);
		allDay = true;
	}else
	{
		$('#start_time').removeAttr('disabled')
		$('#end_time').removeAttr('disabled')
		allDay = false;
	}
}

function modadChBx(){
	if($('#modallDay').is(':checked')){
		$('#modstart_time').attr('disabled',true);
		$('#modend_time').attr('disabled',true);
	}else{
		$('#modstart_time').removeAttr('disabled')
		$('#modend_time').removeAttr('disabled')
	}
}

function modifyEvent()
{
	$("#dayModal").modal('hide');
	var modId = $("#pid").val();
	$("#modId").val(modId);
	console.log("수정 Id : " + modId);
	
	$("#modModal").modal();
	
	var modIsAllDay = $('#isallDay').val();
	console.log("하루 체크 : " + modIsAllDay);
	
	if(modIsAllDay == 1)
	{
		$('#modallDay').attr('checked', 'checked');	
	}
	else if(modIsAllDay == 0)
	{
		$('#modallDay').removeAttr('checked');	
	}
	
	var title = $("#psubject").text();
	console.log("수정 제목: " + title);
	
  	var content = $("#pcontent").html();
  	console.log("수정 내용: " + content);
  	
  	var endDate = moment($('#pend').text()).format('YYYY-MM-DD');
  	console.log("수정 끝 날짜 : " + endDate);
  	var endTime = moment($('#pend').text()).format('hh:mm:ss');
  	console.log("수정 끝 시간 : " + endTime);
  	var startDate = moment($('#pstart').text()).format('YYYY-MM-DD');
  	console.log("수정 시작 날짜 : " + startDate);
  	var startTime = moment($('#pstart').text()).format('hh:mm:ss');
  	console.log("수정 시작 시간 : " + startTime);
  	
	$('#modend_date').val(endDate);
  	$('#modend_time').val(endTime);
  	$('#modstart_date').val(startDate);
  	$('#modstart_time').val(startTime);
  	$('#modsname').val(title);
  	$('#modsummernote').html(content);
  	
}



function deleteEvent()
{
	var eventId = $("#pid").val();
	alert(eventId);
	
	var emp_num = $('#emp_num').val();
	alert(emp_num);
	
	if(confirm("정말 삭제하시겠습니까?"))
	{
		$.ajax({
			type: 'post',
			url: "<%=context%>/deleteEvent",
			data : { eventId : eventId },
	     	success: function(data) 
	     	{
	    	  var result = data;
	    	  if(result == 0)
	    	  {
	    		alert("일정 추가에 실패하였습니다. 다시 입력해 주세요");  
	    	  }
	    	  else
	    	  {
	    		alert("일정 삭제에 성공하였습니다."); 
	    		$("#dayModal").modal('hide');
	    		location.href='<%=context%>/manageCalendar?emp_num='+emp_num;
	    	  }
	      	}
		});
	} else {
		return false;
	}
}
function searchUsingEmpNum()
{
	var emp_num = $('#empName').val();
	alert("사원 번호: "+emp_num);
	
	location.href='<%=context%>/manageCalendar?emp_num='+emp_num;

}

function modifyBtn()
{
	  var emp_num = $('#emp_num').val();
      alert(emp_num);
	
	  var stitle = $('#modsname').val(); //글 제목
	  console.log("글 제목 : " + stitle);
	  
	  var scontent = $('#modsummernote').val(); //글 내용
	  console.log("글 내용 : " +scontent);
	  
	  var start = $('#modstart_date').val();	// 시작 날짜
	  console.log("시작 날짜 : " +start);
	  
	  var end = $('#modend_date').val();		// 종료 날짜  
	  console.log("종료 날짜 : " +end);
	  
	  var start_time = $('#modstart_time').val();	//시작 시간
	  console.log("시작 시간 : " +start_time);
	  
	  var end_time = $('#modend_time').val();		//종료 시간
	  console.log("종료 시간 : " +end_time);
	  
	  var modId = $('#modId').val();
	  console.log("글 번호 : " + modId);
	  
	  //제목이 공백이 일때
	  if(stitle.trim() == ''){
		  alert('제목을 다시 입력해 주세요');
		  $('#sname').val('');
		  return;
	  }
	  
	  //제목 & 내용이 공백이 아닐 때 
	  if (stitle != '' && scontent != '' && start != null && end != null) 
	  {
		  
	  	var st;
	  	var en;
	    if(!aDay && st >= en)
	    {
	  		alert("종료 일이 시작일 보다 빠를 수 없습니다.");
	  		return;
	    }
			
	    var allDayCheck = 0;
	    
	    if(aDay)
	    {
	    	st = start;
	    	en = moment(end).add(1, 'days').format('YYYY-MM-DD');
	    	allDayCheck = 1;
	    }
	    else 
	    {
		    st = start+" "+start_time;
		    en = end+" "+end_time;
		    allDayCheck = 0;
	    }
		
	    var emp_num = $('#emp_num').val();
	    alert(emp_num);
	    
	    var param = "calendar_id="+modId+"&calendar_start="+st+"&calendar_end="+en+"&calendar_title="+stitle.trim()+"&calendar_content="+scontent+"&calendar_allDay="+allDayCheck+"&calendar_emp_num="+emp_num;	
	    console.log(param);

	    $.ajax(
	    {
	    	type: 'POST',
	     	url: "<%=context%>/modifyEvent",
	     	data: param,
	     	success: function(data) 
	     	{
	    	  var result = data;
	    	  if(result == 0)
	    	  {
	    		alert("일정 수정에 실패하였습니다. 다시 입력해 주세요");  
	    	  }
	    	  else
	    	  {
	    		alert("일정 수정에 성공하였습니다.");  
	    		$("#modId").modal('hide');
	    		location.href='<%=context%>/manageCalendar?emp_num='+emp_num;
	    	  }
	      	}
	  	});
	  }
}

function userlistDeptSearch()
{
	var deptnum = $('#deptnum').val();
	
 	$.ajax({
		type: 'POST',
     	url: "<%=context%>/getEmpByDeptNum",
     	data: {deptnum : deptnum},
     	success: function(data) 
     	{
     		$("#empName").empty();
			$.each(data, function(index, element)
			{
				$("#empName").append("<option value="+element.emp_num+">"+ element.emp_name +"</option>");
			});	 
		}	
	});
}

function registBtn()
{
  alert(allDay);
  var stitle = $('#sname').val(); //글 제목
  console.log("글 제목 : " + stitle);
  
  var scontent = $('#summernote').val(); //글 내용
  console.log("글 내용 : " +scontent);
  
  var start = $('#start_date').val();	// 시작 날짜
  console.log("시작 날짜 : " +start);
  
  var end = $('#end_date').val();		// 종료 날짜  
  console.log("종료 날짜 : " +end);
  
  var start_time = $('#start_time').val();	//시작 시간
  console.log("시작 시간 : " +start_time);
  
  var end_time = $('#end_time').val();		//종료 시간
  console.log("종료 시간 : " +end_time);
  
  
  //제목이 공백이 일때
  if(stitle.trim() == ''){
	  alert('제목을 다시 입력해 주세요');
	  $('#sname').val('');
	  return;
  }
  
  //제목 & 내용이 공백이 아닐 때 
  if (stitle != '' && scontent != '' && start != null && end != null) 
  {
	  
  	var st;
  	var en;
    if(!allDay && st >= en)
    {
  		alert("종료 일이 시작일 보다 빠를 수 없습니다.");
  		return;
    }
		
    var allDayCheck = 0;
    
    if(allDay)
    {
    	st = start;
    	en = moment(end).add(1, 'days').format('YYYY-MM-DD');
    	allDayCheck = 1;
    }
    else 
    {
	    st = start+" "+start_time;
	    en = end+" "+end_time;
	    allDayCheck = 0;
    }
	
    var emp_num = $('#emp_num').val();
    alert(emp_num);
    
    var param = "calendar_start="+st+"&calendar_end="+en+"&calendar_title="+stitle.trim()+"&calendar_content="+scontent+"&calendar_allDay="+allDayCheck+"&calendar_emp_num=" + emp_num;
    console.log(param);
    
    $.ajax(
    {
    	type: 'POST',
     	url: "<%=context%>/addEvent",
     	data: param,
     	success: function(data) 
     	{
    	  var result = data;
    	  if(result == 0)
    	  {
    		alert("일정 추가에 실패하였습니다. 다시 입력해 주세요");  
    	  }
    	  else
    	  {
    		  
    		alert("일정 추가에 성공하였습니다.");  
    		$("#myModal").modal('hide');
    		location.href='<%=context%>/manageCalendar?emp_num='+emp_num;
    	  }
      	}
  	});
  }
}

$(document).ready(function()
{  	
	var request = $.ajax({
        url: "<%=context%>/searchAll", // 변경하기
        method: "POST",
        dataType: "json",
        data: {
			emp_num : ${emp_num}
		}
    });
	
	
	 request.done(function (data) 
	 {
		//캘린더 생성
	    var $calendar = $("#calendar").fullCalendar({ 
	        header: {
	          left: 'prevYear,nextYear',
	          center: 'title',
	          right: 'today,month,prev,next'
	        },
	        selectable: true, //날짜 일자 드래그 설정 가능
	        eventLimit: true, 
	        navLinks: true,	//날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
	        editable: true, //수정 가능
	        resizeable: false,
	        events: data,
	
		   	select: function (start,end) //캘린더에서 드래그로 이벤트 발생시
		   	{
		   		$("#myModal").modal(); //모달 창 생성
		   		$('#start_date').val(moment(start).format('YYYY-MM-DD'));
		        $('#end_date').val(moment(end).subtract(1, 'days').format('YYYY-MM-DD'));
		   	},
	        
	        eventClick: function(event, jsEvent, view) 
	        {
	        	console.log(event);
	        	$("#pid").val(event.id);
	        	
	        	if(event.allDay == 1)
	        	{
		        	$('#isallDay').val('1');	
		        	$('#pend').text(moment(event.fin).format('YYYY-MM-DD  HH:mm:ss'));
	        	} else if(event.allDay == 0)
	        	{
		        	$('#isallDay').val('0');
		        	$('#pend').text(moment(event.fin).format('YYYY-MM-DD  HH:mm:ss'));
	        	}
	        	$("#psubject").text(event.title);
	        	$("#pcontent").html(event.content);
	        	$('#pstart').text(moment(event.start).format('YYYY-MM-DD  HH:mm:ss'));
	        	$("#dayModal").modal();	
	        }
	    });
	});
});

</script>
<body>
<div>
	조회:
	<select name="deptnum" id="deptnum" onchange="userlistDeptSearch()">
		<c:forEach var="dept" items="${deptlist}">
			<option value="${dept.dept_num}">${dept.dept_name}</option>
		</c:forEach>
	</select>
	
	<select name="empName" id="empName">
		
	</select>
	
	<button type="button" onclick="searchUsingEmpNum()">조회하기</button>
	<input id="emp_num" type="hidden" value="${emp_num}"> 
</div>

<h3 style=" text-align: center;">${name} 캘린더</h3> 

<div id="calendar">

</div>
	<!-- 일정 확인 모달 -->
<div class="modal fade" id="dayModal" role="dialog">
    <div class="modal-dialog">
		<div class="modal-content">
			<form class="form-horizontal" role="form" id="sform" action="" method="get">
				
				<!-- MODAL HEADER -->					
				<div class="modal-header">
					<h4 class="modal-title">일정 보기</h4>
					<button type="button" class="close float-right" data-dismiss="modal">&times;</button>
				</div>
							
				<!-- MODAL BODY -->
				<div class="modal-body" id="modalBody">					
						<input type="hidden" id="isallDay">
						<input type="hidden" id="pid">
						<div class="form-group row" style="padding-left: 40px;">
							<div align= "center"><label >시작날짜</label></div>
							<label class="col-lg-10" id="pstart"></label>
						</div>
						
						<div class="form-group row" style="padding-left: 40px;">
							<div align= "center"><label >종료날짜</label></div>
							<label class="col-lg-10" id="pend"></label>
						</div>
						
						<div class="form-group row" style="padding-left: 40px;">
							<div align= "center"><label >제목</label></div>
							<label class="col-lg-10" id="psubject"></label>
						</div>
						
						<div class="form-group row" style="padding-left: 40px;">
							<div align= "center"><label >내용</label></div>
							<div id="pcontent" class="col-lg-10"></div>
						</div>
				</div>			
			</form>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal" onclick="modifyEvent()">수정하기</button>
				<button type="button" class="btn btn-default" id="deleteBtn" onclick="deleteEvent()" >삭제하기</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
	
<!-- 일정 등록 모달 -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog modal-60size">
		<div class="modal-content">
			<form class="form-horizontal" role="form" id="sform" action="/addCalendar" method="get">
				<div class="modal-header">
					<h4 class="modal-title">일정 등록하기</h4>
					<button type="button" class="close float-right" data-dismiss="modal">&times;</button>
				</div>
		
				<div class="modal-body" >
					<div class="form-group row">
						<label class=" control-label " style="padding-left: 40px;">구분</label>
						<div class="col-5">				
							<div id="selfCate" style="display: none;">
								<input type="text" id="selfInput" style="display: inline; width: 100px;">
								<input type="color" id="colorFix" onclick="console.log(this.value)" style="display: inline;">
							</div>				
						</div>
												
						<div style="padding-left: 40px;">
							<input type="checkbox" name="aDay" id="allDay" onchange="adChBx()">하루종일
						</div>
					</div>
					
					<div class="form-group row">
						<label class=" control-label " style="padding-left: 40px;">시작날짜</label>
							<div class="col-8">
								<input type="date" name="sstart_date" id="start_date"> 
								<input type="time" name="sstart_time" id="start_time" class="st">
							</div>
					</div>
					<div class="form-group row">
						<label class=" control-label " style="padding-left: 40px;">종료날짜</label>
							<div class="col-8">
								<input type="date" name="send_date" id="end_date"> 
								<input type="time" name="send_time" id="end_time" class="st">
							</div>
					</div>
					<div class="form-group row">
						<label class=" control-label " style="padding-left: 40px;">제목</label>
							<div class="col-8">
								<input type="text" name="sname" id="sname" style="width: 300px;">
							</div>
					</div>
					<div class="form-group" id="text">
							<textarea id="summernote" name="summernote"></textarea>
					</div>
					</div>
			</form>
				
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-default" id="registBtn" onclick="registBtn();">등록하기</button>
			</div>
		</div>
	</div>
</div>	
<!-- 수정 모달 -->
<div class="modal fade" id="modModal" role="dialog">
		<div class="modal-dialog modal-60size">
			<div class="modal-content">
				<form class="form-horizontal" role="form" id="sform" action="" method="get">
					<!-- MODAL HEADER -->
					<div class="modal-header">
						<h4 class="modal-title">일정 수정하기</h4>
						<button type="button" class="close float-right" data-dismiss="modal">&times;</button>
					</div>
								
					<!-- MODAL BODY -->
					<div class="modal-body" >
							<div class="form-group row">
								<div class="col-5">
									<div style="padding-left: 40px;">
										<input type="checkbox" name="aDay" id="modallDay" onchange="modadChBx();">하루종일
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label class=" control-label " style="padding-left: 40px;">시작날짜</label>
								<div class="col-8">
									<input type="date" name="sstart_date" id="modstart_date"> 
									<input type="time" name="sstart_time" id="modstart_time" class="st">
								</div>
							</div>
							
							<div class="form-group row">
								<label class=" control-label " style="padding-left: 40px;">종료날짜</label>
								<div class="col-8">
									<input type="date" name="send_date" id="modend_date"> 
									<input type="time" name="send_time" id="modend_time" class="st">
								</div>
							</div>
							<div class="form-group row">
								<label class=" control-label " style="padding-left: 40px;">제목</label>
								<div class="col-8">
									<input type="text" name="sname" id="modsname" style="width: 300px;">
								</div>
							</div>
							<div class="form-group " id="modtext">
								<textarea id="modsummernote" name="modsummernote"></textarea>
							</div>
						</div>
							<input type="hidden" id="modId">
					</form>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-default" id="modregistBtn" onclick="modifyBtn();">수정하기</button>
					</div>
			</div>
		</div>
</div>
</body>
</html>