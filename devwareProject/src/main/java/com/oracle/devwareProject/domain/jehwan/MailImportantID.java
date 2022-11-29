package com.oracle.devwareProject.domain.jehwan;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@Getter
@AllArgsConstructor
@EqualsAndHashCode
public class MailImportantID implements Serializable {
	private Long mail;
	private Long mailAccount;
}
