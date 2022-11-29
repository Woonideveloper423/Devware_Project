package com.oracle.devwareProject.controller.jiwoong;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;




@Controller
public class SampleController {

	@RequestMapping(value ="/boardList")
	public String boardList(Model model) {
		
		System.out.println("SampleController boardList Start...");
		
		/*  경로에 '/' 반드시 입력 */
		return "/board/JwBoardForm"; 
	}
	
	@RequestMapping(value = "/detailBoard")
	public String detailBoard(Model model) {
		
		System.out.println("SampleController detailBoard Start... ");
		
		return "/board/detailBoard";
	}
	
	 
}