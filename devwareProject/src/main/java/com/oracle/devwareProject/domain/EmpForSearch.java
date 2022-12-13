package com.oracle.devwareProject.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EmpForSearch 
{
	private int emp_num; 		//사원 번호
	private String emp_name;	//사원 이름
	private String emp_id;		//사원 아이디
	private String emp_address; //사원 주소
	private String emp_passwd; //사원 비밀번호
	private Date emp_hireDate;	//사원 입사일
	private String emp_email;	//사원 이메일 
	private String emp_gender; //사원 성별
	
	private int dept_num;		//부서 번호
	private String dept_name;	//부서 이름
	
	private int auth_num;		//권한 번호
	private String auth_name;	//권한 이름
	
	private int position_num;		//직위 번호
	private String position_name;	//직위 이름
	
	private int status_num;		//상태 번호
	private String status_name;	//상태 이름
	
	private Long permit_status; //허용요청
}	
