package com.oracle.devwareProject.dto.jiwoong;



import java.util.List;

import lombok.Data;

//	사원번호에 해당하는 사원 id를 작성자로 가져오기 join 목적
@Data
public class BoardEmpDept {
	
		//brd_type -> 게시판 구분용 속성 1=>사내  2=>소속팀   3=>Q&A	4=>스터디&소모임
		private int    emp_num;			
		private int	   brd_type;		private int brd_num;
		private String brd_title;		private String brd_content;
		private String brd_date;		private int brd_view;
		private int brd_deleteYn;
		private int	   brd_ref;			private int brd_re_step;
		private int	   brd_re_level;	private int qa_status;
		private int    reply_cnt;
		
		private String emp_name;		private int dept_num;       
		private String emp_id;			private int auth_num;
		private int status_num;   	    private String emp_gender;	 
		
		
		private String dept_name;
	
		// 조회용
		private String searchType;			private String keyword;
		private String pageNum;				private int rn;	 // 글번호용
		private int    start;				private int end;
		
		private String arrayType; // 게시물 정렬
		private int brd_re_step_max;
		
		private List<BoardAttach> boardAttachs;
		
	
	
		
		
		
}
