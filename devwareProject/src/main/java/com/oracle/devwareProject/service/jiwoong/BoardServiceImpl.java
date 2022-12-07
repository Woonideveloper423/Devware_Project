package com.oracle.devwareProject.service.jiwoong;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.jiwoong.BoardDao;

import com.oracle.devwareProject.dto.jiwoong.Board;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardDao bd;
	
	@Override
	public int brdInsert(BoardEmpDept bEmp) {
		System.out.println("BoardServiceImpl brdInsert start");
		int brdInsertCnt = bd.boardInsert(bEmp);
		System.out.println("BoardServiceImpl brdInsertCnt=>" +brdInsertCnt);
		return brdInsertCnt;
	}
	
	@Override
	public int checkListTotalCnt(BoardEmpDept bEmp) {
		System.out.println("BoardServiceImpl checkListTotalCnt start");
		int checkListTotalCnt =bd.checkListTotalCnt(bEmp);
		System.out.println("BoardServiceImpl checkListTotalCnt=>" +checkListTotalCnt);
		return checkListTotalCnt;
	}
	
	@Override
	public List<BoardEmpDept> boardCheckList(BoardEmpDept bEmp) {
		System.out.println("BoardServiceImpl boardCheckList start");
		List<BoardEmpDept> brdCheckList = bd.boardCheckList(bEmp);
		return brdCheckList;
		}
	
	@Override
	public Board detailBoard(Map<String, Object> map) {
		System.out.println("BoardServiceImpl detailBoard Start...");
		Board board=null;
		board = bd.detailBoard(map);
		
		return board;
	}

	

	




	

	

	


	
}
