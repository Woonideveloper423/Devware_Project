<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>

  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <!-- summernote -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>

<script type="text/javascript">

$( function() {
    $( "#halfPick" ).datepicker({
    	defaultDate: new Date(),
        changeMonth: true,
        changeYear: true,
    	beforeShow: function (textbox, instance) {
		       var txtBoxOffset = $(this).offset();
		       var top = txtBoxOffset.top;
		       var left = txtBoxOffset.left;
		       var textBoxWidth = $(this).outerWidth();
		               setTimeout(function () {
		                   instance.dpDiv.css({
		                       top: top, //you can adjust this value accordingly  
		                       left: left//show at the end of textBox
		               });
		           }, 0);

		   }
    });
  } );

$(function(){
	$(".board").hover(function(){
		$(this).css("background", "#dddddd");	
	},function(){
		$(this).css("background", "#fdfdfd");
		$(".board:first").css("background", "#dddddd");
	});
	
	$("#allcheck").click(function(){
	    //??????????????????
	    if($("#allcheck").prop("checked")){
	        //input????????? name??? chk??? ???????????? ????????? checked????????? true??? ??????
	        $("input[name=checkedReply]").prop("checked",true);
	        //????????? ???????????????
	    }else{
	        //input????????? name??? chk??? ???????????? ????????? checked????????? false??? ??????
	        $("input[name=checkedReply]").prop("checked",false);
	    }
	});
	
	$("#frm").submit(function(){
		if(!$("input[name=checkedReply]").is(":checked")){
			alert("????????? ????????? ????????? ?????????");
			return false;
		}
		return true;
	});
});
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
     
    var msg = currentDate.getHours()+"???"
    msg += currentDate.getMinutes()+"???";
    msg += currentDate.getSeconds()+"???";
     
    divClock.innerText = msg;
    setTimeout(time,1000);
}
$(function(){
	$("#arrive").click(function(){
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/commuting/arrive",
			success:function(data){
				console.log(data);
				try{
					var json = eval('('+data+')');			
					console.log(json)
					$('#row_${ now }').val(json.commuting_id);
					$('#arrive_${ now }').text(json.commuting_arrive);
					$('#stat_${ now }').text('?????????');
					alert('${sessionScope.member.member_name}??? '+json.commuting_arrive+' ???????????? ???????????????.');
					
					var arrive = new Date("2019-02-01 "+json.commuting_arrive);
					var ontime = new Date("2019-02-01 09:00:00");
					var gap = arrive.getTime() - ontime.getTime();
					
					if(gap/1000/60 >0){
						if(Math.floor(gap/1000/60/60)>0){
							var hour = Math.floor(gap/1000/60/60);
							$('#delay_${ now }').text(hour+"??????"+Math.floor((gap-(hour*1000*60*60))/1000/60)+"???");
						}else{
							$('#delay_${ now }').text(Math.ceil(gap/1000/60)+"???");
						} 
					}
					
					/* $('#reason_${ now }').text(json.commuting_comment);
					if($('#arrive_${ now }').text() != '' || $('#leave_${ now }').text() != ''){
						$('#reasonBtn_${ now }').html("<button class='btn btn-outline-primary btn-sm' click='goModal(${ now });'>??????</button>");
					} */
					
				}catch(Exception){
					alert(data);
				}
			}//success end
		});
	});//arrive click end
	
	$("#leave").click(function(){

		if($('#arrive_${now}').text() == ''){
			alert('???????????? ?????? ????????????.');
			return;
		}
		
		if(confirm('?????? ???????????? ???????????????????')){
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/commuting/leave",
			success:function(data){
				console.log(data);
				try{
					var json = eval('('+data+')');			
					console.log(json)
					$('#leave_${ now }').text(json.commuting_leave);
					$('#stat_${ now }').text(json.commuting_status);
					alert('${sessionScope.member.member_name}??? '+json.commuting_leave+' ???????????? ???????????????.');
					
					//==================================================================================
					
					var work_arrive = new Date("2019-02-01 "+json.commuting_arrive);
					var work_leave = new Date("2019-02-01 "+json.commuting_leave);
					var gap2 = work_leave.getTime() - work_arrive.getTime();
					
					if(gap2/1000/60 >0){
						if(Math.floor(gap2/1000/60/60)>0){
							var hour = Math.floor(gap2/1000/60/60);
							$('#over_${ now }').text(hour+"??????"+Math.floor((gap2-(hour*1000*60*60))/1000/60)+"???");
						}else{
							$('#over_${ now }').text(Math.ceil(gap2/1000/60)+"???"); 
						}
					}
					
					//==================================================================================
					
				}catch(Exception){
					alert(data);
				}				
			}//success end
		});
		}else{
			return;
		}
	});//leave click end
	
		
}); 

