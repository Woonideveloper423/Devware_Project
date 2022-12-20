<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String context = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>

	<!-- Full Calendar 참조 -->
	<link rel='stylesheet' href='${pageContext.request.contextPath}/resources/fullcalendar/fullcalendar.css' />
	<script src='${pageContext.request.contextPath}/resources/fullcalendar/lib/moment.min.js'></script>
	<script src='${pageContext.request.contextPath}/resources/fullcalendar/fullcalendar.js'></script>
	<script src='${pageContext.request.contextPath}/resources/fullcalendar/lang/ko.js'></script>
	<script type="text/javascript">

var allDay = false;
var aDay = false;
/* function adChBx() //allTimeCheck 시 
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
} */

function modifyEvent()
{
	$("#dayModal").modal('hide');
	var modId = $("#pid").val();
	$("#modId").val(modId);
	console.log("수정 Id : " + modId);
	
	$("#modModal").modal();
	
	var modIsAllDay = $('#isallDay').val();
	console.log("하루 체크 : " + modIsAllDay);
	
 	/* if(modIsAllDay == 1)
	{
		$('#modallDay').attr('checked', 'checked');	
	}
	else if(modIsAllDay == 0)
	{
		$('#modallDay').removeAttr('checked');	
	} */
	
	var title = $("#psubject").text();
	console.log("수정 제목: " + title);
	
  	var content = $("#pcontent").html();
  	console.log("수정 내용: " + content);
  	$("#pcontent").empty();
	$('#modsummernote').empty();
	$('#pcontent').empty();
  	var str= "<button type='button' class='btn btn-outline-primary' onclick='selectMem(" + sel_room_num +",1)'>참여자 수정</button>";
  	
  	var endDate = moment($('#pend').text()).format('YYYY-MM-DD');
  	console.log("수정 끝 날짜 : " + endDate);
  	var endTime = moment($('#pend').text()).format('hh:mm');
  	console.log("수정 끝 시간 : " + endTime);
  	var startDate = moment($('#pstart').text()).format('YYYY-MM-DD');
  	console.log("수정 시작 날짜 : " + startDate);
  	var startTime = moment($('#pstart').text()).format('hh:mm');
  	console.log("수정 시작 시간 : " + startTime);
  	
	$('#modend_date').val(endDate);
  	$('#modend_time').val(endTime);
  	$('#modstart_date').val(startDate);
  	$('#modstart_time').val(startTime);
  	$('#modsname').val(title);
  	$('#modsummernote').html(content);
  	$('#EmpModBtn').html(str);
  	
}



function deleteEvent()
{
	var eventId = $("#pid").val();

	if(confirm("정말 삭제하시겠습니까?"))
	{
		$.ajax({
			type: 'post',
			url: "<%=context%>/deleteRes",
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
	    		$("#calendar").fullCalendar('destroy');
	    		makeResCal(sel_room_num);
	    	  }
	      	}
		});
	} else {
		return false;
	}
}

