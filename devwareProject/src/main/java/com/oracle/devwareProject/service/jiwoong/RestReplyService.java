package com.oracle.devwareProject.service.jiwoong;

import java.util.List;

import com.oracle.devwareProject.dto.jiwoong.Board;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;

public interface RestReplyService {

	int insertReply(BoardEmpDept board);

	int totalReply(BoardEmpDept board);

	List<BoardEmpDept> getListReply(BoardEmpDept board);

}
