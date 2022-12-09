package com.oracle.devwareProject.dto.KiWoSu;

import java.util.Date;

import lombok.Data;

@Data
public class Approve_Progress {
	private int app_num;
	private String prg_num1;
	private String prg_name1;
	private String prg_num2;
	private String prg_name2;
	private String prg_num3;
	private String prg_name3;
	private String prg_status;
	private Date prg_date;
	//반려사유
	private String prg_return;
}
