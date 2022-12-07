<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		.chating{
			background-color: #000;
			width: 500px;
			height: 500px;
			overflow: auto;
		}
		.chating .me{
			color: #F6F6F6;
			text-align: right;
		}
		.chating .others{
			color: #FFE400;
			text-align: left;
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
</style>
</head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		console.log("wsOpen  location.host: " + location.host);
	    var wsUri  = "ws://" + location.host + "${pageContext.request.contextPath}/chating";
	    // WebSocket 프로토콜을 사용하여 통신하기 위해서는 WebSocket객체를 생성. 
	    // 객체는 자동으로 서버로의 연결
	 	ws = new WebSocket(wsUri);
		wsEvt();
		
		/* var userList = []
		<c:forEach var="members" items="${chatMember }">
			userList.push("${members}");
		</c:forEach>
		alert(userList); */
		
		
		/* if('${empty roomId}'){
			var userOption ={
				type       : "CREATE",
				roomName  : "테스트용",
				sender : "테스트인원",
				userList   : userList,
				message		: $("#createText").val()
			}
			alert("createRoom Start..")  	
			// 자바스크립트의 값을 JSON 문자열로 변환
			// Client --> Server
			ws.send(JSON.stringify(userOption));
		}  */
		
	});
	function  wsEvt() {
		console.log("wsEvt  start... ");
        alert("wsEvt  start...")    
        
        //소켓이 열리면 동작
		ws.onopen = function(data){
			console.log("wsEvt  소켓이 열리면 초기화 세팅하기..");
			
			if('${roomId}' == null || '${roomId}' == ""){
				var userList = []
				<c:forEach var="members" items="${chatMember }">
					userList.push("${members}");
				</c:forEach>
				alert(userList);
				
				var userOption ={
					type       : "CREATE",
					roomName  : "${roomName}",
					sender : "테스트인원",
					userList   : userList,
					message		: $("#createText").val()
				}
				alert("createRoom Start..")  	
				// 자바스크립트의 값을 JSON 문자열로 변환
				// Client --> Server
				ws.send(JSON.stringify(userOption));
			} 
		}	
        ws.onclose = function(data){
        	console.log("세션 끊김 다시연결하자");
        }
        
        ws.onmessage = function(data) {
			var msg = data.data;
			var memberSave = false;
			
			alert("ws.onmessage->"+msg)
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
				$("#roomId").val(jsonMsg.roomId);
				$("#chating").append("<p>" +jsonMsg.sender + jsonMsg.message + "</p>");
			}
			
			if(jsonMsg.type == "TALK"){
				$("#chating").append("<p>" +jsonMsg.sender + jsonMsg.message + "</p>");
			}
		}
	}
	
	function send() {
		var option ={
			type: "TALK",
			roomId : $("#roomId").val(),
			sender : $("#userName").val(),
			message : $("#sendMsg").val()
		}
		// 자바스크립트의 값을 JSON 문자열로 변환
		ws.send(JSON.stringify(option));
		$('#sendMsg').val("");
	}   
	
</script>
<body>
	<div id="container" class="container">
		<h1>${roomName }</h1>
		<input type="hidden" id="roomId" value="${roomId }">
		<div id="chating" class="chating">
		</div>
		<div id="messageCount">0</div>
		<input type="text" id=userName>


		<table class="inputTable">
			<tr>
				<th>메시지</th>
				<th><input id="sendMsg" placeholder="보내실 메시지를 입력하세요."></th>
				<th><button onclick="send()" id="sendBtn">보내기</button></th>
			</tr>
		</table>
	
	</div>
</body>
</html>