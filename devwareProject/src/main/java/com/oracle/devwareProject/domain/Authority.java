package com.oracle.devwareProject.domain;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class Authority {
	@Id
	private int auth_num;
	private String auth_name;
}
