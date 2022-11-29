package com.oracle.devwareProject.domain.jehwan;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@IdClass(MailImportantID.class)
@Data
@NoArgsConstructor
public class MailImportant {

	
	@Id
	@ManyToOne
	@JoinColumn(name = "emp_num")
	private MailAccount mailAccount;
	
	@Id
	@ManyToOne
	@JsonManagedReference
	@JoinColumn(name = "mail_num")
	private Mail mail;
	

}
