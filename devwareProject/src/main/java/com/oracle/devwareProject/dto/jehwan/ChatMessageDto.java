package com.oracle.devwareProject.dto.jehwan;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@AllArgsConstructor
public class ChatMessageDto {
	private int room_num;
	private int emp_num;
	private String member_name;
	private int log_num;
	private int msg_type;
	private String msg_content;
	private String attach_name;
	private Date send_date;
	private int not_read_cnt;
	private List<String> look_member;
	public ChatMessageDto(int room_num,int emp_num,int msg_type, String msg_content) {
		this.room_num = room_num;
		this.emp_num = emp_num;
		this.msg_type = msg_type;
		this.msg_content = msg_content;
	}
	
	public ChatMessageDto(int room_num,int emp_num,String member_name,int log_num ,int msg_type, String msg_content, String attach_name, Date send_date, int not_read_cnt) {
		this.room_num = room_num;
		this.emp_num = emp_num;
		this.member_name = member_name;
		this.msg_type = msg_type;
		this.msg_content = msg_content;
		this.attach_name = attach_name;
		this.send_date = send_date;
		this.not_read_cnt = not_read_cnt;
	}
	
}
