<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Websocket Chat</title>
</head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	var ws;
	
	function createRoom(){
	    alert("chatName Start..");
		var userName = $("#userName").val();
		console.log("chatName  userName: " + userName);
		if(userName == null || userName.trim() == ""){
			alert("방제목을 이름을 입력해주세요.");
			$("#userName").focus();
		}else{
			wsOpen();
			$("#meName").append('나의이름:'+userName); 
			$("#yourName").hide();
			$("#yourMsg").show();
		//	$("#yourNameDel").show();
		}   	
	    	
	 }
	
	function wsOpen(){
	console.log("wsOpen  location.host: " + location.host);
	var wsUri  = "ws://" + location.host + "${pageContext.request.contextPath}/chat/rooms";
	  // WebSocket 프로토콜을 사용하여 통신하기 위해서는 WebSocket객체를 생성. 
	  // 객체는 자동으로 서버로의 연결
	ws = new WebSocket(wsUri);
	wsEvt();
	 		
	}
	 data: {
	     room_name : '',
	     chatrooms: [
	 ]
	    },
	    created() {
	        this.findAllRoom();
	    },
	    methods: {
	        findAllRoom: function() {
	            axios.get('/chat/rooms').then(response => { this.chatrooms = response.data; });
	        },
	        createRoom: function() {
	            if("" === this.room_name) {
	                alert("방 제목을 입력해 주십시요.");
	                return;
	            } else {
	                var params = new URLSearchParams();
	                params.append("name",this.room_name);
	                axios.post('/chat/room', params)
	                .then(
	                    response => {
	                        alert(response.data.name+"방 개설에 성공하였습니다.")
	                        this.room_name = '';
	                        this.findAllRoom();
	                    }
	                )
	                .catch( response => { alert("채팅방 개설에 실패하였습니다."); } );
	            }
	        },
	        enterRoom: function(roomId) {
	            var sender = prompt('대화명을 입력해 주세요.');
	            if(sender != "") {
	                localStorage.setItem('wschat.sender',sender);
	                localStorage.setItem('wschat.roomId',roomId);
	                location.href="/chat/room/enter/"+roomId;
	            }
	        }
	    }
	});
</script>


       

<body>
	<div class="container" id="app">
        <div class="row">
            <div class="col-md-12">
                <h3>채팅방 리스트</h3>
            </div>
        </div>
        <div class="input-group">
            <div class="input-group-prepend">
                <label class="input-group-text">방제목</label>
            </div>
            <input type="text" class="form-control" v-model="room_name" v-on:keyup.enter="createRoom">
            <div class="input-group-append">
                <button class="btn btn-primary" type="button" @click="createRoom">채팅방 개설</button>
            </div>
        </div>
        <ul class="list-group">
            <li class="list-group-item list-group-item-action" v-for="item in chatrooms" v-bind:key="item.roomId" v-on:click="enterRoom(item.roomId)">
                {{item.name}}
            </li>
        </ul>
    </div>
</body>
</html>