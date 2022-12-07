package com.oracle.devwareProject.dto.jehwan;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ChatRoomDto {

	private int room_num;
	private String room_title;
	
	private List<String> emp_list;
	private String last_msg;
	private String last_sender;
	private Date last_msg_date;
	private int not_read_cnt;
	public ChatRoomDto(String room_title, List<String>emp_list){
		this.room_title = room_title;
		this.emp_list = emp_list;
	}
	
	public ChatRoomDto(int room_num, String room_title,String last_sender, String last_msg, Date last_msg_date, String not_read_cnt){
		this.room_num = room_num;
		this.room_title = room_title;
		this.last_sender = last_sender;
		this.last_msg = last_msg;
		this.last_msg_date = last_msg_date;
		System.out.println("not_read_cnt->" + not_read_cnt);
		if(not_read_cnt != null) {
			this.not_read_cnt = Integer.parseInt(not_read_cnt);
		}else {
			this.not_read_cnt = 0;
		}
	}
	
}
