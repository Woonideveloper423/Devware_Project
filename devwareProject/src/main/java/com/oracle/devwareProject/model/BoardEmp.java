package com.oracle.devwareProject.model;

import lombok.Data;

//	사원번호에 해당하는 사원 id를 작성자로 가져오기 join 목적
@Data
public class BoardEmp {
	// Board
	private int	   brd_type;		private int brd_num;
	private String brd_title;		private String brd_content;
	private String brd_date;		private int brd_view;
	private int    brd_hit;			private int brd_deleteYn;
	private int	   brd_ref;			private int brd_re_step;
	private int	   brd_re_level;	private char qa_status;
	
	// Emp
	private int    emp_num;			private String emp_name;
	private int    emp_id;
	
}
