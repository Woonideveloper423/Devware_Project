package com.oracle.devwareProject.dao.jiwoong;

import java.util.List;

import com.oracle.devwareProject.dto.jiwoong.Board;

public interface RestReplyDao {

	int insertReply(Board board);

	int totalReply(Board board);

	List<Board> getReplyList(Board board);

}
