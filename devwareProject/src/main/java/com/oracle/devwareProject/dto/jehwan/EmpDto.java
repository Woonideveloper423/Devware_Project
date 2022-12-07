package com.oracle.devwareProject.dto.jehwan;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class EmpDto {
	private int emp_num;
	private String emp_name;

	public EmpDto(int emp_num) {
		this.emp_num = emp_num;
	}

}
