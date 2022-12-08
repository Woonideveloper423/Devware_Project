<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link href="${pageContext.request.contextPath}/resources/css/chat/chat-room.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/css/chat/chatting.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/css/chat/friend.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/css/chat/general.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/css/chat/main-layout.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/css/chat/more_menu.css" rel="stylesheet"/>
<script src="https://kit.fontawesome.com/f7fe0761ae.js" crossorigin="anonymous"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	

	$(function(){
		
		getMsgCnt();
		console.log("wsOpen  location.host: " + location.host);
	    var wsUri  = "ws://" + location.host + "${pageContext.request.contextPath}/chating";
	    // WebSocket 프로토콜을 사용하여 통신하기 위해서는 WebSocket객체를 생성. 
	    // 객체는 자동으로 서버로의 연결
	 	ws = new WebSocket(wsUri);
		wsEvt();
		console.log("소켓연결은 되나?");
		$(document).on("click",".save_attach", function(){
			//save_attach($(this).attr('id'),$(this).attr('name'));
			location.href = '/saveAttach?saveName='+ $(this).attr('id') + "&realName=" + $(this).attr('name');
		});
		
		$(document).on("click","#addRoom", function(){
			$('#roomlist').hide();
			showEmpList(1);
		});
		$(document).on("click","#showMember", function(){
			$('#detailRoom').hide();
			showEmpList(2);
		});
		$(document).on("click","#leaveRoom", function(){
			var userOption ={
					type       : "LEAVE", 
					roomId  : $("#chattingRoomId").val(),
					sender : '${testEmpno}',
					senderName : '${testEname}'
			}
			console.log("leaveRoom Start..")  	
			// 자바스크립트의 값을 JSON 문자열로 변환
			// Client --> Server
			ws.send(JSON.stringify(userOption));
			$('#detailRoom').empty($("#chattingRoomId").val());
		});
		$(document).on("click","#inviteMember", function(){
			$('#detailRoom').hide();
			showEmpList(3);
		});
		
		$(document).on("click","#inviteBtn", function(){
			var emp_nums = [];
			var emp_names = [];
			console.log($("#roomName").val());
			
			$('.checked').each(function(){
				emp_nums.push($(this).attr("id"));
				emp_names.push($(this).attr("name"));
			});
			if(emp_nums.length !=0){
				console.log(emp_nums);
				console.log(emp_names);
				var userOption ={
					type       : "INVITE", 
					roomId  : $("#chattingRoomId").val(),
					sender : '${testEmpno}',
					senderName : '${testEname}',
					empNums   : emp_nums,
					empNames   : emp_names
					
				}
				console.log("INVITE Start..")  	
				// 자바스크립트의 값을 JSON 문자열로 변환
				// Client --> Server
				ws.send(JSON.stringify(userOption));
				
			}else{
				alert("한명 이상의 인원을 선택해 주세요");
			}
		});
		$(document).on("click","#sendBtn", function(){
			sendMessage();
		});
		
		$(document).on("click","#cancleBtn", function(){
			$('#empList').empty();
			$('#detailRoom').empty();
			$('#roomlist').show();
		});
		
		$(document).on("click","#cancleLookBtn", function(){
			leaveLookRoom();
			$('#empList').empty();
			$('#detailRoom').empty();
			$('#roomlist').show();
		});
		
		$(document).on("click","#chattingsDropdown", function(){
			if($("#chatContainer").attr("aria-expanded") == true){
				console.log("채팅리스트닫기")
				leaveLookRoom();
				$("#chatContainer").empty();
			}else{
				console.log("채팅리스트열기")
				getRoomList();
			}
		});
		
		$(document).on("click","#openSendFile", function(){
			if($(this).val() == "파일 보내기"){
				$("#openSendFile").val("취소");
				$("#sendMsg").attr("disabled", true);
				var str = "";
				/* str +="<form id='uploadFileForm' enctype='multipart/form-data'>"; */
				str += "<input type='file' id='inputFile'>";
				$("#uploadContainer").html(str);
			}else{
				$(this).val("파일 보내기");
				$("#sendMsg").attr("disabled", false);
				$("#uploadContainer").empty();
			}
		});
		
		$(document).on("click","#makeRoomBtn", function(){
			/* ws.close();
			wsEvt();
			alert("종료됬나?");
			$("#addForm").submit(); */
			var emp_nums = [];
			var emp_names = [];
			console.log($("#roomName").val());
			
			$('.checked').each(function(){
				emp_nums.push($(this).attr("id"));
				emp_names.push($(this).attr("name"));
			});
			if(emp_nums.length !=0){
				emp_nums.push('${testEmpno}');
				console.log(emp_nums);
				console.log(emp_names);
				var userOption ={
					type       : "CREATE", 
					roomName  : $("#roomName").val(),
					sender : '${testEmpno}',
					senderName : '${testEname}',
					empNums   : emp_nums,
					empNames   : emp_names
					
				}
				console.log("createRoom Start..")  	
				// 자바스크립트의 값을 JSON 문자열로 변환
				// Client --> Server
				ws.send(JSON.stringify(userOption));
			}else{
				alert("한명 이상의 인원을 선택해주세요");
			}
		});
		
		
		$(document).on("click",".unchecked", function(){
			$(this).removeClass("unchecked").addClass("checked");
		    $(this).children().removeClass("fa-regular").addClass("fa-solid");
		});
		
		$(document).on("click",".checked", function(){
			$(this).removeClass("checked").addClass("unchecked");
			$(this).children().removeClass("fa-solid").addClass("fa-regular");
		});
		
		$(document).on("click",".roomEnter", function(){
			$('#roomlist').hide();
			console.log($(this).attr("id"));
			/* ws.close();
			wsEvt();
			alert("종료됬나?");
			$(this).submit(); */
			/* var userOption ={
				type       : "CONNECT",
				roomId  : $(this).attr("id"),
				sender : '${testEmpno}'
			}
			alert("채팅방 접속")  	
			// 자바스크립트의 값을 JSON 문자열로 변환
			// Client --> Server
			ws.send(JSON.stringify(userOption)); */
			detailRoom($(this).attr("id"), $(this).attr("name"));
			$("#count"+ $(this).attr("id")).html(0);
		});
		
		
		
	});
	
	function sendMessage(){
		if($("#openSendFile").val() == "취소"){
			var inputFile = $('#inputFile')[0].files[0];
            var formData = new FormData();
            console.log(inputFile);
            var fileValue = $("#inputFile").val().split("\\");
            var fileName = fileValue[fileValue.length-1]; // 파일명
            formData.append("upLoadFile", inputFile);
			
            $.ajax({
                url: '/chat/uploadFile',
                processData: false,
                contentType: false,
                data: formData,
                type: 'POST',
                dataType:'Text',
                success: function(data){
                	var userOption ={
        					type       : "TALK", 
        					roomId  : $("#chattingRoomId").val(),
        					sender : '${testEmpno}',
        					senderName : '${testEname}',
        					showType : '1',
        					attachName : data,
        					message : fileName
        				}
        				console.log("AttachMessage Start..");
        			ws.send(JSON.stringify(userOption));
                }
            });
		}else{
			var userOption ={
					type       : "TALK", 
					roomId  : $("#chattingRoomId").val(),
					sender : '${testEmpno}',
					senderName : '${testEname}',
					showType : '0',
					message : $("#sendMsg").val()
				}
				console.log("plainMessage Start..");	
				// 자바스크립트의 값을 JSON 문자열로 변환
				// Client --> Server
				ws.send(JSON.stringify(userOption));
		}
	}
	
	function leaveLookRoom(){
		if($("#chattingRoomId").val() != null){
			$.ajax(
					{
						url:"/chat/leaveRoomLook",
						data:{"empno" : '${testEmpno}',
							  "roomId"  : $("#chattingRoomId").val()},
						dataType:'text',
						success:function(data){
							
						}
					}		
			);
		}
	}
	
	function showEmpList(empType) {
			$.ajax(
					{
						url:"/chat/showEmpList",
						data:{"emp_num" : '${testEmpno}',
							  "room_num" : $("#chattingRoomId").val(),
							  "type" : empType},
						dataType:'json',
						success:function(data){
							var str = "";
							if(data.type == "1"){
								str += "<input type='text' id='roomName' placeholder='채팅방 이름을 입력해 주세요'><p>";
								str += "<input type='button' id='cancleBtn' value='뒤로가기'><p>";
								str += "<input type='button' id='makeRoomBtn' value='생성'><p>";
								$(data.empDtos).each(function(){
									str += "<div class='unchecked' id='" + this.emp_num +"' name = '" + this.emp_name +"'>";
									str += this.emp_name + "<i class='fa-regular fa-circle-check'></i>";
									str += "</div>";
								});
							
							}else if(data.type == "2"){
								str += "<div>참여 인원</div>";
								str += "<input type='button' id='cancleBtn' value='뒤로가기'><p>";
								$(data.empDtos).each(function(){
									str += "<div id='" + this.emp_num +"' name = '" + this.emp_name +"'>";
									str += this.emp_name;
									str += "</div>";
								});
							
							}else{
								str += "<input type='text' id='roomName' placeholder='초대할 인원을 선택해 주세요'><p>";
								str += "<input type='button' id='cancleBtn' value='뒤로가기'><p>";
								str += "<input type='button' id='inviteBtn' value='초대'><p>";
								$(data.empDtos).each(function(){
									str += "<div class='unchecked' id='" + this.emp_num +"' name = '" + this.emp_name +"'>";
									str += this.emp_name + "<i class='fa-regular fa-circle-check'></i>";
									str += "</div>";
								});
							
							}
							$("#empList").html(str);
						}
					}		
			);
			
			
		
	}
	
	function getMsgCnt() {
		$.ajax(
				{
					url:"/chat/getMsgCnt",
					data:{"empno" : '${testEmpno}'},
					dataType:'text',
					success:function(data){
						$('#msgCnt').html(data);
					}
				}		
		);
	}
	
	function detailRoom(roomNum, roomName) {
		$.ajax(
				{
					url:"/chat/detailRoom",
					data:{"p_room_num" : roomNum,
						  "p_emp_num" : '${testEmpno}'},
					dataType:'json',
					success:function(data){
						var readMsgs = [];
						$(data.readMsg).each(function(){
							readMsgs.push(this);
						});
						console.log(readMsgs);
						if(readMsgs.length!=0){
							 var userOption ={
								type   : "CONNECT",
								roomId : roomNum,
								sender : '${testEmpno}',
								readMsgs : readMsgs
							}
							console.log("채팅방 접속")  	
							// 자바스크립트의 값을 JSON 문자열로 변환
							// Client --> Server
							ws.send(JSON.stringify(userOption)); 
						}
						
						var str ="";
						str += "<h1>"+ roomName + "</h1>";
						str += "<input type='hidden' id='chattingRoomId' value='" + data.p_room_num +"'>";
						str += "<input type='button' id='cancleLookBtn' value='뒤로가기'>";
						str += "<input type='button' id='showMember' value='참여자 목록'>";
						str += "<input type='button' id='leaveRoom' value='방 나가기'>";
						str += "<input type='button' id='inviteMember' value='초대하기'>";
						str += "<div id='chatting' class='chatting'>";
						$(data.chatMessageDtos).each(function(){
							if(this.msg_type == "1"){
								if(this.emp_num == '${testEmpno}'){
									str += "<div class = 'me'>안 읽은 수:<div id='msgCnt" + this.log_num +"'>" + this.not_read_cnt + "</div>" + this.member_name + " : " + this.msg_content + "<br>" + this.send_date +"<input class='save_attach' type='button' value='첨부다운' id='" + this.attach_name + "' name='"+ this.msg_content +"'></div>";
								}else{
									str += "<div class = 'others'>안 읽은 수:<div id='msgCnt" + this.log_num +"'>" + this.not_read_cnt + "</div>" + this.member_name + " : " + this.msg_content + "<br>" + this.send_date + "<input class='save_attach' type='button' value='첨부다운' id='" + this.attach_name + "' name='"+ this.msg_content +"'></div>";
								}
							}else if(this.msg_type == "2"){
									str += "<div class = 'notice'>안 읽은 수:<div id='msgCnt" + this.log_num +"'>" + this.not_read_cnt + "</div>" + this.member_name + " : " + this.msg_content + "<br>" + this.send_date +"</div>";

							}else{
								if(this.emp_num == '${testEmpno}'){
									str += "<div class = 'me'>안 읽은 수:<div id='msgCnt" + this.log_num +"'>" + this.not_read_cnt + "</div>" + this.member_name + " : " + this.msg_content + "<br>" + this.send_date +"</div>";
								}else{
									str += "<div class = 'others'>안 읽은 수:<div id='msgCnt" + this.log_num +"'>" + this.not_read_cnt + "</div>" + this.member_name + " : " + this.msg_content + "<br>" + this.send_date + "</div>";
								}
							}
						});
						str += "</div>";
						str += "<input type='button' id='openSendFile' value='파일 보내기'>";
						str += "<input id='sendMsg' placeholder='보내실 메시지를 입력하세요.'>"
						str += "<input type='button' id='sendBtn' value='보내기'>";	
						str += "<div id='uploadContainer'></div>";
						$("#detailRoom").html(str);
					}
				}		
		);
	}
	
	function getRoomList() {
		$.ajax(
				{
					url:"/chat/getRoomList",
					data:{"empno" : '${testEmpno}'},
					dataType:'json',
					success:function(data){
						var str ="";
						str += "<div class='icon-circle bg-primary' id='addRoom'>+</div>"
						console.log(str);
						/* str += "<input type='button' id='addRoom' value='채팅방 추가'>";*/						
						$(data).each(function(){
							console.log("리스트 조회 성공" + this.room_num);
							/* str =  "<p><form action='roomDetail' id='frm" + this.room_num +"' class='roomEnter'>";
							str += "<input type='hidden' name='roomId' value='"+ this.room_num +"'>";
							str += "<input type='hidden' name='roomName' value='"+ this.room_title +"'>";
							str += this.room_title + "<div id='content"+ this.roomId +"'>" +this.last_sender + " : " + this.last_msg + "(" + this.last_msg_date + ")</div>";
							str += "<div id='count"+ this.room_num +"'>"+ this.not_read_cnt +"</div>";
							str += "</form></p>" */
							
							str +=  "<div id='"+ this.room_num +"' name='"+ this.room_title +"' class='roomEnter'>";
							str += "방제목 :" + this.room_title + "<div id='content"+ this.room_num +"'>" +this.last_sender + " : " + this.last_msg + "(" + this.last_msg_date + ")</div>";
							str += "안 읽은 메세지 수 : <div id='count"+ this.room_num +"'>"+ this.not_read_cnt +"</div>";
							str += "</div>";
						});
						$("#roomlist").append(str);
					}
				}		
		);
	} 
	
	function  makeRoomList(data) {
		
	}
	
	function  wsEvt() {
		console.log("wsEvt  start... ");
        //alert("wsEvt  start...")    
        
        //소켓이 열리면 동작
		ws.onopen = function(data){
			console.log("wsEvt  소켓이 열리면 초기화 세팅하기..");
		}	
        ws.onclose = function(data){
        	console.log("세션 끊김 다시연결하자");
        }
        ws.onmessage = function(data) {
			var msg = data.data;
			var memberSave = false;
			console.log("ws.onmessage->"+msg)
			if(msg != null && msg.trim() != ''){
				memberSave = false;
				// JSON 오브젝트를 자바스크립트 오브젝트로 변환
			    var jsonMsg = JSON.parse(msg);
				// msg가 배열이고, 2개이상의 Count이면 , member 등록 대상 
                if (Array.isArray(jsonMsg)) {
                	if (Object.keys(jsonMsg).length > 1) {
                    	memberSave = true;
                       	alert("JSONArray jsonMsg Count->"+ Object.keys(jsonMsg).length);
                	}
                }			
			}
			console.log(jsonMsg.type);
			console.log(jsonMsg.message);
			console.log(jsonMsg.roomId);
			// 파싱한 객체의 type값을 확인하여 getId값이면 초기 설정된 값이므로 채팅창에 값을 입력하는게 아니라
			// 추가한 태그 sessionId에 값을 세팅
			if(jsonMsg.type == "CREATE"){
				if(jsonMsg.sender == '${testEmpno}'){
					var str ="";
					str += "<h1>"+ $("#roomName").val() + "</h1>";
					str += "<input type='hidden' id='chattingRoomId' value='" + jsonMsg.roomId +"'>";
					str += "<input type='button' id='cancleBtn' value='뒤로가기'>";
					str += "<input type='button' id='showMember' value='참여자 목록'>";
					str += "<input type='button' id='leaveRoom' value='방 나가기'>";
					str += "<input type='button' id='inviteMember' value='초대하기'>";
					str += "<div id='chatting' class='chatting'>";
					str += "<div class = 'notice'>안 읽은 수:<div id='msgCnt" + jsonMsg.logNum +"'>" + (parseInt(jsonMsg.memberCnt)-1) + "</div>" + jsonMsg.sender_name + " : " + jsonMsg.message + "<br>" + new Date() +"</div>";
					str += "</div>";
					str += "<input type='button' id='openSendFile' value='파일 보내기'>";
					str += "<input id='sendMsg' placeholder='보내실 메시지를 입력하세요.'>"
					str += "<input type='button' id='sendBtn' value='메세지 보내기'>";	
					str += "<div id='uploadContainer'></div>";
					$('#roomlist').hide();
					$('#empList').empty();
					$("#detailRoom").html(str);
				}else{
					str =  "<div id='"+ jsonMsg.roomId +"' name ='" + jsonMsg.roomName +"' class='roomEnter'>";
					str += "방제목 :" + jsonMsg.roomName + "<div id='content"+ jsonMsg.roomId +"'>" +jsonMsg.sender_name + " : " + jsonMsg.message + "(" + new Date() + ")</div>";
					str += "안 읽은 메세지 수 : <div id='count"+ jsonMsg.roomId +"'>1</div>";
					str += "</div>";
					$("#roomlist").prepend(str);
				}
			}else if(jsonMsg.type == "TALK" || jsonMsg.type == "LEAVE" || jsonMsg.type == "INVITE"){
				if($("#chattingRoomId").val() != jsonMsg.roomId){
					$('#msgCnt').html(parseInt($('#msgCnt').html())+1);
					var readCount = parseInt($("#count"+ jsonMsg.roomId).html()) + 1;
					console.log(readCount);
					$("#content"+ jsonMsg.roomId).html(jsonMsg.sender_name + " : " + jsonMsg.message);
					$("#count"+ jsonMsg.roomId).html(readCount);
				}else{
					if(jsonMsg.showType == "1"){
						var str = "";
						if(jsonMsg.sender == '${testEmpno}'){
							str += "<div class = 'me'>안 읽은 수:<div id='msgCnt" + jsonMsg.logNum +"'>" + jsonMsg.notReadCnt + "</div>" + jsonMsg.sender_name + " : " + jsonMsg.message + "<br>" + new Date() +"<input class='save_attach' type='button' value='첨부다운' id='" + jsonMsg.attachName + "' name='"+ jsonMsg.message +"'></div>";
						}else{
							str += "<div class = 'others'>안 읽은 수:<div id='msgCnt" + jsonMsg.logNum +"'>" + jsonMsg.notReadCnt + "</div>" + jsonMsg.sender_name + " : " + jsonMsg.message + "<br>" + new Date() + "<input class='save_attach' type='button' value='첨부다운' id='" + jsonMsg.attachName + "' name='"+ jsonMsg.message +"'></div>";
						}
					}else if(jsonMsg.showType == "2"){
						var str = "";
						str += "<div class = 'notice'>안 읽은 수:<div id='msgCnt" + jsonMsg.logNum +"'>" + jsonMsg.notReadCnt + "</div>" + jsonMsg.message + "<br>" + new Date() + "</div>";
					}else{
						var str = "";
						if(jsonMsg.sender == '${testEmpno}'){
							str += "<div class = 'me'>안 읽은 수:<div id='msgCnt" + jsonMsg.logNum +"'>" + jsonMsg.notReadCnt + "</div>" + jsonMsg.sender_name + " : " + jsonMsg.message + "<br>" + new Date() +"</div>";
						}else{
							str += "<div class = 'others'>안 읽은 수:<div id='msgCnt" + jsonMsg.logNum +"'>" + jsonMsg.notReadCnt + "</div>" + jsonMsg.sender_name + " : " + jsonMsg.message + "<br>" + new Date() + "</div>";
						}
					}
					$("#chatting").append(str);
				}
			}else if(jsonMsg.type == "CONNECT"){
				if(jsonMsg.sender != '${testEmpno}'){
					$(jsonMsg.readMsg).each(function(){
						var readCount = parseInt($("#msgCnt"+ this).html()) - 1;
						console.log(readCount);
						$("#msgCnt"+ this).html(readCount);
					});
				}
			}
		}
	}
	
	/* 미결재 알림 */
	$.ajax({
		type:'POST',
		url: '${ pageContext.request.contextPath }/approval/notAuthApvCount',
		success: function(data){
			//console.log(data);
			$('#apvCount2').text(data);
			$('#apvCount3').text(data);
		}
	})
	$.ajax({
		type:"POST",
		url:"${ pageContext.request.contextPath }/email/count",
		success:function(data){
			$("#email_count").html(data);
			$("#menu_email_count").html(data);
			$("#main_email_count").html(data);
			$("#header_email_count").html(data);
			$("#header_email_count2").html(data);
		}
	});
	setInterval('email()', 30000)

	function email(){
		if($("#emp.emp_num").val() == "") {
			$(location).attr("href", "/logoutForm");
		}
		$.ajax({
			type:"POST",
			url:"${ pageContext.request.contextPath }/email/pop3",
			success:function(data){
				$("#email_count").html(data);
				$("#menu_email_count").html(data);
				$("#main_email_count").html(data);
				$("#header_email_count").html(data);
				$("#header_email_count2").html(data);
			}
		});
	}
	$(document).ready(function() {
		if($("#emp.emp_num").val() == "") {
			$(location).attr("href", "/logoutForm");
		}
	});
	
	
