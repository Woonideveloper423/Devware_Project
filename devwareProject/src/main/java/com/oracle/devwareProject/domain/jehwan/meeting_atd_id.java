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
public class meeting_atd_id implements Serializable {
	private int emp_atd;
	private Long room_res;
}
