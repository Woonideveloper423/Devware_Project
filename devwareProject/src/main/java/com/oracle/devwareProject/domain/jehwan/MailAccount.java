package com.oracle.devwareProject.domain.jehwan;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

import lombok.Data;

@Data
@Entity
@Table(name = "mail_account")
public class MailAccount {
	
	@Id
	private Long emp_num;
	private String mail_id;
	private String mail_pw;
	

}
