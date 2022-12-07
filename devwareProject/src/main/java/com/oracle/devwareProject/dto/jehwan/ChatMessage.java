package com.oracle.devwareProject.dto.jehwan;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatMessage {
	
    // 메시지 타입 : 입장, 채팅
    public enum MessageType {
        CREATE, ENTER, TALK, LEAVE, CONNECT, INVITE
    }
    private MessageType type; // 메시지 타입
    private String roomId; // 방번호
    private String sender; // 메시지 보낸사람
    private String sender_name; // 메시지 보낸사람 이름
    private String logNum; // 메세지 번호
    private String message; // 메시지
    private String roomName;
    private String notReadCnt;
    //파일전송인지 체크
    private String showType; //보여줄 타입
    private String attachName; //저장 이름
    //create용
    private String memberCnt; //참여인원수
    //connect용
	private List<String> readMsg; //들어갔을때 안읽은 메세지
	
	//생성자
	public ChatMessage(MessageType type, String roomId, String sender, String message) {
		this.type = type;
		this.roomId =roomId;
		this.sender = sender;
		this.message =message;
	}
}