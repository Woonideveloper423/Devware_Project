package com.oracle.devwareProject.dto.jiwoong;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class File {

	private long file_num;  private int  brd_type;	
	
	private	int brd_num;	private int   emp_num;
	
	private String file_original_name;  private String file_save_name; 
	
	private long file_size; 	private String file_deleteYn;	
	
	private LocalDateTime insert_date;  private LocalDateTime delete_date;
	
	
	private int dept_num;  // 부서게시판 타겟 join 용
}