//============================================================================================================get Member commuting
	$(document).ready(function(){
		
		var param = "year=${ year }&month=${ month }";
		$.ajax({
			type:"POST",
			url:"../commuting/view",
			data:param,
			success:function(data){
				var arr = JSON.parse(data);
				console.log(arr);
				for(var i = 0; i < arr.length; i++){
					
					
					console.log(arr[i].commuting_status);
					console.log(arr[i].commuting_status_date);
					//console.log(arr[i].commuting_status_date.substring(0,2));
					try{
					var num = parseInt(arr[i].commuting_status_date.substring(0,2));
					$('#reason_'+num+'').val(arr[i].commuting_comment);
					$('#row_'+num+'').val(arr[i].commuting_id);
					}catch(e){
						console.log(e)
					}
					
					
					try{
						$('#arrive_'+num+'').text(arr[i].commuting_arrive.slice(2));
						$('#leave_'+num+'').text(arr[i].commuting_leave.slice(2));
					}catch(Exception){	}
					 
					console.log(parseInt('${now}') > num);
					console.log(num);
					console.log(parseInt('${now}'));
					
					if(parseInt('${now}') > num){
						$('#stat_'+num+'').text(arr[i].commuting_status);
					}else if($('#arrive_'+num+'').text() != '' && $('#leave_'+num+'').text() == ''){
						$('#stat_'+num+'').text('?????????');
					}else {
						$('#stat_'+num+'').text(arr[i].commuting_status);
					}
					
					try{
						var arrive = new Date("2019-02-01 "+arr[i].commuting_arrive.slice(2));
						var ontime = new Date("2019-02-01 09:00:00");
						var gap = arrive.getTime() - ontime.getTime();
					
					
						if(gap/1000/60 >0){
							if(Math.floor(gap/1000/60/60)>0){
								var hour = Math.floor(gap/1000/60/60);
								$('#delay_'+num+'').text(hour+"??????"+Math.floor((gap-(hour*1000*60*60))/1000/60)+"???");
							}else{
								$('#delay_'+num+'').text(Math.ceil(gap/1000/60)+"???");
							} 
						}
					}catch(Exception){}
					
					try{
						var work_arrive = new Date("2019-02-01 "+arr[i].commuting_arrive.slice(2));
						var work_leave = new Date("2019-02-01 "+arr[i].commuting_leave.slice(2));
						var gap2 = work_leave.getTime() - work_arrive.getTime();
						
						if(gap2/1000/60 >0){
							if(Math.floor(gap2/1000/60/60)>0){
								var hour = Math.floor(gap2/1000/60/60);
								$('#over_'+num+'').text(hour+"??????"+Math.floor((gap2-(hour*1000*60*60))/1000/60)+"???");
							}else{
								$('#over_'+num+'').text(Math.ceil(gap2/1000/60)+"???"); 
							} 1
						}
					}catch(Exception){
						
					}//catch end
					
					$('#reason_'+num+'').html(arr[i].commuting_comment);
					if($('#arrive_'+num+'').text() != '' || $('#leave_'+num+'').text() != ''){
						$('#reasonBtn_'+num+'').html("<button class='btn btn-outline-primary btn-sm' onclick='goModal("+num+");'>??????</button>");
					}
				}//for end
				
			}
		}); // ajax end
		
		
		$('#row_${day}').css('background','#FF6347');
		
		
		$('#summernote').summernote({
			  lang: 'ko-KR',
		      height: 200,
		      popover: {
		    	  image:[],
		    	  link:[],
		    	  air:[]
		      },
		      toolbar: [
		    	    // [groupName, [list of button]]
		    	    ['style', ['bold', 'italic', 'underline', 'clear']],
		    	    ['fontsize', ['fontsize']],
		    	    ['color', ['color']],
		    	    ['para', ['ul', 'ol', 'paragraph']],
		    	  ]
		  });
		
		
	}) // ready end

