package com.oracle.devwareProject.dao.jiwoong;


import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.oracle.devwareProject.dto.jiwoong.Board;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDaolmpl implements BoardDao {
	
	private final SqlSession session;
	
	@Override
	public int boardInsert(BoardEmpDept bEmp) {
		System.out.println("BoardDaolmpl boardInsert Start...");
		int brdInsertCnt = 0;
		try {
			System.out.println(bEmp);
			
			brdInsertCnt=session.insert("jwBoardInsert",bEmp);
			
		} catch (Exception e) {
			System.out.println("BoardDaolmpl insertBoard Exception=>" +e.getMessage());
		}
		return brdInsertCnt;
	}
	
	@Override
	public int checkListTotalCnt(BoardEmpDept bEmp) {
		System.out.println("BoardDaolmpl checkListTotalCnt start");
		int checkListTotalCnt=0;
		try {
			System.out.println(bEmp);
			
			checkListTotalCnt=session.selectOne("jwcheckListTotal",bEmp);
			
		} catch (Exception e) {
			System.out.println("BoardDaolmpl checkListTotalCnt Exception=>"+e.getMessage());
		}
		System.out.println("BoardDaolmpl checkListTotalCnt=>" + checkListTotalCnt);
		return checkListTotalCnt;
	}
	
	@Override
	public List<BoardEmpDept> boardCheckList(BoardEmpDept bEmp) {
		System.out.println("BoardDaolmpl boardCheckList start");
		List<BoardEmpDept> brdCheckList = null;
		try {
			brdCheckList = session.selectList("jwBrdCheckList",bEmp);
		} catch (Exception e) {
			System.out.println("BoardDaolmpl boardCheckList Exception=>" +e.getMessage());
		}
		return brdCheckList;
	}
	
	
	// 게시물 상세조회
	@Override
	public Board detailBoard(Map<String, Object> map) {
		System.out.println("BoardDaolmpl detailBoard start...");
		Board board =null; 
		try {
			board=session.selectOne("jwBoardSelOne",map);
			System.out.println("board.getEmp_num()=>"+board.getEmp_num());
			System.out.println("board.getBrd_type()=>"+board.getBrd_type());
			System.out.println("board.getBrd_num()=>"+board.getBrd_num());
		} catch (Exception e) {
			System.out.println("BoardDaolmpl detailBoard Exception=>" +e.getMessage());
		}
		
		return board;
	}

	
	



	


	






	


	
}
