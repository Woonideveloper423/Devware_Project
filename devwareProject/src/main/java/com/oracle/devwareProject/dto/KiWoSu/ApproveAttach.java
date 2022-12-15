package com.oracle.devwareProject.dto.KiWoSu;

import java.time.LocalDateTime;
import java.util.Date;

import lombok.Data;


@Data
public class ApproveAttach {
	private int file_num;
	
	private	int app_num;
	
	private String file_oriname;  private String file_name; 
	
	private Date file_date;

}
