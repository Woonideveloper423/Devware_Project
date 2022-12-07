package com.oracle.devwareProject.service.jiwoong;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.jiwoong.RestReplyDao;
import com.oracle.devwareProject.dto.jiwoong.Board;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RestReplyServiceImpl implements RestReplyService {

	private final RestReplyDao ad;

	@Override
	public int insertReply(Board board) { // 게시글 댓글작성 ajax
		System.out.println("AjaxServiceImpl writeReply Start..");
		int insertCount =0;
		insertCount = ad.insertReply(board);
		System.out.println("AjaxServiceImpl ad.writeReply(board)=>" +insertCount);
		return insertCount;
	}

	@Override
	public int totalReply(Board board) {
		System.out.println("AjaxReplyServiceImpl totalReply start");
		int totalReplyCnt = ad.totalReply(board);
		System.out.println("AjaxReplyServiceImpl ad.totalReply()=>" +totalReplyCnt);
		return totalReplyCnt;
	}

	@Override
	public List<Board> getListReply(Board board) {
		List<Board> replyList = null;
		System.out.println("AjaxReplyServiceImpl getListReply start");
		replyList = ad.getReplyList(board);
		System.out.println("AjaxReplyServiceImpl getListReply replyList.size()=>" +replyList.size());
		return replyList;
	}

	
}