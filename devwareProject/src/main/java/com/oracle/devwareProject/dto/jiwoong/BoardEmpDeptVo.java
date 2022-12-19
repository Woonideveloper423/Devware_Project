package com.oracle.devwareProject.dto.jiwoong;

import java.util.List;

import com.oracle.devwareProject.service.jiwoong.Paging;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class BoardEmpDeptVo {
	

	List<BoardEmpDept> brdCheckList;
	Paging page;
	
	private String searchType;		private String keyword;	
	private String pageNum;			private int end;
	private int    start;			private String arrayType;

	
}
