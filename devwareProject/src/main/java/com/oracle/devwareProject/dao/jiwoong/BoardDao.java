package com.oracle.devwareProject.dao.jiwoong;


import java.util.List;
import java.util.Map;


import com.oracle.devwareProject.dto.jiwoong.Board;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;


public interface BoardDao {
	
	int boardInsert(BoardEmpDept bEmp);
	
	int checkListTotalCnt(BoardEmpDept bEmp);
	
	List<BoardEmpDept> boardCheckList(BoardEmpDept bEmp);
	

	BoardEmpDept detailBoard(BoardEmpDept bEmpDept);

	int brdViewUpdate(BoardEmpDept bEmpDept);

	int brdDelete(BoardEmpDept bEmpDept);

	}
