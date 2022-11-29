package com.oracle.devwareProject.service.jiwoong;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.jiwoong.BoardDao;
import com.oracle.devwareProject.model.jiwoong.Board;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardDao bd;
	
	@Override
	public int writeBoard(Board board) {
		System.out.println("BoardServiceImpl writeBoard Start...");
		System.out.println("BoardServiceImpl /writeBoard board parameter=>" +board);
		int insertCount=0;
		insertCount=bd.writeBoard(board);
		System.out.println("BoardServiceImpl bd.insertBoard insertCount=>" +insertCount);
		return insertCount;
	}
	
	// 게시판 유형별 게시물 총 개수 return method  
	@Override
	public int totalTypeBoard(int brd_type) {
		System.out.println("BoardServiceImpl totalTypeBoard start...");
		int totalTypeBrdCnt = bd.totalTypeBoard(brd_type);
		System.out.println("BoardServiceImpl totalTypeBoard totalTypeBrdCnt-->" +totalTypeBrdCnt);
		return totalTypeBrdCnt;
	}
	
	@Override
	public List<Board> listTypeBoard(Board board) {
		List<Board> typeBrdList = null;
		System.out.println("BoardServiceImpl listTypeBoard Start...");
		typeBrdList = bd.listTypeBoard(board);
		System.out.println("BoardServiceImpl listTypeBoard typeBrdList.size()-->" +typeBrdList.size());
		return typeBrdList;
	}

	@Override
	public Board detailBoard(Map<String, Object> map) {
		System.out.println("BoardServiceImpl detailBoard Start...");
		Board board=null;
		board = bd.detailBoard(map);
		
		return board;
	}
	

	


	
}
