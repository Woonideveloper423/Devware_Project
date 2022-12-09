package com.oracle.devwareProject.dao.jiwoong;

import java.util.List;

import com.oracle.devwareProject.dto.jiwoong.Board;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;

public interface RestReplyDao {

	int insertReply(BoardEmpDept board);

	int totalReply(BoardEmpDept board);

	List<BoardEmpDept> getReplyList(BoardEmpDept board);

}
