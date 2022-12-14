package com.oracle.devwareProject.domain.jehwan;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MapsId;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.oracle.devwareProject.domain.Emp;

import lombok.Data;

@Data
@Entity
@Table(name = "mail_account")
public class MailAccount {
	
	@Id
	private int emp_num;
	
//	@OneToOne(fetch = FetchType.EAGER)
//	@MapsId //@MapsId 는 @id로 지정한 컬럼에 @OneToOne 이나 @ManyToOne 관계를 매핑시키는 역할
//	@JoinColumn(name = "emp_num")
//	private Emp emp;

	
	
	private Long permit_status;

}