function nextMonth(){
	if(${month > 11}){
		$('<input></input>').attr('type','hidden').attr('name', 'month').attr('value','${month%12}').appendTo('#selectDayForm');
		$('<input></input>').attr('type','hidden').attr('name', 'year').attr('value','${year+1}').appendTo('#selectDayForm');
	}else{
		$('<input></input>').attr('type','hidden').attr('name', 'month').attr('value','${month}').appendTo('#selectDayForm');
		$('<input></input>').attr('type','hidden').attr('name', 'year').attr('value','${year}').appendTo('#selectDayForm');
	}
	$('#selectDayForm').submit();
}


function previousMonth(){
	if(${month-2 < 0}){
		$('<input></input>').attr('type','hidden').attr('name', 'month').attr('value','${month+10}').appendTo('#selectDayForm');
		$('<input></input>').attr('type','hidden').attr('name', 'year').attr('value','${year-1}').appendTo('#selectDayForm');
	}else{
		$('<input></input>').attr('type','hidden').attr('name', 'month').attr('value','${month-2}').appendTo('#selectDayForm');
		$('<input></input>').attr('type','hidden').attr('name', 'year').attr('value','${year}').appendTo('#selectDayForm');
	}
	$('#selectDayForm').submit();
} 

function nextYear(){
	$('<input></input>').attr('type','hidden').attr('name', 'month').attr('value','${month-1}').appendTo('#selectDayForm');
	$('<input></input>').attr('type','hidden').attr('name', 'year').attr('value','${year+1}').appendTo('#selectDayForm');
	$('#selectDayForm').submit();
}


function previousYear(){
	$('<input></input>').attr('type','hidden').attr('name', 'month').attr('value','${month-1}').appendTo('#selectDayForm');
	$('<input></input>').attr('type','hidden').attr('name', 'year').attr('value','${year-1}').appendTo('#selectDayForm');
	$('#selectDayForm').submit();
} 

function today(){
		$('<input></input>').attr('type','hidden').attr('name', 'month').attr('value',null).appendTo('#selectDayForm');
		$('<input></input>').attr('type','hidden').attr('name', 'year').attr('value',null).appendTo('#selectDayForm');
	
	$('#selectDayForm').submit();
}

function datePick(){
	
	var dPick = $('#halfPick').val();
	console.log(dPick);
	
	var arr = dPick.split('/');
	console.log(arr[0])
	console.log(arr[1])
	console.log(arr[2])
	
	$('<input></input>').attr('type','hidden').attr('name', 'month').attr('value',arr[0]).appendTo('#selectDayForm');
	$('<input></input>').attr('type','hidden').attr('name', 'day').attr('value',arr[1]).appendTo('#selectDayForm');
	$('<input></input>').attr('type','hidden').attr('name', 'year').attr('value',arr[2]).appendTo('#selectDayForm');
	$('<input></input>').attr('type','hidden').attr('name', 'dPick').attr('value',dPick).appendTo('#selectDayForm');
	
	$('#selectDayForm').submit();
}


