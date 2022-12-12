package com.oracle.devwareProject.dao.jiwoong;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;



@Repository
@RequiredArgsConstructor
@Slf4j
public class BoardDaolmpl implements BoardDao {
	
	private final SqlSession session;
	
	@Override
	public int boardInsert(BoardEmpDept bEmp) {
		log.info("boardInsert Start");
		int brdInsertCnt = 0;
		try {
			brdInsertCnt=session.insert("jwBoardInsert",bEmp);
		log.info("brdInsertCnt:"+brdInsertCnt);	
		} catch (Exception e) {
			log.info("Exception=>" +e.getMessage());
		}
		return brdInsertCnt;
	}
	
	@Override
	public int checkListTotalCnt(BoardEmpDept bEmp) {
		log.info("checkListTotalCnt start");
		int checkListTotalCnt=0;
		try {
			checkListTotalCnt=session.selectOne("jwcheckListTotal",bEmp);
			log.info("checkListTotalCnt:" +checkListTotalCnt);
		} catch (Exception e) {
			log.info(" Exception=>"+e.getMessage());
		}
		return checkListTotalCnt;
	}
	
	@Override
	public List<BoardEmpDept> boardCheckList(BoardEmpDept bEmp) {
		System.out.println("BoardDaolmpl boardCheckList start");
		List<BoardEmpDept> brdCheckList = null;
		try {
			brdCheckList = session.selectList("jwBrdCheckList",bEmp);
			System.out.println(brdCheckList.size());
		} catch (Exception e) {
			System.out.println("BoardDaolmpl boardCheckList Exception=>" +e.getMessage());
		}
		return brdCheckList;
	}
	
	// 게시물 상세조회
	@Override
	public BoardEmpDept detailBoard(BoardEmpDept bEmpDept) {
		log.info("detailBoard start");
		BoardEmpDept boardinfo =null; 
		try {
			boardinfo=session.selectOne("jwBoardSelOne",bEmpDept);
			log.info("boardinfo.getEmp_num()=>"+boardinfo.getEmp_num());
			log.info("boardinfo.getBrd_type()=>"+boardinfo.getBrd_type());
			log.info("boardinfo.getBrd_num()=>"+boardinfo.getBrd_num());
		} catch (Exception e) {
			log.info("Exception=>" +e.getMessage());
		}
		return boardinfo;
	}

	@Override
	public int brdViewUpdate(BoardEmpDept bEmpDept) {
		log.info("brdViewUpdate start");
		int viewUpdateCnt=0;
		try {
			viewUpdateCnt=session.update("jwViewUpdate",bEmpDept);
			log.info("viewUpdateCnt:" +viewUpdateCnt);
		} catch (Exception e) {
			log.info("Exception:" +e.getMessage());
		}
		return viewUpdateCnt;
	}

	@Override
	public int brdDelete(BoardEmpDept bEmpDept) {
		log.info("brdDelete start");
		int brdDeleteCnt=0;
		try {
			brdDeleteCnt=session.update("jwBoardDelete",bEmpDept);
		} catch (Exception e) {
			log.info("Exception:" +e.getMessage());
		}
		return 0;
	}

	@Override
	public int brdUpdate(BoardEmpDept bEmpDept) {
		log.info("brdUpdate start");
		int brdUpdateCnt=0;
		try {
			brdUpdateCnt=session.update("jwBoardUpdate",bEmpDept);
			log.info("brdUpdateCnt:"+brdUpdateCnt);
		} catch (Exception e) {
			log.info("Exception:"+e.getMessage());
		}
		return brdUpdateCnt;
	}
}
