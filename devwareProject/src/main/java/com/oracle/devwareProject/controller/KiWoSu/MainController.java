package com.oracle.devwareProject.controller.KiWoSu;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping("/main")
	public String notAuthApvList() {

		System.out.println("CommuteController listCommute start....");

		return "/main/main";
		
	}
}
