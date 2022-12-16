package com.oracle.devwareProject.dto.jiwoong;

import java.time.LocalDateTime;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardAttach {
private long file_num;  private int  brd_type;	
		
		private	int brd_num;	private int   emp_num;
		
		private String file_original_name;  private String file_save_name; 
		
		private long file_size; 	private String file_deleteYn;	
		
		private LocalDateTime insert_date;  private LocalDateTime delete_date;
		
		
		private int dept_num;  // 부서게시판 타겟 join 용
		
		public BoardAttach(String file_original_name,String file_save_name) {
			this.file_original_name=file_original_name;
			this.file_save_name=file_save_name;
		}
	
}
