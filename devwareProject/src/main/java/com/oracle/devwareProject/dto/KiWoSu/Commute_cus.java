package com.oracle.devwareProject.dto.KiWoSu;

import java.util.Date;

import lombok.Data;

@Data
public class Commute_cus {
	private int com_num;
	private int emp_num;
	private int cus_seq;
	private String cus_start;
	private String cus_end;
	private String cus_detail;
	private String cus_cus;
	// 조회용
	private String com_workTime; // 근무시간  
	private String com_lateTime; // 지각시간  
}
