package com.oracle.devwareProject.controller.jiwoong;



import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.oracle.devwareProject.dto.jiwoong.Board;
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
		public List<Board> replyList(@RequestParam("brd_type") int brd_type,@RequestParam("brd_num") int brd_num) {
			System.out.println("AjaxReplyController /replies start");
			  Board board = new Board(); 
			  board.setBrd_type(brd_type);
			  board.setBrd_num(brd_num); 
			  System.out.println("board.getBrd_type()=>" +board.getBrd_type());
			  System.out.println("board.getBrd_num()=>"  +board.getBrd_num());
			  int totalReply = as.totalReply(board);
			  System.out.println("AjaxReplyController replyList totalReply=>" +totalReply);
			  
			  List<Board> getReplyList = as.getListReply(board);
			  System.out.println("AjaxReplyController list replyList.size()=>" +getReplyList.size());
			 
			  return getReplyList;
			}	
	   	// ajax 게시글 댓글 작성
		@PostMapping(value ="/reply/write")
		public Board replyInsert(Board board,Model model) {
			System.out.println("AjaxReplyController Start...");
			System.out.println("-AjaxReplyController 넘어온 Parameter-");
			System.out.println("board.getEmp_num()=>"     +board.getEmp_num());
			System.out.println("board.getBrd_type()=>"    +board.getBrd_type());
			System.out.println("board.getBrd_ref()=>" 	  +board.getBrd_ref());
			System.out.println("board.getBrd_re_level()=>"+board.getBrd_re_level());
			System.out.println("board.getBrd_content()=>" +board.getBrd_content());
			System.out.println("board.getBrd_re_step()=>" +board.getBrd_re_step());
			
			int insertCount = 0;
			
			insertCount = as.insertReply(board);
		
			System.out.println("AjaxController as.writeReply insertCount=>" + insertCount);
			
			return board;
		 }
		
		
	
		
}
	


