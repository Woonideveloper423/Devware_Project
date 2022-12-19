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
$.ajax({
	type:'POST',
	url: '${ pageContext.request.contextPath }/approval/user/notAuthApvCount',
	success: function(data){
		console.log(data);
		$('#apvCount2').text(data);
		$('#apvCount3').text(data);
		$('#apvCount4').text(data);
	}
})

$(function(){
	if('${msg}' != ""){
		alert('${msg}');
	}
	console.log("empno는?" + '${empForSearch.emp_num}');
	email();
	setInterval('email()', 30000);
	getMsgCnt();
	
	console.log("wsOpen  location.host: " + location.host);
    var wsUri  = "ws://" + location.host + "${pageContext.request.contextPath}/chating";
    // WebSocket 프로토콜을 사용하여 통신하기 위해서는 WebSocket객체를 생성. 
    // 객체는 자동으로 서버로의 연결
 	ws = new WebSocket(wsUri);
	wsEvt();
	
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
				roomId  : $("#chattingRoomId").val()
		}
		console.log("leaveRoom Start..")  	
		// 자바스크립트의 값을 JSON 문자열로 변환
		// Client --> Server
		ws.send(JSON.stringify(userOption));
		/* $('#detailRoom').empty($("#chattingRoomId").val()); */
		$('#' + $("#chattingRoomId").val()).remove();

		$('#detailRoom').remove();
		
		$('#roomlist').show();
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
				roomName  : $(".profile-name").html(),
				roomId  : $("#chattingRoomId").val(),
				empNums   : emp_nums,
				empNames   : emp_names
				
			}
			console.log("INVITE Start..")  	
			// 자바스크립트의 값을 JSON 문자열로 변환
			// Client --> Server
			ws.send(JSON.stringify(userOption));
			$('#empList').remove();
			$('#detailRoom').show();
		}else{
			alert("한명 이상의 인원을 선택해 주세요");
		}
	});
	$(document).on("click","#sendBtn", function(){
		sendMessage();
	});
	
	/* $(document).on("click","#cancleBtn", function(){
		$('#empList').remove();
		$('#detailRoom').remove();
		$('#roomlist').show();
	});
	
	$(document).on("click","#cancleLookBtn", function(){
		leaveLookRoom();
		$('#empList').remove();
		$('#detailRoom').remove();
		$('#roomlist').show();
	}); */
	
	
	$(document).on("click","#openChat", function(){
		if($("#chatContainer").hasClass("chat_close")){
			console.log("채팅리스트열기")
			$("#chatContainer").removeClass("chat_close");
			getRoomList();
		}else{
			console.log("채팅리스트닫기")
			$("#chatContainer").addClass("chat_close");
			leaveLookRoom();
			$("#chatContainer").empty();
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
				type       : "CREATE", 
				roomName  : $("#roomName").val(),
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
		$('#msgCnt').html(parseInt($('#msgCnt').html())-parseInt($("#count"+ $(this).attr("id")).html()));
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
    					showType : '1',
    					attachName : data,
    					message : fileName
    				}
    				console.log("AttachMessage Start..");
    			ws.send(JSON.stringify(userOption));
            }
        });
	}else{
		
		if($("#sendMsg").val() == null || $("#sendMsg").val().trim() == ""){
			alert("메세지 내용을 입력해주세요.");
			return;
		}
		
		var userOption ={
				type       : "TALK", 
				roomId  : $("#chattingRoomId").val(),
				showType : '0',
				message : $("#sendMsg").val()
			}
			console.log("plainMessage Start..");	
			// 자바스크립트의 값을 JSON 문자열로 변환
			// Client --> Server
			ws.send(JSON.stringify(userOption));
	}
	$("#openSendFile").val("파일 보내기");
	$("#sendMsg").val("");
}

