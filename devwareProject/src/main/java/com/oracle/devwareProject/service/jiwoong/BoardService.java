package com.oracle.devwareProject.service.jiwoong;


import java.util.List;
import java.util.Map;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.dto.jiwoong.Board;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;


public interface BoardService {

	int brdInsert(BoardEmpDept bEmp); 
	
	int checkListTotalCnt(BoardEmpDept bEmp);
	
	List<BoardEmpDept> boardCheckList(BoardEmpDept bEmp);
	
	BoardEmpDept detailBoard(BoardEmpDept bEmpDept);

	int brdDelete(BoardEmpDept bEmpDept);

	int brdUpdate(BoardEmpDept bEmpDept);

	



	

	



	



}