//////////////////////// ????????? ????????????/////////////////////////////
function startTime(){
	var Now = new Date(); // ?????? ?????? ??? ??????
	var nowyear = Now.getFullYear(); //???
	var nowMonth = Now.getMonth() + 1; // ???
	var nowDay = Now.getDate(); // ???
	var nowHour = Now.getHours(); // ???
	var nowMins = Now.getMinutes(); // ???
	var nowSecs = Now.getSeconds(); // ???
	
	//????????? ????????? ????????? 0 ??????
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
		
	//?????? ??????
	var emp_num = 1;
	var com_date = new Date();
	var com_start = nowyear +""+ nowMonth +""+ nowDay +""+ nowHour +""+ nowMins + "" +nowSecs +"";
	var com_end = null;
	var com_num = nowyear +""+ nowMonth +""+ nowDay
	
	
	var msg = nowyear +"???"+ nowMonth +"???"+ nowDay +"???"+ nowHour +"???"+ nowMins + "???" +nowSecs +"???";
	
	
	alert(msg + "??? ?????? ?????????????????????");
	$.ajax({
		url : "<%=context%>/startTime",
		type : 'post',
		data : { 	
					com_start,
					com_end,
					msg,
					emp_num,
					com_date,
					com_num
				},
		dataType : 'json'
	}); 
}

function endTime(){
	var Now = new Date(); // ?????? ?????? ??? ??????
	var nowyear = Now.getFullYear(); //???
	var nowMonth = Now.getMonth() + 1; // ???
	var nowDay = Now.getDate(); // ???
	var nowHour = Now.getHours(); // ???
	var nowMins = Now.getMinutes(); // ???
	var nowSecs = Now.getSeconds(); // ???
	
	//????????? ????????? ????????? 0 ??????
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
		
	//?????? ??????
	var emp_num = 1;
	var com_date = new Date();
	var com_end = nowyear +""+ nowMonth +""+ nowDay +""+ nowHour +""+ nowMins + "" +nowSecs +"";
	var com_num = nowyear +""+ nowMonth +""+ nowDay
	var com_start = null;
	
	
	var msg = nowyear +"???"+ nowMonth +"???"+ nowDay +"???"+ nowHour +"???"+ nowMins + "???" +nowSecs +"???";
	console.log("?????????"+com_num);
	
	$.ajax({
		url : "<%=context%>/findTime",
		type : 'post',
		data : { 	
					"com_end" : com_end,
					"com_num" : com_num
				},
		dataType : 'json',
 		success:function(commute){
 			var com_end2 = data;
			var endstr = data.substring(0,4) + '??? ' + data.substring(4,6) + '??? ' + data.substring(6,8) + '??? ' + data.substring(8,10) + '??? '+ data.substring(10,12)+ '??? ' + data.substring(12,14) + '???';
			console.log("????????? ->"+endstr);
			$("#com_end"+com_num).empty();
 			$("#com_end"+com_num).html(endstr);
 			
 			com_start=$("#com_start"+com_num).attr('name');
 
 			
  			$("#com_gap").html(commute.com_workTime);
 			
		} 
	}); 
}
</script>

