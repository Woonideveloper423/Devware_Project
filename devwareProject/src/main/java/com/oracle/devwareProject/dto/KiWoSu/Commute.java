package com.oracle.devwareProject.dto.KiWoSu;

import java.util.Date;

import lombok.Data;

@Data
public class Commute {
	private String com_num;
	private int emp_num;
	private Date com_date;
	private String com_start;
	private String com_end;
	// 조회용
	private String com_workTime; // 근무시간  
	private String com_lateTime; // 지각시간  
}
