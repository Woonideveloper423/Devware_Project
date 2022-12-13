package com.oracle.devwareProject.dto.KiWoSu;

import java.util.Date;

import lombok.Data;

@Data
public class AllForApprove {
	//approve_progress 컬럼
	private int app_num;
	private String prg_num1;
	private String prg_name1;
	private int prg_auth1;
	private String prg_num2;
	private String prg_name2;
	private int prg_auth2;
	private String prg_num3;
	private String prg_name3;
	private int prg_auth3;
	private String prg_status;
	private Date prg_date;
	//반려사유
	private String prg_return;
	
	//approve 컬럼
	private String app_prg;
	private String app_start;
	private String app_end;
	private String app_title;
	private String app_content;
	private Date app_date;
	private int comu_type;
	private int comu_app;
	private int docs_type;
	private String docs_app;
	private int emp_num;
	
	//리스트 추가 목록
	private String emp_name;
	private String dept_name;
	private String dept_num;
	private String ca_content;
	
	private String position_name1;
	private String position_name2;
	private String position_name3;
	
	private String position_name;
}
