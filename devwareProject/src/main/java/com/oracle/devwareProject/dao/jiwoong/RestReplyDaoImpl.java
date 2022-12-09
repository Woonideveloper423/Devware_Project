package com.oracle.devwareProject.dao.jiwoong;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.dto.jiwoong.Board;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class RestReplyDaoImpl implements RestReplyDao {
	
	private final SqlSession session;
	
	@Override
	public int insertReply(BoardEmpDept board) {
		System.out.println("RestReplyDaoImpl  writeReply Start...");
		int updateReplyCnt=0;
		int insertCount =0;
		int pushCount=0;
		
		try {
			System.out.println(board.getBrd_re_step());
			// 부모 게시글 댓글 수 update
			updateReplyCnt=session.update("jwUpdateReplyCnt",board);
			log.info("updateReplyCnt=>" +updateReplyCnt);
			if(board.getBrd_re_step()!=0) {
				pushCount=session.update("jwPushReply",board);
				log.info("pushCount:" +pushCount);
			}
			insertCount = session.insert("jwInsertReply",board);
				log.info("insertCount=>" +insertCount);
			} catch (Exception e) {
				log.info("insertReply Exception=>" +e.getMessage());
			}
		return insertCount;
	}

	@Override
	public int totalReply(BoardEmpDept board) { // 게시물 해당 댓글 총개수
		System.out.println("RestReplyDaoImpl  totalReply start");
		int totalReplyCnt = 0;
		try {
			totalReplyCnt = session.selectOne("jwTotalReply",board);
			System.out.println("RestReplyDaoImpl totalReply totalReplyCnt=>" +totalReplyCnt);
		} catch (Exception e) {
			System.out.println("RestReplyDaoImpl totalReply Exception=>" +e.getMessage());
		}
		return totalReplyCnt;
	}

	@Override
	public List<BoardEmpDept> getReplyList(BoardEmpDept board) {
		List<BoardEmpDept> replyList = null;
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
