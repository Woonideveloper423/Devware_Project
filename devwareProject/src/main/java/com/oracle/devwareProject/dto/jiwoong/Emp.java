package com.oracle.devwareProject.dto.jiwoong;

import java.util.Date;

import lombok.Data;

@Data
public class Emp {
	
			
	private int emp_num; 		private String emp_name;	
				
	private String emp_id;		private String emp_passwd;

	private String emp_address;	private Date emp_hireDate;		
	
	private String emp_email;	private String emp_gender; 
	
	private int dept_num;       private int position_num;
	
	private int status_name;    private int auth_num;
	
	// 부서이름 조회용
	
	private String dept_name;
	
	
	
	
	
	
}
