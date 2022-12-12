package com.oracle.devwareProject.service.jehwan;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.oracle.devwareProject.dao.jehwan.ChatDao;
import com.oracle.devwareProject.dto.jehwan.ChatMessageDto;
import com.oracle.devwareProject.dto.jehwan.ChatMessageProc;
import com.oracle.devwareProject.dto.jehwan.ChatRoom;
import com.oracle.devwareProject.dto.jehwan.ChatRoomDto;
import com.oracle.devwareProject.dto.jehwan.ChatRoomInviteLeave;
import com.oracle.devwareProject.dto.jehwan.EmpDtoVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ChatService {
	private final ChatDao chatDao;
    private final ObjectMapper objectMapper;
    private Map<String, ChatRoom> chatRooms;
    
    @PostConstruct
    private void init() {
        chatRooms = new LinkedHashMap<>();
    }

    
    
    public List<ChatRoom> findmyRoomId(int empno) {
    	log.info("findmyRoomId start..");
    	List<String> roomNameList = chatDao.findmyRoomId(empno);
    	log.info("how many my room?->" + roomNameList.size());
    	List<ChatRoom> chatRoom = new ArrayList<>();
    	for(String roomName : roomNameList) {
    		
        	chatRoom.add(chatRooms.get(roomName));
        }
    	log.info("findmyRoomId return chatRoom.size()->"+ chatRoom.size());
        return chatRoom;
    }

    public ChatRoom findRoomById(String roomId) {
        return chatRooms.get(roomId);
    }
    
    
    
    public ChatRoom createRoom(String name,int memberCnt, HashMap<String,WebSocketSession> sessions, ChatRoomDto chatRoomDto) {
    	log.info("createRoom with name->" + name);
    	chatDao.createRoom(chatRoomDto);
        String roomId = String.valueOf(chatRoomDto.getRoom_num());
        log.info("roomNum은?->" + roomId);
        ChatRoom chatRoom = new ChatRoom(roomId, name,memberCnt, sessions);
        chatRooms.put(roomId, chatRoom);
        
        return chatRoom;
    }

    public <T> void sendMessage(WebSocketSession session, T message) {
    	log.info("sendMessage start... session->" + session );
        try {
            session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        }
    }
    

	public void saveMessage(ChatMessageDto chatMessage) {
		log.info("saveMessage start...");
		chatDao.saveMessage(chatMessage);
	}

	public int getMsgCnt(String empno) {
		log.info("getMsgCnt start...");
		int msgCnt = chatDao.getMsgCnt(empno);
		return msgCnt;
	}



	public List<ChatRoomDto> getRoomList(String empno) {
		log.info("getRoomList start empno ->" + empno);
		List<ChatRoomDto> chatRoomDtos = chatDao.getRoomList(empno);
		return chatRoomDtos;
	}



	public void detailRoom(ChatMessageProc chatMessageProc) {
		log.info("detailRoom start chatMessageDto.emp_num ->" + chatMessageProc.getP_emp_num());
		log.info("detailRoom start chatMessageDto.room_num ->" + chatMessageProc.getP_room_num());
		ChatRoom chatRoom = chatRooms.get(String.valueOf(chatMessageProc.getP_room_num()));
		System.out.println("chatRoom->" + chatRoom);
		System.out.println("chatRooms.size" + chatRooms.size());
		//System.out.println("lookMember size before->" + chatRoom.getLook_member().size());
		//chatRoom.getLook_member().add(String.valueOf(chatMessageProc.getP_emp_num()));
		//System.out.println("lookMember size after->" + chatRoom.getLook_member().size());
		chatDao.detailRoom(chatMessageProc);
	}



	public List<String> connectRoom(String roomId) {
		log.info("connectRoom start...");
		log.info("connectRoom start...");
		List<String> updateMsg = chatDao.connectRoom(roomId);
		return null;
	}



	public void getEmpList(EmpDtoVO empDtoVo) {
		log.info("getEmpList start...");
		chatDao.getEmpList(empDtoVo);
	}



	public void leaveRoom(ChatRoomInviteLeave chatRoomInviteLeave) {
		log.info("leaveRoom start...");
		chatDao.leaveRoom(chatRoomInviteLeave);
	}



	public void deleteRoom(String room_num) {
		log.info("deleteRoom start...");
		chatRooms.remove(room_num);
		chatDao.deleteRoom(room_num);
	}



	public void leaveRoomLook(String empno, String roomId) {
		log.info("leaveRoomLook start...");
		ChatRoom chatRoom = chatRooms.get(roomId);
		log.info("chatRoom" + chatRoom);
		if(chatRoom != null) {
			System.out.println("나갈 방존재");
			chatRoom.getLook_member().remove(empno);
		}else {
			System.out.println("나갈 방이 없는데?");
		}
		log.info("leaveRoomLook end...");
	}



	public void inviteRoom(ChatRoomInviteLeave chatRoomInviteLeave) {
		log.info("inviteRoom start...");
		chatDao.inviteRoom(chatRoomInviteLeave);
		log.info("inviteRoom end...");
	}


}