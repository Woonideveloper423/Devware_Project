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
		public List<BoardEmpDept> replyList(int brd_type,int brd_num,int dept_num) {
			  System.out.println("RestReplyController /replies start");
			  BoardEmpDept board = new BoardEmpDept(); 
			  board.setBrd_type(brd_type);
			  board.setBrd_num(brd_num);
			  board.setDept_num(dept_num);
			  log.info("board.getBrd_type()=>" +board.getBrd_type());
			  log.info("board.getBrd_num()=>" +board.getBrd_num());
			  log.info("board.getDept_num()=>" +board.getDept_num());
			  System.out.println("board.getBrd_num()=>" +board.getBrd_num());
			  int totalReply = as.totalReply(board);
			  System.out.println("RestReplyController replyList totalReply=>" +totalReply);
			  
			  List<BoardEmpDept> getReplyList = as.getListReply(board);
			  System.out.println("RestReplyController list replyList.size()=>" +getReplyList.size());
			 
			  return getReplyList;
			}	
	   	
		// ajax 게시글 댓글 작성
		@PostMapping(value ="/reply/write")
		public BoardEmpDept replyInsert(BoardEmpDept board,Model model) {
			System.out.println("RestReplyController Start...");
			System.out.println("RestReplyController 넘어온 Parameter");
			System.out.println(board);
			
			int insertCount = 0;
			
			insertCount = as.insertReply(board);
		
			System.out.println("AjaxController as.writeReply insertCount=>" + insertCount);
			
			return board;
		 }
		
		
	
		
}
	