function modifyBtn()
{
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
	  if (stitle != '' && start != null && end != null) 
	  {
		  
	  	var st;
	  	var en;
			
	    var allDayCheck = 0;
	    
	    /* if(aDay)
	    {
	    	st = start;
	    	en = moment(end).add(1, 'days').format('YYYY-MM-DD');
	    	allDayCheck = 1;
	    }
	    else 
	    { */
		st = start+" "+start_time;
		en = end+" "+end_time;
		allDayCheck = 0;
	    /* } */
	    
	    if(st >= en)
	    {
	  		alert("종료 일이 시작일 보다 빠를 수 없습니다.");
	  		return;
	    }
	    
	    if(new Date(st)<new Date()){
	    	alert("이미 지난 시간을 선택하셨습니다.");
	  		return;
	    }
	    
	    var res_emp_nums = [];
		
		$('.resChecked').each(function(){
			res_emp_nums.push($(this).attr("id"));
		});
	    console.log(res_emp_nums.length);
	    if(res_emp_nums.length == 0){
	    	alert("적어도 한명 이상의 인원을 선택해주세요.");
	  		return;
	    }
	    var param = "id="+modId+"&start="+st+"&fin="+en+"&title="+stitle.trim()+"&res_emp_nums="+res_emp_nums +"&emp_num=${emp.emp_num}" +"&room_num=" + sel_room_num;
	    
	    console.log(param);

	    $.ajax(
	    {
	    	type: 'POST',
	     	url: "<%=context%>/modifyRes",
	     	data: param,
	     	success: function(data) 
	     	{
	    	  var result = data;
	    	  if(result == 0)
	    	  {
	    		alert("일정 수정에 실패하였습니다. 다시 입력해 주세요");  
	    	  }else if(result == 2){
	      		alert("해당 시간대는 이미 예약되었습니다. 다시 입력해 주세요");  
	    	  }
	    	  else
	    	  {
	    		alert("일정 수정에 성공하였습니다.");  
	    		$("#modModal").modal('hide');
	    		$("#calendar").fullCalendar('destroy');
	    		makeResCal(sel_room_num);
	    		
	    		
	    	  }
	      	}
	  	});
	  }
}

function registBtn()
{

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
    
    if(st >= en)
    {
  		alert("종료 일이 시작일 보다 빠를 수 없습니다.");
  		return;
    }
    
    if(new Date(st)<new Date()){
    	alert("이미 지난 시간을 선택하셨습니다.");
  		return;
    }
    
    var res_emp_nums = [];
	
	$('.resChecked').each(function(){
		res_emp_nums.push($(this).attr("id"));
	});
    console.log(res_emp_nums.length);
    
    if(res_emp_nums.length == 0){
    	alert("적어도 한명 이상의 인원을 선택해주세요.");
  		return;
    }
    var param = "res_start="+st+"&res_end="+en+"&meeting_info="+stitle.trim()+"&res_emp_nums="+res_emp_nums+"&emp_num=${emp.emp_num}"+"&room_num=" + sel_room_num;
    	
    console.log(param);

    $.ajax(
    {
    	type: 'POST',
     	url: "<%=context%>/makeRes",
     	data: param,
     	success: function(data) 
     	{
    	  var result = data;
    	  if(result == 0)
    	  {
    		alert("일정 추가에 실패하였습니다. 다시 입력해 주세요");  
    	  }else if(result == 2){
    		alert("해당 시간대는 이미 예약되었습니다. 다시 입력해 주세요");  
    	  }
    	  else
    	  {
    		alert("일정 추가에 성공하였습니다.");  
    		$("#myModal").modal('hide');
    		$("#calendar").fullCalendar('destroy');
    		makeResCal(sel_room_num);
    	  }
      	}
  	});
  }
}

function selectMem(sel_room_num, is_modify) {
	 var res_emp_nums = [];
	console.log("is_modify->" + is_modify);
	$('.resChecked').each(function(){
		res_emp_nums.push($(this).attr("id"));
	});
	console.log("after select->" + res_emp_nums.length);
	window.open('${pageContext.request.contextPath}/user/findEmpList?sel_room_num='+ sel_room_num + '&res_emp_nums=' + res_emp_nums + '&is_modify=' + is_modify,'참여자 선택','width=1100, height=500 ,resizable = no, scrollbars = no');
}