function leaveLookRoom(){
	if($("#chattingRoomId").val() == null || $("#chattingRoomId").val().trim() == ""){
		console.log("보고있는 방 없음");
	}else{
		$.ajax(
				{
					url:"/chat/leaveRoomLook",
					data:{"roomId"  : $("#chattingRoomId").val()},
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
					data:{"room_num" : $("#chattingRoomId").val(),
						  "type" : empType},
					dataType:'json',
					success:function(data){
						var str = "<div id='empList'>";
						if(data.type == "1"){
							str += "<input type='text' id='roomName' placeholder='채팅방 이름을 입력해 주세요'><p>";
							str += "<i class='fa-solid fa-arrow-left' onclick='cancelAction(3)'></i>";
							str += "<input type='button' id='makeRoomBtn' value='생성'><p><main>";
							$(data.empDtos).each(function(){
								str += "<div class='unchecked' id='" + this.emp_num +"' name = '" + this.emp_name +"'>";
								str += this.emp_name + "<i class='fa-regular fa-circle-check'></i>";
								str += "</div>";
							});
							str += "</main>"
						}else if(data.type == "2"){
							str += "<div>참여 인원</div>";
							str += "<i class='fa-solid fa-arrow-left' onclick='cancelAction(2)'></i><main>";
							$(data.empDtos).each(function(){
								str += "<div id='" + this.emp_num +"' name = '" + this.emp_name +"'>";
								str += this.emp_name;
								str += "</div>";
							});
							str += "</main>"
						}else{
							str += "<i class='fa-solid fa-arrow-left' onclick='cancelAction(2)'></i>";
							str += "<input type='button' id='inviteBtn' value='초대'><p><main>";
							$(data.empDtos).each(function(){
								str += "<div class='unchecked' id='" + this.emp_num +"' name = '" + this.emp_name +"'>";
								str += this.emp_name + "<i class='fa-regular fa-circle-check'></i>";
								str += "</div>";
							});
							str += "</main>"
						}
						str += "</div>"
						$("#chatContainer").append(str);
					}
				}		
		);
		
		
	
}

function getMsgCnt() {
	$.ajax(
			{
				url:"/chat/getMsgCnt",
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
				data:{"p_room_num" : roomNum},
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
							readMsgs : readMsgs
						}
						console.log("채팅방 접속")  	
						// 자바스크립트의 값을 JSON 문자열로 변환
						// Client --> Server
						ws.send(JSON.stringify(userOption)); 
					}
					
					var str ="<div id='detailRoom'>";
					str += "<div class='setting_bar'><input type='hidden' id='chattingRoomId' value='" + data.p_room_num +"'>";
					str += "<i class='fa-solid fa-arrow-left' onclick='cancelAction(1)'></i>";
					str += "<i id='showMember' class='fa-solid fa-users'></i>";
					str += "<i id='leaveRoom' class='fa-solid fa-right-from-bracket'></i>";
					str += "<i id='inviteMember' class='fa-solid fa-user-plus'></i></div>";
					str += "<header><span class='profile-name'>"+ roomName + "</span></header>";
					str += "<main><div class='chat-content'><div id='chatting' class='main-chat'>";
					$(data.chatMessageDtos).each(function(){
						if(this.msg_type == "1"){
							if(this.emp_num == '${empForSearch.emp_num}'){
								str += "<div class = 'me-chat'><div class='me-chat-col'><span class='balloon'>" + this.msg_content + "<input class='save_attach' type='button' value='첨부다운' id='" + this.attach_name + "' name='"+ this.msg_content +"'></span></div><div class='time'>" + this.send_date +"</div><div id='msgCnt" + this.log_num +"' class='notRead'>" + this.not_read_cnt + "</div></div>";
							}else{
								str += "<div class='friend-chat'><img class='profile-img' src='${pageContext.request.contextPath}/resources/img/chatImg.png' alt='채팅이미지'><div class = 'friend-chat-col'><span class='profile-name'>" + this.member_name + "</span><span class='balloon'>" + this.msg_content + "<input class='save_attach' type='button' value='첨부다운' id='" + this.attach_name + "' name='"+ this.msg_content +"'></span></div><div class='time'>" + this.send_date +"</div><div id='msgCnt" + this.log_num +"' class='notRead'>" + this.not_read_cnt + "</div></div>";
							}
						}else if(this.msg_type == "2"){
								str += "<div class = 'notice-chat'><div id='msgCnt" + this.log_num +"' class='notRead'>" + this.not_read_cnt + "</div>" + this.msg_content + "<br>" + this.send_date +"</div>";

						}else{
							if(this.emp_num == '${empForSearch.emp_num}'){
								str += "<div class = 'me-chat'><div class='me-chat-col'><span class='balloon'>" + this.msg_content + "</span></div><div class='time'>" + this.send_date +"</div><div id='msgCnt" + this.log_num +"' class='notRead'>" + this.not_read_cnt + "</div></div>";
							}else{
								str += "<div class='friend-chat'><img class='profile-img' src='${pageContext.request.contextPath}/resources/img/chatImg.png' alt='채팅이미지'><div class = 'friend-chat-col'><span class='profile-name'>" + this.member_name + "</span><span class='balloon'>" + this.msg_content + "</span></div><div class='time'>" + this.send_date +"</div><div id='msgCnt" + this.log_num +"' class='notRead'>" + this.not_read_cnt + "</div></div>";
							}
						}
					});
					str += "</div></div><div class='insert-content'><div id='send-content'>";
					str += "<textarea id='sendMsg' placeholder='보내실 메시지를 입력하세요.' required></textarea>"
					str += "<input type='button' id='sendBtn' class='chat-submit' value='보내기'>";
					str += "<input type='button' id='openSendFile' value='파일 보내기'>";
					str += "<div id='uploadContainer'></div></div></div></main></div>";
					$("#chatContainer").append(str);
				}
			}		
	);
}

