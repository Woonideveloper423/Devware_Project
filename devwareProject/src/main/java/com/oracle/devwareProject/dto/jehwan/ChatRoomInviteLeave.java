package com.oracle.devwareProject.dto.jehwan;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class ChatRoomInviteLeave {
	private String emp_num;
	private String room_num;
	private List<String> invite_emp;
	
	public ChatRoomInviteLeave(String emp_num, String room_num) {
		this.emp_num = emp_num;
		this.room_num = room_num;
	}
	
	public ChatRoomInviteLeave(String room_num, List<String> invite_emp) {
		this.room_num = room_num;
		this.invite_emp = invite_emp;
	}
}
