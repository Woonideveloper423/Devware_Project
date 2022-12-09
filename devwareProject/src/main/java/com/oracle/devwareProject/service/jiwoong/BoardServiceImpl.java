package com.oracle.devwareProject.service.jiwoong;


import java.util.List;


import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.jiwoong.BoardDao;


import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
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
	public BoardEmpDept detailBoard(BoardEmpDept bEmpDept) {
		log.info("BoardServiceImpl detailBoard Start");
		int viewUpdateCnt=0;
		BoardEmpDept boardInfo=null;
		// 게시글 조회수 증가 service
		viewUpdateCnt=bd.brdViewUpdate(bEmpDept);
		log.info("viewUpdateCount:" +viewUpdateCnt);
		// 게시글 상세조회 service
		boardInfo = bd.detailBoard(bEmpDept);
		
		return boardInfo;
	}

	@Override
	public int brdDelete(BoardEmpDept bEmpDept) {
		log.info("brdDelete start");
		int brdDeleteCnt = 0;
		brdDeleteCnt=bd.brdDelete(bEmpDept);
		log.info("brdDeleteCnt:" +brdDeleteCnt);
		return brdDeleteCnt;
	}

	

	




	

	

	


	
}