function makeResCal(room_id){
	sel_room_num = room_id;
	alert("확인 시작");
	var request = $.ajax({
    url: "<%=context%>/roomResCheck", // 변경하기
    method: "POST",
    dataType: "json",
    data: {
		"room_num" : sel_room_num
	}
    });  
	
		
    		
		
	request.done(function (data) {
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
		    	if(sel_room_num != 0){
		      		var str= "<button type='button' class='btn btn-outline-primary' onclick='selectMem(" + sel_room_num +",0)'>참여자 선택</button>";
		      		
		    		$('#modsummernote').empty();
		    		$("#pcontent").empty();
		    		$('#showEmpList').empty();
			   		$("#myModal").modal(); //모달 창 생성
			   		$("#EmpaddBtn").html(str);
			   		$('#start_date').val(moment(start).format('YYYY-MM-DD'));
			        $('#end_date').val(moment(end).subtract(1, 'days').format('YYYY-MM-DD'));
				}
			},
	        
	        eventClick: function(event, jsEvent, view) 
	        {
	        	
	        	console.log(event);
	    		$('#modsummernote').empty();
	    		$("#pcontent").empty();
	    		$('#showEmpList').empty();
	        	var str = "";
	        	$(event.meeting_atd_vos).each(function(){
	        		str += "<div id='" + this.emp_num +"' class='resChecked'>";
					str += this.emp_name + this.position_name;
					str += "</div>";
	        	});
	        	console.log(str);
	        	$("#pid").val(event.id);
	        	
	        	
	        	if(event.allDay == 1)
	        	{
		        	$('#isallDay').val('1');	
		        	$('#pend').text(moment(event.fin).format('YYYY-MM-DD  HH:mm:ss'));
	        	} else
	        	{
		        	$('#isallDay').val('0');
		        	$('#pend').text(moment(event.fin).format('YYYY-MM-DD  HH:mm:ss'));
	        	}
	        	$("#psubject").text(event.title);
	        	$("#pcontent").html(str);
	        	
	        	if((event.emp_num == '${emp.emp_num}') && (sel_room_num!=0)){
	        		$("#res_modify_btn").show();
	        	}else{
	        		$("#res_modify_btn").hide();
	        	}
	        	$('#pstart').text(moment(event.start).format('YYYY-MM-DD  HH:mm:ss'));
	        	$("#dayModal").modal();	
	        }
	    });
		
	  	
	});
}

$(function()
{  	

	$(document).on("click","#myResCheck", function(){
		$("#title").html("<h1>나의 예약 확인</h1><input type='button' id='resCalDestroy' value='뒤로가기'>")
		$("#res_main").hide();
		makeResCal(0);
	});
	
	$(document).on("click",".resAction", function(){
		$("#title").html("<h1>"+$(this).attr("name")+"</h1><input type='button' id='resCalDestroy'  value='뒤로가기'>")
		$("#res_main").hide();
		makeResCal($(this).attr("id"));
	});
	
	$(document).on("click","#resCalDestroy", function(){
		$("#title").html("<h1>회의실 예약</h1>")
		$("#res_main").show();
		$("#calendar").fullCalendar('destroy');
	});
});

</script>
<body>
<div id="title"><h1>회의실 예약</h1></div>
<div id="res_main">
<input type="button" id="myResCheck" value="나의 예약 확인"><p>
<c:forEach var="roomShow" items="${roomInfo }">
	<c:out value="${roomShow.room_name }(수용인원  : ${roomShow.room_cntmax}명)"></c:out>
	<input type="hidden" id="maxCnt${roomShow.room_num }" value="${roomShow.room_cntmax}">
	<input type="button" class="resAction" name="${roomShow.room_name }" id="${roomShow.room_num }" value="예약하기"><p>
</c:forEach>
</div>



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
				<button type="button" id="res_modify_btn" class="btn btn-default" data-dismiss="modal" onclick="modifyEvent()">수정하기</button>
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
						<label class=" control-label " style="padding-left: 40px;">시작날짜</label>
							<div class="col-8">
								<input type="date" name="sstart_date" id="start_date"> 
								<input type="time" name="sstart_time" id="start_time" class="st">
								<!-- <input type="checkbox" name="aDay" id="allDay" onchange="adChBx()">종일 -->
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
					
					<div class="form-group row" id="text">
							<div id="showEmpList"></div>
							<div id="EmpaddBtn"></div>
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
										<!-- <input type="checkbox" name="aDay" id="modallDay" onchange="modadChBx();">하루종일 -->
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
								<div id="modsummernote"></div>
								<div id="EmpModBtn"></div>
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