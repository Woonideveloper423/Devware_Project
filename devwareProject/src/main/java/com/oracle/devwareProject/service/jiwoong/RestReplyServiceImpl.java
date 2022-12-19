package com.oracle.devwareProject.service.jiwoong;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.jiwoong.RestReplyDao;
import com.oracle.devwareProject.dto.jiwoong.Board;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class RestReplyServiceImpl implements RestReplyService {

	private final RestReplyDao ad;

	@Override
	public int insertReply(BoardEmpDept board) { // 게시글 댓글작성 ajax
		System.out.println("RestReplyServiceImpl writeReply Start..");
		int insertCount =0;
		insertCount = ad.insertReply(board);
		System.out.println("RestReplyServiceImpl ad.writeReply(board)=>" +insertCount);
		return insertCount;
	}

	@Override
	public int totalReply(BoardEmpDept board) {
		System.out.println("AjaxReplyServiceImpl totalReply start");
		int totalReplyCnt = ad.totalReply(board);
		System.out.println("AjaxReplyServiceImpl ad.totalReply()=>" +totalReplyCnt);
		return totalReplyCnt;
	}

	@Override
	public List<BoardEmpDept> getListReply(BoardEmpDept board) {
		List<BoardEmpDept> replyList = null;
		log.info("getListReply start");
		replyList = ad.getReplyList(board);
		System.out.println("AjaxReplyServiceImpl getListReply replyList.size()=>" +replyList.size());
		return replyList;
	}

	
}