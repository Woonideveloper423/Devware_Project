package com.oracle.devwareProject.domain.jehwan;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.oracle.devwareProject.domain.Emp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@IdClass(meeting_atd_id.class)
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Meeting_atd {
	@Id
	@ManyToOne
	@JsonManagedReference
	@JoinColumn(name = "res_num")
	private Room_res room_res;
	
	@Id
	@ManyToOne
	@JoinColumn(name = "emp_num")
	private Emp emp_atd;
}