</head>
<body>
<div class="container">
	<div class="container-fluid text-center">

		<!-- ????????? -->
 	<div class="col-lg-12">
 		
              <div class="card" >
                <div class="card-header py-3">
                
                  <h4 class="m-0 font-weight-bold text-primary"><strong>????????????</strong></h4><div align="right">	
				<div>
				   <form id="selectDayForm" action="${ pageContext.request.contextPath }/commuting/commuting"></form>          	
				
						<div class="clearfix">
	<div class="float-left">
		<h2>${ year }??? ${ month }???  <strong><span id="current_time"></span></strong></h2>
	</div>	
	 <div class="float-right">
					<input type="hidden" id="commuting_member_id" value="${sessionScope.member.member_id}"/>
					<input style="width: 150pt;" type="button" id="startTime" onclick="startTime();" class="btn btn-outline-success" value="??????"></input>
					<input style="width: 150pt;" type="button" id="endTime" onclick="endTime();" class="btn btn-outline-success" value="??????"></input>
					</div>
					
					</div>
				</div>
			
				</div>
                </div>
                
                <div class="card-body text-center">
                
                  <div class="clearfix">
                  <div class="float-right">
                  
		<input class="btn btn-outline-primary" type="text" id="halfPick" name="halfPick" onchange="datePick()" value="${ dPick }">
		<button class="btn btn-outline-primary" onclick="previousYear()">?????????</button>
		<button class="btn btn-outline-primary" onclick="previousMonth()">?????????</button>
		<button class="btn btn-outline-primary" onclick="today()">??????</button>
		<button class="btn btn-outline-primary" onclick="nextMonth()">?????????</button>
		<button class="btn btn-outline-primary" onclick="nextYear()">?????????</button>
	</div></div>
                  <hr>
                   <div style="height:650px; overflow:auto; overflow-x:hidden; overflow-y:auto;" align=left>
                  
                  
	<div class="row board text-center" style="background-color: #dddddd;" >
		<div class="col-sm"><strong>??????</strong></div>
		<div class="col-sm"><strong>????????????</strong></div>
		<div class="col-sm"><strong>????????????</strong></div>
		<div class="col-sm"><strong>????????????</strong></div>
		<div class="col-sm"><strong>????????????</strong></div>
		<div class="col-sm"><strong>??????</strong></div>
		<div class="col-sm"><strong>????????????</strong></div>
		<div style="width:8%"><strong></strong></div>
	</div>
	<%-- <c:if test="${commute.com_num.substring(6,8) == status.count }">${commute.com_start }</c:if> --%>
	<c:forEach items="${calendar}" var="calendar" varStatus="status">
			<div class="row board text-center" id="row_${status.count}">	
				<div class="col-sm" id="day_${status.count}">${calendar.day}(${calendar.days})/${status.count}</div>	
	 			<div class="col-sm" id="arrive_${status.count}"></div>
				<div class="col-sm" id="leave_${status.count}"></div>
				<div class="col-sm" id="delay_${status.count}"></div>							
				<div class="col-sm" id="over_${status.count}"></div>
				<div class="col-sm" id="stat_${status.count}"></div>
				<div class="col-sm" id="reason_${status.count}"></div>
				<div style="width:8%" id="reasonBtn_${status.count}"></div>
			</div>
	</c:forEach>						
</div>
                  
                  <hr>
                 
                
			
                </div>
              </div>
			
            </div>
            </div></div>



<!-- ???????????? ================================================================================================================================== -->
<!-- 					<div class="modal fade" id="dayModal" role="dialog">
    					<div class="modal-dialog">
							<div class="modal-content">
								MODAL HEADER
								<div class="modal-header">
									<h4 class="modal-title">?????? ??????</h4>
									<button type="button" class="close float-right" data-dismiss="modal">&times;</button>
								</div>
								
								MODAL BODY
								<div class="modal-body" id="modalBody">
								hidden value
								<input type="hidden" id="rowNum">
								<div class="form-group row">
									<div class="form-group" style="padding-left: 40px;">
										<div class="row text-center"> 
											<div align= "center" ><h4 id="modalDate"></h4></div>
										</div>
										<div class="row">
										<div class="col-6" style="padding-left: 40px;">
										<span><label >????????????</label></span>
											&nbsp;&nbsp;&nbsp;<label id="arTime"></label>
										</div>
										<div class="col-6" style="padding-left: 40px;">
										<span><label >????????????</label></span>
											&nbsp;&nbsp;&nbsp;<label  id="lvTime"></label>
										</div>
										</div>
									</div>
										<div id="pcontent" class="col-lg-12">
											<textarea id="summernote" name="summernote" ></textarea>
										</div>
								</div>
								
								<div class="modal-footer">
									<button type="button" class="btn btn-outline-primary" data-dismiss="modal" onclick="commentBtn()">????????????</button>
									<button type="button" class="btn btn-outline-primary" data-dismiss="modal">??????</button>
								</div>
							</div>
						</div>
					</div>
				</div> -->

</body>
</html>