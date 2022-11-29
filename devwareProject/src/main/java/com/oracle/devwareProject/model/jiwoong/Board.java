package com.oracle.devwareProject.model.jiwoong;

import lombok.Data;

@Data
public class Board {
    
	//brd_type -> 게시판 구분용 속성 1=>사내  2=>소속팀   3=>Q&A	4=>스터디&소모임
	private int    emp_num;			
	private int	   brd_type;		private int brd_num;
	private String brd_title;		private String brd_content;
	private String brd_date;		private int brd_view;
	private int    brd_hit;			private int brd_deleteYn;
	private int	   brd_ref;			private int brd_re_step;
	private int	   brd_re_level;	private int qa_status;
	
	// 조회용
	private String search;			private String keyword;
	private String pageNum;			
	private int    start;			private int end;
	private String emp_name;		private String dept_name;
}
