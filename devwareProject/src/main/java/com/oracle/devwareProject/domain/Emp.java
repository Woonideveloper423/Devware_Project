package com.oracle.devwareProject.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.oracle.devwareProject.domain.jehwan.MailAccount;

import lombok.Data;

@Data
@Entity
public class Emp 
{
	@Id
	private int emp_num; 		//사원 번호
	
	private String emp_name;	//사원 이름
	private String emp_id;		//사원 아이디
	private String emp_passwd;	//사원 비밀번호
	private String emp_address;		//사원 주소
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date emp_hireDate;	//사원 입사일
	
	private String emp_email;	//사원 이메일 
	private String emp_gender; //사원 성별
	
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "dept_num") 
	private Dept dept;
	
	@JsonIgnore  
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "auth_num") 
	private Authority auth;
	
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "status_num") 
	private Status status;
	
	@JsonIgnore  
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "position_num") 
	private Position position;

	//조회용
	@Transient
	private String msg; //결과 메시지
	
	@Transient
	private int result; //결과 상태창
	
	@Transient
	private int auth_num; //권한 
	
	@Transient
	private MailAccount mailAccount; //메일 있는지 체크 
}
