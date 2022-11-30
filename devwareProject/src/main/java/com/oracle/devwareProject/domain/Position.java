package com.oracle.devwareProject.domain;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data
public class Position {
	@Id
	private int position_num;
	private String position_name;
	
}
