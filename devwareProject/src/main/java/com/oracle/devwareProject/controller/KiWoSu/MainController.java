package com.oracle.devwareProject.controller.KiWoSu;

import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping("/main")
	public String notAuthApvList() {

		System.out.println("CommuteController listCommute start....");

		return "/main/main";
	}
	

	//@PreAuthorize("hasRole('ROLE_MANAGER') or hasRole('ROLE_USER')")
	@PreAuthorize("isAuthenticated()")
	@RequestMapping("/")
	public String startMainPage() {
		System.out.println("startMainPage....");
		
		return "redirect:/loginSuccess";
	}
}
