package com.oracle.devwareProject.controller.jiwoong;


import java.util.List;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.devwareProject.domain.Emp;

import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;
import com.oracle.devwareProject.service.jiwoong.BoardService;
import com.oracle.devwareProject.service.jiwoong.Paging;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class BoardController {

	private final BoardService bs;
	

	// 게시판 글쓰기 화면 이동
	@GetMapping(value ="/board/WriteForm")
	public String boardWriteForm(Model model,HttpSession session) throws Exception {
		System.out.println("BoardController /boardWriteForm Start...");
		Emp emp =(Emp)session.getAttribute("emp");
		System.out.println(emp);
		return "/board/writeForm";
	}

	// 게시글 insert 메서드
	@PostMapping(value ="/board/write")
	public String boardInsert(BoardEmpDept bEmp,Model model,HttpSession session) {
		System.out.println("BoardController /board/write Start...");
		System.out.println(bEmp);
		int insertCnt = 0;
		insertCnt=bs.brdInsert(bEmp); 
		System.out.println("BoardController bs.brdInsert insertCnt=>" + insertCnt);
		if (insertCnt > 0) {
			model.addAttribute("msg", "게시글 insert 성공!!!");
			return "/board/test";
		} else {
			model.addAttribute("msg", "게시글 insert 실패 T.T");
			return "/board/test";
		}

	}
	
	// 종류별 게시판 게시글 목록 조회
	@GetMapping(value ="/board/checkList")
	public String boardList(BoardEmpDept bEmp,int brd_type, String currentPage, Model model,HttpSession session) {
		System.out.println("BoardController /board/checkList Start...");
		// Emp 세션 값 받아오기
		Emp emp =(Emp)session.getAttribute("emp");
		System.out.println(emp);
		System.out.println("brd_type->"+brd_type);
		bEmp.setDept_num(emp.getDept().getDept_num());
		bEmp.setDept_name(emp.getDept().getDept_name());
		bEmp.setEmp_num(emp.getEmp_num());
		System.out.println(("emp_num:"+bEmp.getEmp_num()+"dept_num:"+bEmp.getDept_num()+" dept_name:"+bEmp.getDept_name()+" brd_type:"+bEmp.getBrd_type()));
		log.info("bEmp.getEmp_num()");
		int brdTotalCnt = bs.checkListTotalCnt(bEmp);
		System.out.println("BoardController /board/checkList  brdTotalCnt-->" + brdTotalCnt);
		// Paging 작업
		Paging page = new Paging(brdTotalCnt, currentPage);
		
		bEmp.setStart(page.getStart());
		bEmp.setEnd(page.getEnd());
		
		List<BoardEmpDept> brdCheckList = bs.boardCheckList(bEmp);
		  model.addAttribute("brdTotalCnt",brdTotalCnt);
		  model.addAttribute("brdCheckList",brdCheckList);
		  model.addAttribute("brd_type",brd_type);
		  model.addAttribute("page", page);
		
		if(brd_type==5) {
			return "/board/myBoardList";
		}else {
			return"/board/boardList";
		}
	}

	
	 // 게시물 상세조회
	  @GetMapping(value ="/board/detail") 
	  public String boardDetail(BoardEmpDept bEmpDept,Model model) {
		  System.out.println("BoardController /board/detail Start...");
		  log.info("brd_type:"+bEmpDept.getBrd_type());
		  log.info("emp_num:"+bEmpDept.getEmp_num());
		  log.info("brd_num:"+bEmpDept.getBrd_num());
		  String brd_date="";
		  
			/*
			 * if(board.getBrd_date() !=null) {
			 * brd_date=board.getBrd_date().substring(0,19); board.setBrd_date(brd_date);}
			 */
		  
		  System.out.println("brd_date=>" +brd_date);
		 
		  
		  return "/board/test";
			 
	  
	  }
}
	  // 게시물 조건검색