function getRoomList() {
	$.ajax(
			{
				url:"/chat/getRoomList",
				dataType:'json',
				success:function(data){
					var str ="<div id='roomlist' style='position: relative;'>";
					str += "<header><i id='addRoom' class='fa-solid fa-circle-plus' style='color:lightgreen; font-size:25px;'></i></header><main>";
					$(data).each(function(){
						console.log("리스트 조회 성공" + this.room_num);
						/* str =  "<p><form action='roomDetail' id='frm" + this.room_num +"' class='roomEnter'>";
						str += "<input type='hidden' name='roomId' value='"+ this.room_num +"'>";
						str += "<input type='hidden' name='roomName' value='"+ this.room_title +"'>";
						str += this.room_title + "<div id='content"+ this.roomId +"'>" +this.last_sender + " : " + this.last_msg + "(" + this.last_msg_date + ")</div>";
						str += "<div id='count"+ this.room_num +"'>"+ this.not_read_cnt +"</div>";
						str += "</form></p>" */
						
						str +=  "<div id='"+ this.room_num +"' name='"+ this.room_title +"' class='roomEnter'>";
						str +=  "<div class='talk'>";
						str += "<p class='friend-name'> " + this.room_title + "</p><p id='content"+ this.room_num +"' class='chat-content'>" + this.last_sender + " : " + this.last_msg  +"</p></div>";
						str += "<div class='chat-status'>";
						str += "<div id='count"+ this.room_num +"' class='chat-balloon'>"+ this.not_read_cnt +"</div>";
						str += "<div class='time'>" + this.last_msg_date + "</div>"
						str += "</div></div>";
					});
					str += "</main></div>"
					$("#chatContainer").append(str);
				}
			}		
	);
} 

function  cancelAction(where) {
	if(where == 1){
		leaveLookRoom();
		$('#empList').remove();
		$('#detailRoom').remove();
		$('#roomlist').show();
	}else if(where == 2){
		$('#empList').remove();
		$('#detailRoom').show();
	}else{
		$('#empList').remove();
		$('#detailRoom').remove();
		$('#roomlist').show();
	}
}

