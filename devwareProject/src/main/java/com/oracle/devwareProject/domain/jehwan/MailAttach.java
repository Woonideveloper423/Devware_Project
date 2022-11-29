package com.oracle.devwareProject.domain.jehwan;




import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import lombok.Data;
import lombok.NoArgsConstructor;





@Data
@IdClass(MailAttachID.class)
@Entity
@NoArgsConstructor
@Table(name = "mail_attach")
public class MailAttach {
	
	
	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	@JsonManagedReference
	@JoinColumn(name = "mail_num")
	private Mail mail;
	
	@Id
	private Long mail_attach_num;
	
	private String mail_attach_save_path;
	private String mail_attach_save_name;
	private String mail_attach_real_name;
	
	
}





