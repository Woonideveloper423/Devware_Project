package com.oracle.devwareProject.dto.jehwan;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmpDtoVO {
	private int emp_num;
	private String room_num;
	private int type;
	
	private List<EmpDto> empDtos;
}