function  wsEvt() {
	console.log("wsEvt  start... ");
    //alert("wsEvt  start...")    
    
    //소켓이 열리면 동작
	ws.onopen = function(data){
		console.log("wsEvt  소켓이 열리면 초기화 세팅하기..");
	}	
    ws.onclose = function(data){
    	/* alert("세션 끊김 다시연결하자");
    	console.log("wsOpen  location.host: " + location.host);
	    var wsUri  = "ws://" + location.host + "${pageContext.request.contextPath}/chating";
	    // WebSocket 프로토콜을 사용하여 통신하기 위해서는 WebSocket객체를 생성. 
	    // 객체는 자동으로 서버로의 연결
	 	ws = new WebSocket(wsUri);
		wsEvt(); */
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
			if(jsonMsg.sender == '${empForSearch.emp_num}'){
				var str =  "<div id='"+ jsonMsg.roomId +"' name ='" + jsonMsg.roomName +"' class='roomEnter'>";
				str +=  "<div class='talk'>";
				str += "<p class='friend-name'> " + jsonMsg.roomName + "</p><p id='content"+ jsonMsg.roomId +"' class='chat-content'>" + jsonMsg.sender_name + " : " + jsonMsg.message +"</p></div>";
				str += "<div class='chat-status'>";
				str += "<div id='count"+ jsonMsg.roomId +"' class='chat-balloon'>"+ 0 +"</div>";
				str += "<div class='time'>" + new Date() + "</div>";
				str += "</div></div>";
				$("#roomlist").children('main').prepend(str);
				
				var str ="<div id='detailRoom'>";
				str += "<div class='setting_bar'><input type='hidden' id='chattingRoomId' value='" + jsonMsg.roomId +"'>";
				str += "<i class='fa-solid fa-arrow-left' onclick='cancelAction(1)'></i>";
				str += "<i id='showMember' class='fa-solid fa-users'></i>";
				str += "<i id='leaveRoom' class='fa-solid fa-right-from-bracket'></i>";
				str += "<i id='inviteMember' class='fa-solid fa-user-plus'></i></div>";
				str += "<header><span class='profile-name'>"+ $("#roomName").val() + "</span></header>";
				str += "<main><div class='chat-content'><div id='chatting' class='main-chat'>";
				str += "<div class = 'notice-chat'><div id='msgCnt" + jsonMsg.logNum +"' class='notRead'>" + (parseInt(jsonMsg.memberCnt)-1) + "</div>" + jsonMsg.sender_name + " : " + jsonMsg.message + "<br>" + new Date() +"</div>";
				str += "</div></div><div class='insert-content'><div id='send-content'>";
				str += "<textarea id='sendMsg' placeholder='보내실 메시지를 입력하세요.' required></textarea>";
				str += "<input type='button' id='sendBtn' class='chat-submit' value='보내기'>";	
				str += "<input type='button' id='openSendFile' value='파일 보내기'>";
				str += "<div id='uploadContainer'></div></div></div></main></div>";
				$('#roomlist').hide();
				$('#empList').remove();
				$("#chatContainer").append(str);
			}else{
				$('#msgCnt').html(parseInt($('#msgCnt').html())+1);
				var str =  "<div id='"+ jsonMsg.roomId +"' name ='" + jsonMsg.roomName +"' class='roomEnter'>";
				str +=  "<div class='talk'>";
				str += "<p class='friend-name'> " + jsonMsg.roomName + "</p><p id='content"+ jsonMsg.roomId +"' class='chat-content'>" + jsonMsg.sender_name + " : " + jsonMsg.message +"</p></div>";
				str += "<div class='chat-status'>";
				str += "<div id='count"+ jsonMsg.roomId +"' class='chat-balloon'>"+ 1 +"</div>";
				str += "<div class='time'>" + new Date() + "</div>";
				str += "</div></div>";
				$("#roomlist").children('main').prepend(str);
			}
		}else if(jsonMsg.type == "TALK" || jsonMsg.type == "LEAVE" || jsonMsg.type == "INVITE"){
			if($("#chattingRoomId").val() != jsonMsg.roomId){
				console.log("방에 안들어가있음");
				$('#msgCnt').html(parseInt($('#msgCnt').html())+1);
				var readCount = parseInt($("#count"+ jsonMsg.roomId).html()) + 1;
				console.log(readCount);
				$("#content"+ jsonMsg.roomId).html(jsonMsg.sender_name + " : " + jsonMsg.message);
				$("#count"+ jsonMsg.roomId).html(readCount);
			}else{
				$("#content"+ jsonMsg.roomId).html(jsonMsg.sender_name + " : " + jsonMsg.message);
				if(jsonMsg.showType == "1"){
					console.log("방에 들어가있음");
					var str = "";
					if(jsonMsg.sender == '${empForSearch.emp_num}'){
						str += "<div class = 'me-chat'><div class='me-chat-col'><span class='balloon'>" + jsonMsg.message + "<input class='save_attach' type='button' value='첨부다운' id='" + jsonMsg.attachName + "' name='"+ jsonMsg.message +"'></span></div><div class='time'>" + new Date() +"</div><div id='msgCnt" + jsonMsg.logNum +"' class='notRead'>" + jsonMsg.notReadCnt + "</div></div>";
					}else{
						str += "<div class='friend-chat'><img class='profile-img' src='${pageContext.request.contextPath}/resources/img/chatImg.png' alt='채팅이미지'><div class = 'friend-chat-col'><span class='profile-name'>" + jsonMsg.sender_name + "</span><span class='balloon'>" + jsonMsg.message + "<input class='save_attach' type='button' value='첨부다운' id='" + jsonMsg.attachName + "' name='"+ jsonMsg.message +"'></span></div><div class='time'>" + new Date() +"</div><div id='msgCnt" + jsonMsg.logNum +"' class='notRead'>" + jsonMsg.notReadCnt + "</div></div>";
					}
				}else if(jsonMsg.showType == "2"){
					var str = "";
					str += "<div class = 'notice-chat'><div id='msgCnt" + jsonMsg.logNum +"' class='notRead'>" + jsonMsg.notReadCnt + "</div>" + jsonMsg.message + "</div>";
				}else{
					var str = "";
					if(jsonMsg.sender == '${empForSearch.emp_num}'){
						str += "<div class = 'me-chat'><div class='me-chat-col'><span class='balloon'>" + jsonMsg.message + "</span></div><div class='time'>" + new Date() +"</div><div id='msgCnt" + jsonMsg.logNum +"' class='notRead'>" + jsonMsg.notReadCnt + "</div></div>";
					}else{
						str += "<div class='friend-chat'><img class='profile-img' src='${pageContext.request.contextPath}/resources/img/chatImg.png' alt='채팅이미지'><div class = 'friend-chat-col'><span class='profile-name'>" + jsonMsg.sender_name + "</span><span class='balloon'>" + jsonMsg.message + "</span></div><div class='time'>" + new Date() +"</div><div id='msgCnt" + jsonMsg.logNum +"' class='notRead'>" + jsonMsg.notReadCnt + "</div></div>";
					}
				}
				$("#chatting").append(str);
			}
		}else if(jsonMsg.type == "CONNECT"){
			if(jsonMsg.sender != '${empForSearch.emp_num}'){
				$(jsonMsg.readMsg).each(function(){
					var readCount = parseInt($("#msgCnt"+ this).html()) - 1;
					console.log(readCount);
					$("#msgCnt"+ this).html(readCount);
				});
			}
		}else if(jsonMsg.type == "INVITED"){
			console.log("초대 받았음");
			$('#msgCnt').html(parseInt($('#msgCnt').html())+1);
			console.log(readCount);
			str =  "<div id='"+ jsonMsg.roomId +"' name ='" + jsonMsg.roomName +"' class='roomEnter'>";
			str +=  "<div class='talk'>";
			str += "<p class='friend-name'> " + jsonMsg.roomName + "</p><p id='content"+ jsonMsg.roomId +"' class='chat-content'>" + jsonMsg.sender_name + " : " + jsonMsg.message +"</p></div>";
			str += "<div class='chat-status'>";
			str += "<div id='count"+ jsonMsg.roomId +"' class='chat-balloon'>"+ 1 +"</div>";
			str += "<div class='time'>" + new Date() + "</div>";
			str += "</div></div>";
			$("#roomlist").children('main').prepend(str);
		}
	}
}
	
	/*  미결재 알림 
	$.ajax({
		type:'POST',
		url: '${ pageContext.request.contextPath }/approval/notAuthApvCount',
		success: function(data){
			//console.log(data);
			$('#apvCount2').text(data);
			$('#apvCount3').text(data);
		}
	})
	
	$(document).ready(function() {
		if($("#emp.emp_num").val() == "") {
			$(location).attr("href", "/logoutForm");
		}
	}); */
	
	
	function email(){
		console.log("empno permit은?" + '${empForSearch.permit_status}');
		if($("#emp.emp_num").val() == "") {
			$(location).attr("href", "/logoutForm");
		}
		$.ajax({
				type:"POST",
				url:"/mail/countMail",
				success:function(data){
					$("#email_count").html(data);
					$("#menu_email_count").html(data);
					$("#main_email_count").html(data);
					$("#header_email_count").html(data);
					$("#header_email_count2").html(data);
				}
		});
	}
	
	
	
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
              <!-- <a class="nav-link dropdown-toggle" href="#" id="chattingsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fa-solid fa-comments"></i>
                <span class="badge badge-danger badge-counter"><span id="msgCnt"></span></span>
              </a>
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="chattingsDropdown">
                <h6 class="dropdown-header">
                  채팅방 목록
                </h6>
                 	<div id="chatContainer" class="d-flex align-items-center" style="overflow:auto; height:500px;">
					</div>
              </div> -->
			   <a class="nav-link collapsed" id="openChat" role="button" href="#" data-toggle="collapse" data-target="#collapseChat" aria-expanded="false" aria-controls="collapseChat">
			           <i class="fa-solid fa-comments"></i>
			           <span class="badge badge-danger badge-counter"><span id="msgCnt"></span></span>
			   </a>
			        <div id="collapseChat" class="collapse" style="position: absolute; z-index: 10000; right: -13em">
			         	<div id="chatContainer" class="chat_close" style="overflow:auto; height:600px; width: 500px;">
	                 		
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
                
                <a class="dropdown-item text-center small text-gray-500" href="${pageContext.request.contextPath}/user/notAuthApvList?currentPage=1">문서함으로 가기</a>
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
                
                
                
                <a class="dropdown-item text-center small text-gray-500" href="${pageContext.request.contextPath}/user/mail/MailList?listType=1">받은 메일함으로 가기</a>
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
	           				<a class="dropdown-item" href="/admin/adminMyPageForm">
			                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>내 정보
			                </a>
			            </c:when>
			            
	           			<c:otherwise>
		           			<a class="dropdown-item" href="/user/userMyPageForm">
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
		          <a class="btn btn-outline-primary" href="/logout">로그아웃</a>
		        </div>
		      </div>
		    </div>
		  </div>        
	</body>
</html>