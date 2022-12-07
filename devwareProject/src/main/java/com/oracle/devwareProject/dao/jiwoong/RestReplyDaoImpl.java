package com.oracle.devwareProject.dao.jiwoong;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.dto.jiwoong.Board;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class RestReplyDaoImpl implements RestReplyDao {
	
	private final SqlSession session;
	
	@Override
	public int insertReply(Board board) {
		System.out.println("AjaxDaoImpl  writeReply Start...");
		int insertCount =0;
		try {
			if(board.getBrd_re_step()!=0) {
				session.update("jwPushReply",board);
			}
			insertCount = session.insert("jwInsertReply",board);
			System.out.println("AjaxDaoImpl  writeReply insertCount=>" +insertCount);
		} catch (Exception e) {
			System.out.println("AjaxDaoImpl insertReply Exception=>" +e.getMessage());
		}
		return insertCount;
	}

	@Override
	public int totalReply(Board board) { // 게시물 해당 댓글 총개수
		System.out.println("AjaxReplyDaoImpl  totalReply start");
		int totalReplyCnt = 0;
		try {
			totalReplyCnt = session.selectOne("jwTotalReply",board);
			System.out.println("AjaxReplyDaoImpl totalReply totalReplyCnt=>" +totalReplyCnt);
		} catch (Exception e) {
			System.out.println("AjaxReplyDaoImp totalReply Exception=>" +e.getMessage());
		}
		return totalReplyCnt;
	}

	@Override
	public List<Board> getReplyList(Board board) {
		List<Board> replyList = null;
		System.out.println("AjaxReplyDaoImpl getReplyList start");
		
		try {
			replyList = session.selectList("jwGetReplyList", board);
			System.out.println("AjaxReplyDaoImpl getReplyList replyList.size()=>" +replyList.size());
		} catch (Exception e) {
			System.out.println("AjaxReplyDaoImpl getReplyList e.getMessage()=>" +e.getMessage());
		}
		return replyList;
	}


	

}
