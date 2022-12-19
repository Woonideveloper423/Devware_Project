<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>DEVWARE</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
   <!-- include libraries(jQuery, bootstrap) -->
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js'></script>
  <style>
 .timecheck{
  margin-top: 5px;
  }
  .map_wrap {position:relative;overflow:hidden;width:100%;height:350px;}
.radius_border{border:1px solid #919191;border-radius:5px;}     
.custom_typecontrol {position:absolute;top:10px;right:10px;overflow:hidden;width:130px;height:30px;margin:0;padding:0;z-index:1;font-size:12px;font-family:'Malgun Gothic', '맑은 고딕', sans-serif;}
.custom_typecontrol span {display:block;width:65px;height:30px;float:left;text-align:center;line-height:30px;cursor:pointer;}
.custom_typecontrol .btn {background:#fff;background:linear-gradient(#fff,  #e6e6e6);}       
.custom_typecontrol .btn:hover {background:#f5f5f5;background:linear-gradient(#f5f5f5,#e3e3e3);}
.custom_typecontrol .btn:active {background:#e6e6e6;background:linear-gradient(#e6e6e6, #fff);}    
.custom_typecontrol .selected_btn {color:#fff;background:#425470;background:linear-gradient(#425470, #5b6d8a);}
.custom_typecontrol .selected_btn:hover {color:#fff;}   
.custom_zoomcontrol {position:absolute;top:50px;right:10px;width:36px;height:80px;overflow:hidden;z-index:1;background-color:#f5f5f5;} 
.custom_zoomcontrol span {display:block;width:36px;height:40px;text-align:center;cursor:pointer;}     
.custom_zoomcontrol span img {width:15px;height:15px;padding:12px 0;border:none;}             
.custom_zoomcontrol span:first-child{border-bottom:1px solid #bfbfbf;} 
     
</style>
  
 <script type="text/javascript">
function time() {
	/* $.ajax({
		type:"POST",
		url:"/current_time",
		success:function(data){
			 var obj = eval('('+data+')'); 
			console.log(data.value);
			$("#current_time").html(data.value);
		}
	});*/
	var nowTime = new Date();
	var year = nowTime.getFullYear();
	var month = ("0" + (1 + nowTime.getMonth())).slice(-2);
	var day = ("0" + nowTime.getDate()).slice(-2);
	var hour = ("0" + nowTime.getHours()).slice(-2);
	var miniute = ("0" + nowTime.getMinutes()).slice(-2);
	var sec = ("0" + nowTime.getSeconds()).slice(-2);
	$("#current_time").html(year+"-"+month + "-" + day + " " + hour + ":" + miniute + ":" + sec);
	
	
}
/*  미결재문서 알림숫자
$.ajax({
	type:'POST',
	url: '${ pageContext.request.contextPath }/approval/notAuthApvCount',
	success: function(data){
		//console.log(data);
		$('#apvCount4').text(data);
	}
}); */
/* 근태관련 */
$(function(){
	
	 /* 출석용 시계 */
	 setInterval('time()', 1000);

	
	$(".board").hover(function(){
		$(this).css("background", "#dddddd");	
	},function(){
		$(this).css("background", "#fdfdfd");
		$(".board:first").css("background", "#dddddd");
	});
	
	$("#allcheck").click(function(){
	    //클릭되었으면
	    if($("#allcheck").prop("checked")){
	        //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
	        $("input[name=checkedReply]").prop("checked",true);
	        //클릭이 안되있으면
	    }else{
	        //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
	        $("input[name=checkedReply]").prop("checked",false);
	    }
	});
	
	$("#frm").submit(function(){
		if(!$("input[name=checkedReply]").is(":checked")){
			alert("삭제할 댓글을 선택해 주세요");
			return false;
		}
		return true;
	});
});
$.ajax({
	type:'POST',
	url: '${pageContext.request.contextPath}/mainBoard',
	success: function(data){
		var arr = eval('('+data+')');
		var length = arr.length < 5 ? arr.length : 5;
		str = '<table class="table table-hover text-center">';
		for(i = 0; i < length; i++){
			str += '<tr>';
			str += '<td class="text-left" style="max-width: 100px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">';
			str +=	'<a href="${pageContext.request.contextPath}/boardRead?brdno='+arr[i].brdno+'&brddate='+arr[i].brddate+'&brdhit='+arr[i].brdhit+'">' + arr[i].title + '</a></td>';
			str += '<td width="65px;">' + arr[i].brddate.slice(5) + '</td>';
			str += '</tr>';
		}
		str += "</table>";	
		$('#manin_board').html(str);
	}
});


$(document).ready(function(){
	
	$.ajax({
		type:"POST",
		url:"${pageContext.request.contextPath}/commuting/getNowStatus",
		success:function(data){
			try{
				var obj = JSON.parse(data);		
			}catch(Exception){
				return;
			}
			
			if(obj.commuting_arrive != null){
				$('#arrTime').val('arrive');
				$('#arrTime').empty();
				$('#arrTime').css('color','yellow').css('font-size','20px').text(obj.commuting_arrive);
			}
			if(obj.commuting_leave != null){
				$('#leavTime').empty();
				$('#leavTime').css('color','DarkBlue').css('font-size','20px').text(obj.commuting_leave);
			}
			
			return;
		}// success end
	});// ajax end
	
	$("#arrive").click(function(){
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
			url : "${pageContext.request.contextPath}/startTime",
			type : 'post',
			data : { 	
						com_start,
						com_end,
						msg,
						emp_num,
						com_date,
						com_num,
						
					},
			dataType : 'json'
		}); 
	});	//arrive end
	
$("#leave").click(function(){
		
		if(confirm('정말 퇴근처리 하시겠습니까?')){
		
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
				url : "${pageContext.request.contextPath}/findTime",
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
	}); // leave end
	
})//ready end
</script>

<script type="text/javascript">
$(document).ready(function(){	
	var param = "year=${ year }";
	$.ajax({
		type:"POST",
		url:"${pageContext.request.contextPath}/commuting/allView",
		data:param,
		success:function(data){
			var arr = JSON.parse(data);
			//console.log(arr);

			google.charts.load("current", {packages:["calendar"]});
			google.charts.setOnLoadCallback(drawChart);
			
			function drawChart() {
			 var dataTable = new google.visualization.DataTable();
			 dataTable.addColumn({ type: 'date', id: 'Date' });
			 dataTable.addColumn({ type: 'number', id: 'Won/Loss' });
			 //dataTable.addColumn({ type: 'string', role:'tooltip' });

			for(var i = 0; i < arr.length; i++){			
				
				//console.log(arr[i].commuting_status);
				var num = parseInt(arr[i].commuting_status_date.substring(0,2));
				var status = 0;
				try{
					var arrive = new Date("2019-02-01 "+arr[i].commuting_arrive.slice(2));
					var leave = new Date("2019-02-01 "+arr[i].commuting_leave.slice(2));
					var ontime = new Date("2019-02-01 09:00:00");
					
					var gap1 = arrive.getTime() - ontime.getTime();
					var gap2 = leave.getTime() - arrive.getTime();
					if (gap1 > 0){
						status = Math.floor(0-gap1/1000/60/60);
					} else if (gap2 > 0){
						status = Math.floor(gap2/1000/60/60);
					}					
				}catch(Exception){}				
				
				dataTable.addRows([
				     [ new Date(new Date().getFullYear(), arr[i].month-1, parseInt(arr[i].commuting_status_date.substring(0,2))), status],
				   ]);
				
			}//for end	
			
			var chart = new google.visualization.Calendar(document.getElementById('calendar_basic'));
			
			 var options = {
			   title: "근무 현황",
			   height: 200,
			   calendar: {
				   cellSize: 15,
				      underYearSpace: 10, // Bottom padding for the year labels.
				      yearLabel: {
				        fontSize: 28,
				      }
				    }
			 };
			 chart.draw(dataTable, options);
			}
		}
	}); // ajax end
}) // ready end
</script>

<!-- fullcalendar ref -->
<link rel='stylesheet' href='${pageContext.request.contextPath}/resources/fullcalendar/fullcalendar.css' />
<script src='${pageContext.request.contextPath}/resources/fullcalendar/lib/moment.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/fullcalendar/fullcalendar.js'></script>
<script src='${pageContext.request.contextPath}/resources/fullcalendar/lang/ko.js'></script> 


             <!-- ======================================================================================================================================================================메인캘린더 -->

         <script type="text/javascript">
         
         var events_array = [];
         var temp = []; 
         
         $(document).ready(function(){
            
             console.log("캘린더 제작 시작");
             // We will refer to $calendar in future code
             var $calendar = $("#calendar").fullCalendar({ //start of options
                 //weekends : false, // do not show saturday/sunday
                 header: false,
                 // Make possible to respond to clicks and selections
                 selectable: false,
                 // allow "more" link when too many events
                 eventLimit: true,
                 navLinks: false,
                 // Make events editable, globally
                 editable: false,
                 resizeable: false,
                 defaultView: 'listWeek',
                 height: 245,
                 
               //Drop =================================
                 eventDrop: function(event, delta, revertFunc) {
                    
                 },
                 
                 eventResize: function(event, delta, revertFunc) {
                    
                 },
                 //This is the callback that will be triggered when a selection is made
                 eventRender: function(event, element, view) {
                 
                 },
                 select: function(start, end, jsEvent, view) {
                    
                 }, // End callback eventClick
                 events: events_array
               } //End of options
             
           );// calendar end
            
            
            var member_id = '${emp.emp_num}';
            console.log("member_id->" + member_id);
            $.ajax({
                 type: 'POST',
                 url: "${pageContext.request.contextPath}/searchAll",
                 data: "emp_num="+member_id,
                 success: function(data) {    
                     var list = data;
                     console.log(list);
                     for(var i = 0 ; i<list.length; i++){
                        var start = new Date(list[i].start);
                        var end = new Date(list[i].fin);
                        
                        var row = printCal(list[i]);
                        
                        if((end-start)%86400000 == 0){
                           row.allDay = true
                        }
                        
                        console.log(list[i].id)
                        temp.push(list[i].id);
                        
                        $('#calendar').fullCalendar('addEventSource', [{
                             id: list[i].id,
                             title: list[i].title,
                             start: list[i].start,
                             end: list[i].fin,
                             content: list[i].content,
                             allDay: list[i].allDay
                         }]);
                     } //for end
                 }
            })//ajax end
            
         }) //ready end
         
         
         
         function printCal(obj){
              if(obj.allDay == 0){
                   var event = {
                           id: obj.id+"",
                           title: obj.title+"",
                           content: obj.content+"",
                           start: moment(obj.start),
                           end: moment(obj.fin)
                   };
              
            }else{
                  var event = {
                         id: obj.id+"",
                           title: obj.title+"",
                           content: obj.content+"",
                           start: moment(obj.start).format(),
                           end: moment(obj.fin).format(),
                          allDay: true
                  };
             }
              
              return event;
           }// printCal end
           

           
           var emp_num = ${sessionScope.empForSearch.emp_num}
     	  $.ajax({
               type	: 'POST',
               url	: "${pageContext.request.contextPath}/getVacation",
               data 	: {
             	  		emp_num
              			 },
              dataType : 'json',
               success: function(vacatcion) {
     				console.log(vacatcion);
                   // Call the "updateEvent" method
                   
                   $('#mainleftVacat').text(vacatcion.va_stock);
                   
               }
             });
         
         
           $.ajax({
               type: 'POST',
               url: "${pageContext.request.contextPath}/calendar/calCount",
               success: function(data) {    
                  
                  $('#calCount3').text(data);
                      
                  }
          })//ajax end
           
           
         </script>

             <!-- ======================================================================================================================================================================메인캘린더 -->

</head>

<body id="page-top">



        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h2 class="h3 mb-0 text-gray-800">환영합니다 ${emp.emp_name}님!</h2>
            
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">결재대기중 문서</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">(<span id="apvCount4">0</span>)</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-pen-nib fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">미확인 메일</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">(<span id="main_email_count">0</span>)</div>
                    </div>
                    <div class="col-auto">
                      <!-- <i class="fas fa-dollar-sign fa-2x text-gray-300"></i> -->
                      <i class="fas fa-envelope fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">오늘의 일정</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">(<span id="calCount3"></span>)</div>
                        </div>
                        
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar-alt fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

						
            <!-- Pending Requests Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">남은 휴가</div>
                    
                      <div class="h5 mb-0 font-weight-bold text-gray-800">(<span id="mainleftVacat">0</span>일)</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-paper-plane fa-2x text-gray-300"></i>
                </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Content Row -->

          <div class="row">

          
            <!-- 1번카드 공지사항 -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- 1번 상단바 -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary"><a href=${pageContext.request.contextPath}/board/checkList?brd_type=6>공지사항</a></h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                  </div>
               
        </div>
                <!-- Card Body -->
         <div id="manin_board" class="card-body">
	          <table  class="table table-condensed" >
			   		<thead  align="center">
			   		<tr>
			   			<th width="18%">글번호</th>
			   			<th width="70%;">제목</th>
			   			<th>작성일</th>
			   		</tr>
			   		</thead>
		   		<tbody id="tbody" align="center">
		   		<!-- js로 body 구현 -->
		   		</tbody>
		   </table> 
		                           
       </div>
     </div>
   </div>
          
          
           <!-- 2번카드 일정관리  -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- 1번 상단바 -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">주간일정</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header">일정관리:</div>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/user/showCalendar">월간일정확인</a>
                     
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
         <div class="card-body">
                               
                 
                    <!-- The calendar container -->
                  <div id="calendar"></div>
                   
                  </div>
                </div>
              </div>
              
          
            <!-- 3번카드 근태관리 -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- 출결버튼 상단바 -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">출결확인</h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header">근태 관련:</div>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/user/commute">월간 근태확인</a>
                    
                    </div>
                  </div>
                </div>
                <!-- Card Body -->
         <div class="card-body">
                               
                 <div class="timecheck">
                  <div class="card bg-primary text-white shadow">
                    <div class="card-body">
                      <div align="center" id="current_time"></div>
                      <div class="text-white-50 small" align="center">대한민국 GMT+9</div>
                    </div>
                  </div>
                </div>
                 
                 <input type="hidden" id="commuting_member_id" value="${emp.emp_num}"/>
                   
                   <div class="timecheck">
                      <div id="arrive" style="width:100%;" class="card bg-info text-white shadow btn-outline-info">
                    <div class="card-body" align="center" style="cursor:pointer;" id="arrTime">
                   		  출근체크
                      <div class="text-white-50 small" align="center" >9시 이전에 체크해주세요!</div>
                    </div>
                  </div>
                </div>
                
               	<div class="timecheck">
                  <div  id="leave" style="width:100%;" class="card bg-warning text-white shadow btn-outline-warning">
                   <div class="card-body" align="center" style="cursor:pointer;" id="leavTime">
               		       퇴근체크
                      <div class="text-white-50 small" align="center">6시 이후에 체크해주세요!</div>
                    </div>
                  </div>
                </div>
                
                   
                  </div>
                </div>
              </div>
            </div>
            
          
                      
          </div> <!-- 컨텐츠플루이드 -->
          
          
          
        
     


  <!-- Page level plugins -->
  <script src="${pageContext.request.contextPath}/resources/vendor/chart.js/Chart.min.js"></script>

<%--   <!-- Page level custom scripts -->
  <script src="${pageContext.request.contextPath}/resources/js/chart-area-demo.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/chart-pie-demo.js"></script>
   --%>
  
  <script type="text/javascript">
  $(function(){  // 게시글 목록 불러오기
		getBoardList(1,'recent');
	})
	
	function leadingZeros(n, digits) { // 날짜 변환 함수
	    var zero = '';
	    n = n.toString();

	    if (n.length < digits) {
	        for (i = 0; i < digits - n.length; i++)
	            zero += '0';
	    }
	    return zero + n;
	}
	
  function getBoardList(currentPage,arrayType){ // 게시글 목록 출력
		 $.ajax({
	        url:'/board/ajaxCheckList',
	        type:'GET',
	        data: {"brd_type":6,"currentPage":currentPage,"searchType":'W',"keyword":'',"arrayType":arrayType},
	        dataType:'JSON',
	        success : function(data){
	        	/* alert("목록조회 성공"); */
	            console.log(data); // ajax 데이터 확인용
	        	brdListStr ="";
	        	$(data.brdCheckList).each(function(){
	        		var date=this.brd_date;
	        		var formatDate=date.substr(0,10);
	        		var now = new Date();
	        		
	        		if(formatDate){
	        			 now = 
        				    leadingZeros(now.getFullYear(), 4) + '-' +
        				    leadingZeros(now.getMonth() + 1, 2) + '-' +
        				    leadingZeros(now.getDate(), 2);
	        			 	console.log(now);
       			   if(formatDate == now){
       				    formatDate=date.substr(10,12);
       				  }	 
	        		}
	        		brdListStr+="<tr>";
	        		brdListStr+="<td>"+this.rn+"</td>";
	        		brdListStr+="<td><a href='/board/detail?emp_num="+this.emp_num+"&brd_type="+this.brd_type+"&brd_num="+this.brd_num+"'>";
	        		brdListStr+=this.brd_title+"</a></td>";
	        		brdListStr+="<th>"+formatDate+"</th>";
	        		brdListStr+="</tr>";
	        		if(this.rn==4){
	        			return false;
	        		}
	        	});
	        	$('#tbody').html(brdListStr);
	        }, 
	     	error:function(request,status,error){
	            alert('code = '+ request.status + ' message = ' + request.responseText + ' error = ' + error); // 실패 시 처리
	        },
	        complete : function(data){
				
	        }
	    });
	}
  </script>

</body>

</html>
