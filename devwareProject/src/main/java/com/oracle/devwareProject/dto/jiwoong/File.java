package com.oracle.devwareProject.dto.jiwoong;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class File {

	private int   emp_num;	private	int brd_num;	
	
	private int  brd_type;	private String file_upload_name;
	
	private long file_num;	private String file_save_name; 
	
	private long file_size; private String file_deleteYn;
	
	private LocalDateTime insert_date;	private LocalDateTime delete_date;
}
