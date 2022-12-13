package com.oracle.devwareProject.domain;

import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
@Entity
public class EmpList 
{
	@Id
	private int emp_num; 			//사원 번호
	private String emp_name;		//사원 이름
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date emp_hireDate;	//사원 입사일
	
	private int dept_num; //부서 번호
	private int auth_num; //권한 번호
	private int status_num; //상태 번호
	private int position_num; //직위 번호
	
	//조회용
	@Transient
	private String msg; //결과 메시지
	
	@Transient
	private String emp_hire_date;
	
	@Transient
	private int result; //결과 상태창
}
