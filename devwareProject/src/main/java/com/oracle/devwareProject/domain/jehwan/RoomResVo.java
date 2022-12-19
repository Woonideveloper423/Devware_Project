package com.oracle.devwareProject.domain.jehwan;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class RoomResVo {
	private Long id;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+9")
	private LocalDateTime start;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+9")
	private LocalDateTime fin;
	private String title;
	private int emp_num;
	private Long room_num;
	private String[] res_emp_nums;
	private List<Meeting_atd_vo> meeting_atd_vos;
	private String color;
	
	public RoomResVo(Long res_num, LocalDateTime res_start, LocalDateTime res_end, String meeting_info, int emp_num) {
		this.id = res_num;
		this.start = res_start;
		this.fin = res_end;
		this.title = meeting_info;
		this.emp_num = emp_num;
	}
}
