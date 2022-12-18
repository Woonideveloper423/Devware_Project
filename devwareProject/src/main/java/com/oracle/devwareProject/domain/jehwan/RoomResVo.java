package com.oracle.devwareProject.domain.jehwan;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class RoomResVo {
	private Long id;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date start;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date fin;
	private String title;
	private int emp_num;
	private Long room_num;
	private String[] res_emp_nums;
	private List<Meeting_atd_vo> meeting_atd_vos;
	private String color;
	
	public RoomResVo(Long res_num, Date res_start, Date res_end, String meeting_info, int emp_num) {
		this.id = res_num;
		this.start = res_start;
		this.fin = res_end;
		this.title = meeting_info;
		this.emp_num = emp_num;
	}
}
