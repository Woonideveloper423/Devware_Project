package com.oracle.devwareProject.dao.jehwan;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.dto.jehwan.ChatMessageDto;
import com.oracle.devwareProject.dto.jehwan.ChatMessageProc;
import com.oracle.devwareProject.dto.jehwan.ChatRoomDto;
import com.oracle.devwareProject.dto.jehwan.ChatRoomInviteLeave;
import com.oracle.devwareProject.dto.jehwan.EmpDto;
import com.oracle.devwareProject.dto.jehwan.EmpDtoVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class ChatDaoImpl implements ChatDao {
	private final SqlSession session;

	@Override
	public List<String> findmyRoomId(int empno) {
		log.info("findRoomByEmpno start...");
		List<String> roomId = new ArrayList<>();
		try {
			roomId = session.selectList("myChatRoomId",    empno);
		} catch (Exception e) {
			// TODO: handle exception
		}
		log.info("findRoomByEmpno end...");
		return roomId;
	}

	@Override
	public void createRoom(ChatRoomDto chatRoomDto) {
		log.info("createRoom start...");
		try {
			session.insert("createRoom", chatRoomDto);
			System.out.println("roomnum->" + chatRoomDto.getRoom_num());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		log.info("findRoomByEmpno end...");
	}

	@Override
	public void saveMessage(ChatMessageDto chatMessage) {
		log.info("saveMessage start...");
		try {
			session.insert("saveMessage", chatMessage);
			if(chatMessage.getLook_member().size() != 0) {
				log.info("채팅 번호는?->" + chatMessage.getLog_num());
				log.info("보고있는사람존재->" + chatMessage.getLook_member().get(0));
				session.update("updateLastLog", chatMessage);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		log.info("saveMessage end...");
	}

	@Override
	public int getMsgCnt(String empno) {
		log.info("getMsgCnt start...");
		int msgCnt = 0;
		try {
			msgCnt = session.selectOne("getMsgCnt", empno);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		log.info("getMsgCnt end...");
		
		return msgCnt;
	}

	@Override
	public List<ChatRoomDto> getRoomList(String empno) {
		log.info("findRoomByEmpno start...");
		List<ChatRoomDto> roomList = new ArrayList<>();
		try {
			roomList = session.selectList("myChatRoomList",  empno);
			System.out.println("roomList->" + roomList);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		log.info("findRoomByEmpno end...");
		return roomList;
	}

	@Override
	public void detailRoom(ChatMessageProc chatMessageProc) {
		log.info("detailRoom start...");
		try {
			session.selectOne("getMessageList",  chatMessageProc);
			System.out.println("chatMessageProc =" + chatMessageProc);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		log.info("detailRoom end...");
	}

	@Override
	public List<String> connectRoom(String roomId) {
		log.info("connectRoom start...");
		List<String> updateMsg = new ArrayList<>();
		try {
			updateMsg = session.selectList("connectRoom",  roomId);
			System.out.println("roomList->" + updateMsg);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		log.info("connectRoom end...");
		return updateMsg;
	}

	@Override
	public void getEmpList(EmpDtoVO empDtoVo) {
		log.info("getEmpList start...");
		List<EmpDto> empDtos = new ArrayList<>();
		try {
			empDtos = session.selectList("getEmpList",  empDtoVo);
			empDtoVo.setEmpDtos(empDtos);
			System.out.println("empDtos->" + empDtos);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		log.info("getEmpList end...");
	}

	@Override
	public void leaveRoom(ChatRoomInviteLeave chatRoomInviteLeave) {
		log.info("leaveRoom start...");
		try {
			session.delete("leaveRoom", chatRoomInviteLeave);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		log.info("leaveRoom end...");
	}

	@Override
	public void deleteRoom(String room_num) {
		log.info("deleteRoom start...");
		try {
			session.delete("deleteRoom", room_num);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		log.info("deleteRoom end...");
	}

	@Override
	public void inviteRoom(ChatRoomInviteLeave chatRoomInviteLeave) {
		log.info("inviteRoom start...");
		try {
			session.insert("inviteRoom", chatRoomInviteLeave);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		log.info("inviteRoom end...");
	}


	
	
	
}
