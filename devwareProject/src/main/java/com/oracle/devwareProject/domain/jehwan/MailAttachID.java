package com.oracle.devwareProject.domain.jehwan;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@NoArgsConstructor
@Getter
@EqualsAndHashCode
public class MailAttachID implements Serializable {
	private Long mail;
	private Long mail_attach_num;
}
