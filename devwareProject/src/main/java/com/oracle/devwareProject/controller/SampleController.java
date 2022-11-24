package com.oracle.devwareProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SampleController {

	@RequestMapping(value ="/boardList")
	public String boardList(Model model) {
		
		System.out.println("SampleController boardList Start...");
		
		/*  경로에 '/' 반드시 입력 */
		return "/board/JwBoardForm"; 
	}
	
	@RequestMapping(value = "/typeBoardlist")
	public String typeBoardList(Model model) {
		
		System.out.println("SampleController typeBoardList Start... ");
		
		return "/board/typeBoardList";
	}
	
}
