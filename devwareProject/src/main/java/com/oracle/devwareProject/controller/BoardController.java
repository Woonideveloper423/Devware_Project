package com.oracle.devwareProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.devwareProject.model.Board;
import com.oracle.devwareProject.model.BoardEmp;
import com.oracle.devwareProject.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;



@Controller
@Slf4j
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService bs;
	
	
	// 게시판  목록 화면 이동(임시)
		@GetMapping(value = "/typeBoardList")
		public String typeBoardList() throws Exception{
			System.out.println("BoardController /typeBoardList Start...");
			return "/board/typeBoardList";
		}
	
	// 게시판 글쓰기 화면 이동
	@GetMapping(value = "/boardWriteForm")
	public String boardWriteForm() throws Exception{
		System.out.println("BoardController /boardWriteForm Start...");
		return "/board/boardWriteForm";
	}
	
	// 게시글 작성 로직
	@RequestMapping(value = "/writeBoard")
	public String writeBoard(Board board,Model model) {
		System.out.println("BoardController /writeBoard Start...");
		System.out.println("BoardController /writeBoard board parameter=>" +board);
		
		int insertCount =0;
		
		insertCount = bs.writeBoard(board);
		model.addAttribute("brd_type",board.getBrd_type());
		System.out.println("BoardController  board.getBrd_type()=>" +board.getBrd_type());
		System.out.println("BoardController bs.insertBoard insertCount=>" +insertCount);
		if(insertCount>0) {
			return "/board/typeBoardList";
		}
		else {
			model.addAttribute("msg","입력 실패 T.T");
			return "forward:boardWriteForm";
		}
		
	}
	
	
}
