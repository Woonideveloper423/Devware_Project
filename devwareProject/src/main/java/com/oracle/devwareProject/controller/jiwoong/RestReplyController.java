package com.oracle.devwareProject.controller.jiwoong;



import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;


import org.springframework.web.bind.annotation.RestController;


import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;
import com.oracle.devwareProject.service.jiwoong.RestReplyService;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequiredArgsConstructor
public class RestReplyController {
	
		private final RestReplyService as;
		
	
		//  댓글목록 조회
		@GetMapping(value ="/replies")
		public List<BoardEmpDept> replyList(int brd_type,int brd_num,int dept_num,int qa_status,int brd_re_step) {
			  log.info("/replies start");
			  BoardEmpDept board = new BoardEmpDept(); 
			  board.setBrd_type(brd_type);
			  board.setBrd_num(brd_num);
			  board.setDept_num(dept_num);
			  board.setQa_status(qa_status);
			  board.setBrd_re_step(brd_re_step);
			  log.info("brd_type()=>" +board.getBrd_type());
			  log.info("brd_num()=>" +board.getBrd_num());
			  log.info("dept_num()=>" +board.getDept_num());
			  log.info("qa_status()=>" +board.getQa_status()); 
			  log.info("brd_re_step()=>" +board.getBrd_re_step()); 
			  int totalReply = as.totalReply(board);
			  log.info("/replies totalReply=>" +totalReply);
			  
			  List<BoardEmpDept> getReplyList = as.getListReply(board);
			  log.info("/replies.size()=>" +getReplyList.size());
			 
			  return getReplyList;
			}	
	   	
		// ajax 게시글 댓글 작성
		@PostMapping(value ="/reply/write")
		public BoardEmpDept replyInsert(BoardEmpDept board,Model model) {
			log.info("/reply/write Start...");
			log.info("/reply/writer 넘어온 Parameter");
			log.info(""+board);
			int insertCount = 0;
			insertCount = as.insertReply(board);
			log.info("/reply/write insertCount=>" + insertCount);
			return board;
		 }
}
	


