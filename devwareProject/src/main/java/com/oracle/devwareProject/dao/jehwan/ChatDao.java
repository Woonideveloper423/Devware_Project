package com.oracle.devwareProject.dao.jehwan;

import java.util.List;

import com.oracle.devwareProject.dto.jehwan.ChatMessageDto;
import com.oracle.devwareProject.dto.jehwan.ChatMessageProc;
import com.oracle.devwareProject.dto.jehwan.ChatRoomDto;
import com.oracle.devwareProject.dto.jehwan.ChatRoomInviteLeave;
import com.oracle.devwareProject.dto.jehwan.EmpDtoVO;



public interface ChatDao {

	List<String> findmyRoomId(int empno);

	void createRoom(ChatRoomDto chatRoomDto);

	void saveMessage(ChatMessageDto chatMessage);

	int getMsgCnt(int empno);

	List<ChatRoomDto> getRoomList(int empno);

	void detailRoom(ChatMessageProc chatMessageProc);

	List<String> connectRoom(String roomId);

	void getEmpList(EmpDtoVO empDtoVo);

	void leaveRoom(ChatRoomInviteLeave chatRoomInviteLeave);

	void deleteRoom(String room_num);

	void inviteRoom(ChatRoomInviteLeave chatRoomInviteLeave);

}
