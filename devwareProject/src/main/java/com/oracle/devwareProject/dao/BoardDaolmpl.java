package com.oracle.devwareProject.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.model.Board;
import com.oracle.devwareProject.model.BoardEmp;

@Repository
public class BoardDaolmpl implements BoardDao {
	
	private final SqlSession session;
	
	@Autowired
	public BoardDaolmpl(SqlSession session) {
		this.session=session;
	}
	
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

}