</script>


</head>
<body>
<input type="hidden" id="header_member_id" value="${sessionScope.member.member_id}"/>
 <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow" style="margin-bottom:0rem !important;">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>
          
		  <div><a href="/auth_finder"><img id="main_file_img" src="${pageContext.request.contextPath}/resources/img/icon.png" alt="사진"  height="60px"></a></div>
	        
          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">
			
        <!-- Nav Item - Chatting -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="chattingsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fa-solid fa-comments"></i>
                <!-- 안읽은 메세지 수 -->
                <span class="badge badge-danger badge-counter"><span id="msgCnt"></span></span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="chattingsDropdown">
                <h6 class="dropdown-header">
                  채팅방 목록
                </h6>
                 	<div id="chatContainer" class="d-flex align-items-center" style="overflow:auto; height:500px;">
                 		<div id='empList'></div>
						<div id='detailRoom'></div>
						<div id='roomlist' style="position: relative;"></div>
					</div>
              </div>
            </li>
    

            <!-- Nav Item - Alerts -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                <!-- 미결재 알람 -->
                <span class="badge badge-danger badge-counter"><span id="apvCount2"></span></span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                  미결재 알림
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-primary">
                      <i class="fas fa-file-alt text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">미결제 알람</div>
                    <span class="font-weight-bold">미결제 문서가(<strong id="apvCount3"></strong>)건 있습니다.<br>확인해주세요! </span>
                  </div>
                </a>
                
                <a class="dropdown-item text-center small text-gray-500" href="${pageContext.request.contextPath}/approval/notAuthApvList?page=1">문서함으로 가기</a>
              </div>
            </li>

            <!-- Nav Item - Messages -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Messages -->
                <span class="badge badge-danger badge-counter"> <span id="header_email_count"></span> <!-- 숫자가 들어갈 공간 -->  </span>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
                <h6 class="dropdown-header">
                  새로운 메일
                </h6>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="dropdown-list-image mr-3">
                   <div class="icon-circle bg-primary">
                <i class="far fa-envelope text-white"></i>
                   
 				</div>
                    
                  </div>
               
                  <div class="font-weight-bold">
                  <div class="small text-gray-500">확인하지 않은 메일</div>
                    <div class="text-truncate">미확인 메일이 (<span id="header_email_count2">0</span>)건 있습니다. <br> 확인해주세요!</div>
                    
                  </div>
                </a>
                
                
                
                <a class="dropdown-item text-center small text-gray-500" href="${pageContext.request.contextPath}/email/receive">받은 메일함으로 가기</a>
              </div>
            </li>

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- 유저 정보 탭 [마이페이지],[로그아웃],[이름 출력] -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${emp.emp_name}님</span>
                
                <i class="fas fa-user"></i>
              </a>
              
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
	           		<!-- 마이 페이지 [분기] 관리자 & 일반 유저 -->
	           		<c:choose>
	           			<c:when test="${emp.auth_num eq 0}">
	           				<a class="dropdown-item" href="/adminMyPageForm">
			                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>내 정보
			                </a>
			            </c:when>
			            
	           			<c:otherwise>
		           			<a class="dropdown-item" href="/userMyPageForm">
			                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>내 정보
			                </a>
	           			</c:otherwise>
	                </c:choose>
	                
	                <a class="dropdown-item" href="${pageContext.request.contextPath}/member/myboard?member_name=${sessionScope.member.member_name}">
	                  <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>내 게시글
	                </a>
                
					<!-- 로그아웃 버튼  -->
	                <div class="dropdown-divider"></div>
		            <a class="dropdown-item" data-toggle="modal" data-target="#logoutModal">
		            <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>로그아웃
		     		</a>
		     		
              </div>
            </li>

          </ul>

        </nav>
		  <!-- 로그 아웃 [모달], 로그아웃 버튼 선택시 모달 창이 나온다. 로그아웃 시에 로그인 창으로 이동한다.-->
		  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		    <div class="modal-dialog" role="document">
		      <div class="modal-content">
		        <div class="modal-header">
		          <h5 class="modal-title" id="exampleModalLabel">로그아웃하시겠습니까?</h5>
		          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
		            <span aria-hidden="true">×</span>
		          </button>
		        </div>
		        <div class="modal-body">로그아웃을 누르시면 현재 세션을 벗어나 로그인 창으로 이동합니다.</div>
		        <div class="modal-footer">
		          <button class="btn btn-outline-primary" type="button" data-dismiss="modal">돌아가기</button>
		          <a class="btn btn-outline-primary" href="/logoutForm">로그아웃</a>
		        </div>
		      </div>
		    </div>
		  </div>        
	</body>
</html>