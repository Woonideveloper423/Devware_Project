package com.oracle.devwareProject.service.jiwoong;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.dto.jiwoong.Board;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;


public interface BoardService {

	int brdInsert(BoardEmpDept bEmp);
	
	int brdInsert(HttpSession session, BoardEmpDept bEmp,MultipartFile[] files); 
	
	int checkListTotalCnt(BoardEmpDept bEmp);
	
	List<BoardEmpDept> boardCheckList(BoardEmpDept bEmp);
	
	void detailBoard(BoardEmpDept bEmpDept);

	int brdDelete(BoardEmpDept bEmpDept);

	int brdUpdate(BoardEmpDept bEmpDept);

	



	

	



	



}
