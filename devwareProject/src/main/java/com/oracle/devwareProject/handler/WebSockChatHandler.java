package com.oracle.devwareProject.handler;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;


import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.dto.jehwan.ChatMessage;
import com.oracle.devwareProject.dto.jehwan.ChatMessage.MessageType;
import com.oracle.devwareProject.dto.jehwan.ChatRoom;
import com.oracle.devwareProject.dto.jehwan.ChatRoomDto;
import com.oracle.devwareProject.dto.jehwan.ChatRoomInviteLeave;
import com.oracle.devwareProject.service.jehwan.ChatService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@Component
public class WebSockChatHandler extends TextWebSocketHandler {
	private final ObjectMapper objectMapper;
	 private final ChatService chatService;
	 HashMap<String, WebSocketSession> sessionMap = new HashMap<>();
		// 웹소켓 세션 ID과 Member을 담아둘 JSONObject
	 JSONObject jsonUser = null;
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload();
		System.out.println("SocketHandler handleTextMessage msg->"+msg);
		EmpForSearch emp = (EmpForSearch) session.getAttributes().get("empForSearch");
		JSONObject jsonObj = jsonToObjectParser(msg);
		// type을 Get하여 분기 
		String msgType = (String) jsonObj.get("type");
		System.out.println("SocketHandler handleTextMessage  msgType->"+msgType);
		MessageType type   = MessageType.valueOf((String)(jsonObj.get("type")));
  	    String roomId    = (String) jsonObj.get("roomId");
  	    String sender  = String.valueOf(emp.getEmp_num());
  	    String senderName  = String.valueOf(emp.getEmp_name());
  	    System.out.println("여긴오나?");
  	    String messageContent  = (String) jsonObj.get("message");
  	    ChatMessage chatMessage = new ChatMessage(type, roomId, sender, messageContent);
		switch (msgType) {
		     // 전체 Message 
	        case "TALK":
	        	String showType   = (String) jsonObj.get("showType");
	        	String attachName   = (String) jsonObj.get("attachName");
	        	chatMessage.setAttachName(attachName);
	        	chatMessage.setSender_name(senderName);
	        	chatMessage.setShowType(showType);
	            ChatRoom send_room = chatService.findRoomById(chatMessage.getRoomId());
	            if(send_room !=null) {
	            	send_room.handleActions(chatMessage, chatService);
	            }
	            break;	
	            
	        case "CREATE":
	            // sessionUserMap에 sessionId와  userName 등록 
	        	HashMap<String, WebSocketSession> sessions = new HashMap<>();
	        	String roomName   = (String) jsonObj.get("roomName");
	        	List<String> empNoList =  (List<String>) jsonObj.get("empNums");
	        	List<String> empNameList =  (List<String>) jsonObj.get("empNames");
	        	empNoList.add(sender);
	        	log.info("empNoList length->" + empNoList.size());
	     	    for(String empnoSession : empNoList) {
	     	    	WebSocketSession webSocketSession = sessionMap.get(empnoSession);
	     	    	if(webSocketSession != null) {
	     	    		log.info("userExist");
	     	    		sessions.put(empnoSession, webSocketSession);
	     	    	}else {
	     	    		log.info("userNotExist");
	     	    	}
	     	    }
	           ChatRoomDto chatRoomDto = new ChatRoomDto(roomName, empNoList);
	     	   ChatRoom chatRoom = chatService.createRoom(roomName, empNoList.size(), sessions, chatRoomDto);
	     	   chatMessage.setRoomId(chatRoom.getRoomId());
	     	   chatMessage.setRoomName(roomName);
	     	   chatMessage.setSender_name(senderName);
	     	   chatMessage.setMemberCnt(String.valueOf(empNoList.size()));
	     	   chatMessage.setShowType("2");
	     	   chatMessage.setMessage(senderName + "님이" + Arrays.toString(empNameList.toArray()) + "님을 초대했습니다");
	     	   chatRoom.handleActions(chatMessage, chatService);

		       break;
		    
	        case "CONNECT":
	            // sessionUserMap에 sessionId와  userName 등록
	        	
	        	List<String> readMsgs = (List<String>) jsonObj.get("readMsgs");
	        	chatMessage.setReadMsg(readMsgs);
	        	ChatRoom connect_room = chatService.findRoomById(chatMessage.getRoomId());
	        	connect_room.handleActions(chatMessage, chatService);

		    break;
	            
	        // sessionUserMap에 User등록 
//	        case "ENTER":
//	            // sessionUserMap에 sessionId와  userName 등록  
//
// 	          log.info("type ->", type);
//	  	      log.info("roomId ->", roomId);
//	  	      log.info("sender ->", sender);
//	  	      log.info("messageContent ->", messageContent);
//	  	    
// 	        
// 	          ChatRoom room_enter = chatService.findRoomById(chatMessage.getRoomId());
// 	          room_enter.handleActions(session, chatMessage, chatService);
//	     	    
//		      break;
		     	
	        case "LEAVE":   
	        	chatMessage.setSender_name(senderName);
	        	chatMessage.setShowType("2");
	  	        ChatRoom room_leave = chatService.findRoomById(chatMessage.getRoomId());
	  	        if(room_leave.getMemberCnt()==1) {
	  	        	chatService.deleteRoom(chatMessage.getRoomId());
	  	        }else {
	  	        	room_leave.handleActions(chatMessage, chatService); 
	  	        }
  
	         break;
	         
	        case "INVITE":
	        	List<String> empNoListInvite =  (List<String>) jsonObj.get("empNums");
	        	List<String> empNames =  (List<String>) jsonObj.get("empNames");
	        	String InviteroomName   = (String) jsonObj.get("roomName");
	        	ChatRoom room_invite = chatService.findRoomById(chatMessage.getRoomId());
	        	ChatRoomInviteLeave chatRoomInviteLeave = new ChatRoomInviteLeave(roomId, empNoListInvite);
	        	chatService.inviteRoom(chatRoomInviteLeave);
	        	log.info("empNoList length->" + empNoListInvite.size());
	     	    
	        	chatMessage.setSender_name(senderName);
	        	chatMessage.setShowType("2");
	        	chatMessage.setMessage(senderName + "님이" + Arrays.toString(empNames.toArray()) + "님을 초대했습니다");
	  	        room_invite.handleActions(chatMessage, chatService); 
	  	        chatMessage.setType(MessageType.valueOf("INVITED"));
	  	        chatMessage.setRoomName(InviteroomName);
	  	        for(String empnoSession : empNoListInvite) {
	     	    	WebSocketSession webSocketSession = sessionMap.get(empnoSession);
	     	    	if(webSocketSession != null) {
	     	    		log.info("userExist");
	     	    		room_invite.getSessions().put(empnoSession, webSocketSession);
	     	    		webSocketSession.sendMessage(new TextMessage(objectMapper.writeValueAsString(chatMessage)));
	     	    	}else {
	     	    		log.info("userNotExist");
	     	    	}
	     	    }
	         break;
		     	
 	     }  // switch End         

	}
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("SocketHandler afterConnectionEstablished start...");
		
		// 웹소켓  연결이 되면 동작
		super.afterConnectionEstablished(session);
		EmpForSearch emp = (EmpForSearch) session.getAttributes().get("empForSearch");
		String empno = String.valueOf(emp.getEmp_num());
		// 연결 소겟을 mAP에 등록 
		System.out.println("다시 연결됬나? ->" + empno);
		
		sessionMap.put(empno, session);
		
		System.out.println("afterConnectionEstablished sessionMap getempnosession->" + sessionMap.get(empno));
		log.info("sessionMap size->" + sessionMap.size());
		List<ChatRoom> myRoomList = chatService.findmyRoomId(Integer.parseInt(empno));

		for(ChatRoom room : myRoomList) {
			if(room != null) {
				 System.out.println("room연결->" + room.getName());
				 room.getSessions().put(empno, session);
			}else {
				System.out.println("그 방은 없는데?");
			}
		}
		System.out.println("연결 끝");
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		
		super.afterConnectionClosed(session, status);
		log.info("afterConnectionClosed");
		EmpForSearch emp = (EmpForSearch) session.getAttributes().get("empForSearch");
		String empno = String.valueOf(emp.getEmp_num());
		
		System.out.println("afterConnectionEstablished sessionMap before remove->" + sessionMap.get(empno));
		// 연결 소겟을 mAP에 등록 
		System.out.println("empno 끊기 ->" + empno);
		sessionMap.remove(empno);
		
		System.out.println("afterConnectionEstablished sessionMap after remove->" + sessionMap.get(empno));
		log.info("sessionMap size->" + sessionMap.size());
		List<ChatRoom> myRoomList = chatService.findmyRoomId(Integer.parseInt(empno));
		
		for(ChatRoom room : myRoomList) {
			if(room != null) {
				 System.out.println("room끊기->" + room.getName());
				 room.getSessions().remove(empno);
				 room.getLook_member().remove(empno);
			}else {
				System.out.println("끊을 방이 없는데?");
			}
		}
		log.info("끊기 성공");
	}
	
	
	
	
	// handleTextMessage 메소드 에 JSON파일이 들어오면 파싱해주는 함수를 추가
	private static JSONObject jsonToObjectParser(String jsonStr) {
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = null;
		try {
			jsonObj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
}


