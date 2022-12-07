<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	*{
			margin:0;
			padding:0;
		}
		.container{
			width: 500px;
			margin: 0 auto;
			padding: 25px
		}
		.container h1{
			text-align: left;
			padding: 5px 5px 5px 15px;
			color: #FFBB00;
			border-left: 3px solid #FFBB00;
			margin-bottom: 20px;
		}
		.chatting{
			background-color: #000;
			width: 500px;
			height: 500px;
			overflow: auto;
		}
		.chatting .me{
			color: #F6F6F6;
			text-align: right;
		}
		.chatting .others{
			color: #FFE400;
			text-align: left;
		}
		.chatting .notice{
			color: gray;
			text-align: center;
		}
		input{
			width: 330px;
			height: 25px;
		}
		#yourMsg{
			display: none;
		}
		#yourNameDel{
			display: none;
		}
		.unchecked{
			border-color: lightgray;
		}
		.checked{
			border-color: #FFE400;
		}
</style>
</head>
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
		
		$(document).on("click","#openList", function(){
			if($(this).val() == "목록열기"){
				$("#openList").val("목록닫기");
				getRoomList();
			}else{
				$(this).val("목록열기");
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
						str += "<input type='button' id='addRoom' value='채팅방 추가'>";
						str += "<div id='empList'></div>";
						str += "<div id='detailRoom'></div>";
						str += "<div id='roomlist'>";
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
						str += "</div>"
						$("#chatContainer").append(str);
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
</script>
<body>
	<h2>chat room list 입성</h2>
	총 안읽은 메세지 수 : <div id="msgCnt"></div>
	<input type="button" id="openList" value="목록열기">
	<div id="chatContainer">
	
	</div>
	<!-- <form action="/createRoom" id="addForm" hidden="true">
		<div id="memberList">
			홍길동<input type="checkbox" name="chatMember" value="1"><p>
			김우석<input type="checkbox" name="chatMember" value="2"><p>
			김건희<input type="checkbox" name="chatMember" value="3"><p>
			최지웅<input type="checkbox" name="chatMember" value="4"><p>
			장제환<input type="checkbox" name="chatMember" value="5">
		</div>
		<input type="text" name="roomName">
		<input type="button" id="makeRoomBtn" value="생성">
	</form> -->
</body>
</html>