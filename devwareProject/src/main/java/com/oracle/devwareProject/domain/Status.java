package com.oracle.devwareProject.domain;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class Status {
	@Id
	private int status_num;
	private String status_name;
}
