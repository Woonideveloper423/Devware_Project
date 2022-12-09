package com.oracle.devwareProject.dto.jiwoong;

import java.util.List;

import com.oracle.devwareProject.service.jiwoong.Paging;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BoardEmpDeptVo {
	

	List<BoardEmpDept> brdCheckList;
	Paging page;
	
	private String searchType;		private String keyword;	
	private String pageNum;			private int end;
	private int    start;			
	
	
}
