package com.oracle.devwareProject.service.jiwoong;

import java.util.List;

import com.oracle.devwareProject.dto.jiwoong.Board;

public interface RestReplyService {

	int insertReply(Board board);

	int totalReply(Board board);

	List<Board> getListReply(Board board);

}
