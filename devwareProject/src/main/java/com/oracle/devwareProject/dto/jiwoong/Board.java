package com.oracle.devwareProject.dto.jiwoong;

import lombok.Data;

@Data
public class Board {
    
	//brd_type -> 게시판 구분용 속성 1=>사내  2=>소속팀   3=>Q&A	4=>스터디&소모임
	// 사원번호 조회용
	private int    emp_num;			
	private int	   brd_type;		private int brd_num;
	private String brd_title;		private String brd_content;
	private String brd_date;		private int brd_view;
	private int brd_deleteYn;
	private int	   brd_ref;			private int brd_re_step;
	private int	   brd_re_level;	private int qa_status;
	private int    reply_cnt;		
	
	// 부서 조회용
	private int dept_num;
	// 조회용
	private String searchType;			private String keyWord;
	private String pageNum;			
	private int    start;			private int end;
	
	// brd_re_step max setting
	private int brd_re_step_max;
}
