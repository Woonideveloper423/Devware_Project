package com.oracle.devwareProject.domain;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data
public class Dept {
	@Id
	private int dept_num;
	private String dept_name;
}
