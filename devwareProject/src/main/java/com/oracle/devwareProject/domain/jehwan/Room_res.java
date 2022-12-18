package com.oracle.devwareProject.domain.jehwan;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.Emp;

import lombok.Getter;
import lombok.Setter;

@Entity
@SequenceGenerator(	name = "res_seq_gen",				  //객체 SEQ
					sequenceName = "res_seq_generator", //DB SEQ
					initialValue = 1,
					allocationSize = 1
)
@Getter
@Setter
public class Room_res {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE,
	generator = "res_seq_gen"		
	)
	private Long res_num;
	private String res_name;
	private String res_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date res_start;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date res_end;
	private String res_cancel;
	private Long res_amount;
	private String meeting_info;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "emp_num") 
	private Emp emp;

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "room_num") 
	private Room_info room_info;
	
	@OneToMany(mappedBy = "room_res", cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonBackReference
	private List<Meeting_atd> Meeting_atds = new ArrayList<Meeting_atd>();
	
	
	@Transient
	private List<Meeting_atd_vo> Meeting_atd_vos;
	
	
	@Transient
	private List<String> memNums;
	
	@Transient
	private int emp_num;
	
	@Transient
	private Long room_num;
}
