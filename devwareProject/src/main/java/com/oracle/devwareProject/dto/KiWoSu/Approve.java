package com.oracle.devwareProject.dto.KiWoSu;

import java.util.Date;

import lombok.Data;

@Data
public class Approve {
	private int app_num;
	private String app_prg;
	private String app_start;
	private String app_end;
	private String app_title;
	private String app_content;
	private Date app_date;
	private int comu_type;
	private String comu_app;
	private int docs_type;
	private String docs_app;
	private int emp_num;
	
	
	//리스트 조회용
	private String search;   	private String keyword;
	private String pageNum;  
	private int start; 		 	private int end;
	private int rn;
	
	//리스트 추가 목록
	private String emp_name;
	private String ca_content;
}
