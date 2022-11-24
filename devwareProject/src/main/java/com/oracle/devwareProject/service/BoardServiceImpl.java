package com.oracle.devwareProject.service;


import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.BoardDao;
import com.oracle.devwareProject.model.Board;
import com.oracle.devwareProject.model.BoardEmp;

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

}
