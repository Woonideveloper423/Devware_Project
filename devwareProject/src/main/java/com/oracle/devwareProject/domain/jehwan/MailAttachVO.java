package com.oracle.devwareProject.domain.jehwan;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class MailAttachVO {
	private Long mail_num;
	private Long mail_attach_num;
	private String mail_attach_save_path;
	private String mail_attach_save_name;
	private String mail_attach_real_name;
}
