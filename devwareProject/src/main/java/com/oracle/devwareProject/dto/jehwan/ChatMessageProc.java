package com.oracle.devwareProject.dto.jehwan;

import java.util.List;

import lombok.Data;

@Data
public class ChatMessageProc {
	private int p_room_num;
	private int p_emp_num;
	private List<String> readMsg;
	private List<ChatMessageDto> chatMessageDtos;
}


