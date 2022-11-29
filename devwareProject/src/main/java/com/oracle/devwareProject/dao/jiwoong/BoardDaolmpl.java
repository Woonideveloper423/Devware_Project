package com.oracle.devwareProject.dao.jiwoong;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.model.jiwoong.Board;
import com.oracle.devwareProject.model.jiwoong.BoardEmp;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDaolmpl implements BoardDao {
	
	private final SqlSession session;
	
	@Override
	public int writeBoard(Board board) {
		System.out.println("BoardDaolmpl insertBoard Start...");
		int insertCount = 0;
		try {
			System.out.println(board.getBrd_type());
			System.out.println("BoardDaolmpl /writeBoard board parameter=>" +board);
			insertCount=session.insert("insertBoard",board);
			
		} catch (Exception e) {
			System.out.println("BoardDaolmpl insertBoard Exception=>" +e.getMessage());
		}
		return insertCount;
	}

	
	
	@Override
	public List<Board> listTypeBoard(Board board) {
		List<Board> typeBrdList = null;
		System.out.println("BoardDaolmpl listTypeBoard Start...");
		try {
			typeBrdList=session.selectList("jwTypeBrdList",board);
			System.out.println("BoardDaolmpl listTypeBoard typeBrdList.size()-->" +typeBrdList.size());
		} catch (Exception e) {
			System.out.println("BoardDaolmpl listTypeBoard Exception-->" +e.getMessage());
		}
		
		return typeBrdList;
	}

	@Override
	public int totalTypeBoard(int brd_type) {
		 int totalTypeBrdCnt =0; 
		 System.out.println("BoardDaolmpl totalTypeBoard start...");
		try {
			totalTypeBrdCnt = session.selectOne("jwTypeBrdTotal",brd_type);
			System.out.println("BoardDaolmpl totalTypeBoard totalTypeBrdCnt-->+totalTypeBrdCnt");
		} catch (Exception e) {
			System.out.println("BoardDaolmpl totalTypeBoard Exception-->"+e.getMessage()); 
		}
		return  totalTypeBrdCnt;
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
