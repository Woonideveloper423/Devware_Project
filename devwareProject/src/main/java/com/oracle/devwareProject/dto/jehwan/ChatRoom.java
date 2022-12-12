package com.oracle.devwareProject.dto.jehwan;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.web.socket.WebSocketSession;


import com.oracle.devwareProject.service.jehwan.ChatService;

import lombok.Builder;
import lombok.Getter;


@Getter
public class ChatRoom {
	 private String roomId;
	    private String name;
	    private HashMap<String, WebSocketSession> sessions = new HashMap<>();
	    private List<String> look_member = new ArrayList<>();
	    private int memberCnt;
	    
	    @Builder
	    public ChatRoom(String roomId, String name,int memberCnt, HashMap<String, WebSocketSession> sessions) {
	        this.roomId = roomId;
	        this.name = name;
	        this.memberCnt = memberCnt;
	        this.sessions = sessions;
	    }
	    
	    public void sendReadMsg(ChatMessage chatMessage, ChatService chatService) {
	    	sendMessage(chatMessage, chatService);
	    }

	    public void handleActions(ChatMessage chatMessage, ChatService chatService) {
	        //String empno = session.getAttributes().get("empno").toString();
//	    	if (chatMessage.getType().equals(ChatMessage.MessageType.ENTER)) {
//	            sessions.put(session.getAttributes().get("empno").toString(), session);
//	            chatMessage.setMessage(chatMessage.getSender_name() + "님이 입장했습니다.");
//	        }
	    	if (chatMessage.getType().equals(ChatMessage.MessageType.LEAVE)) {
	    		memberCnt--;
	    		ChatRoomInviteLeave chatRoomInviteLeave = new ChatRoomInviteLeave(chatMessage.getSender(), chatMessage.getRoomId());
	    		chatService.leaveRoom(chatRoomInviteLeave);
	    		sessions.remove(chatMessage.getSender());
	    		look_member.remove(chatMessage.getSender());
	            chatMessage.setMessage(chatMessage.getSender_name() + "님이 퇴장했습니다.");
	        }
	    	else if (chatMessage.getType().equals(ChatMessage.MessageType.CREATE)) {
	    		look_member.add(chatMessage.getSender());
	        }
	    	else if (chatMessage.getType().equals(ChatMessage.MessageType.INVITE)) {
	    		memberCnt++;
	        }
//	        if (chatMessage.getType().equals(ChatMessage.MessageType.CREATE)) {
//	        	System.out.println("ChatRoom empno->" + empno);
//	        	System.out.println("sessions.size()->" + sessions.size());
//	        	
//	        }
	    	else if (chatMessage.getType().equals(ChatMessage.MessageType.CONNECT)) {
	        	System.out.println("ChatRoom empno->" + chatMessage.getSender());
	        	System.out.println("sessions.size()->" + sessions.size());
	        	look_member.add(chatMessage.getSender());
	        	sendMessage(chatMessage, chatService);
	        	return;
	        }
	    	
	        
	        //sendMessage(chatMessage, chatService);
	        ChatMessageDto chatMessageDto =
	        new ChatMessageDto(Integer.parseInt(roomId), Integer.parseInt(chatMessage.getSender()),Integer.parseInt(chatMessage.getShowType()), chatMessage.getMessage());
	        if(chatMessage.getShowType().equals("1")) {
	        	chatMessageDto.setAttach_name(chatMessage.getAttachName());
	        }else {
	        	chatMessageDto.setAttach_name("");
	        }
	        chatMessageDto.setLook_member(look_member);
	        System.out.println("방의 인원수 ->" + memberCnt);
	        System.out.println("방을 보고있는 사람 수->" + look_member.size());
	        chatMessageDto.setNot_read_cnt(memberCnt - look_member.size());
	        chatService.saveMessage(chatMessageDto);
	        chatMessage.setLogNum(String.valueOf(chatMessageDto.getLog_num()));
	        chatMessage.setNotReadCnt(String.valueOf(memberCnt - look_member.size()));
	        sendMessage(chatMessage, chatService);
	    }
	    
	    
	    
	   
	    
	    public <T> void sendMessage(T message, ChatService chatService) {
	        sessions.forEach((empno,session) -> chatService.sendMessage(session, message));
	    }
	    
//	    public <T> void sendMessageToConnect(T message, ChatService chatService) {
//	    	connect_sessions.forEach((empno,session) -> chatService.sendMessage(session, message));
//	    }
}