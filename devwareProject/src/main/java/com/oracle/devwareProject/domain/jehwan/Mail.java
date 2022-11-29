package com.oracle.devwareProject.domain.jehwan;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonBackReference;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Entity
@SequenceGenerator(	name = "mail_seq_gen",				  //객체 SEQ
					sequenceName = "mail_seq_generator", //DB SEQ
					initialValue = 1,
					allocationSize = 1
)
@Getter
@Setter
public class Mail {
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE,
	generator = "mail_seq_gen"		
	)
	private Long mail_num;
	private String sender_mail;
	private String sender_name;
	private String receiver_mail;
	private String receiver_name;
	private String mail_title;
	@Lob
	private String mail_content;
	private Long read_chk;
	private Long delete_chk;
	private Date mail_date;
	
	@OneToMany(mappedBy = "mail", cascade = CascadeType.ALL)
	@JsonBackReference
	private List<MailAttach> mailAttachs = new ArrayList<MailAttach>();
	
	
	@OneToMany(mappedBy = "mail", cascade = CascadeType.ALL)
	@JsonBackReference
	private List<MailImportant> mailImportants = new ArrayList<MailImportant>();
	

	public void addMailAttach(MailAttach mailAttach) {
		mailAttachs.add(mailAttach);
		mailAttach.setMail(this);
	}
	
	@Transient
	private Long isImportant;
	@Transient
	private Long emp_num;
	//첨부파일
	@Transient
	private MultipartFile[] uploadFile;
	
	
}
