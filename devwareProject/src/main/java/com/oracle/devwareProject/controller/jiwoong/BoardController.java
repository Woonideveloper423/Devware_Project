package com.oracle.devwareProject.controller.jiwoong;


import java.util.List;


import javax.servlet.http.HttpSession;

import org.hibernate.engine.query.spi.ReturnMetadata;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.dto.jiwoong.Board;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDeptVo;
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
	public String boardWriteForm(int brd_type,Model model) throws Exception {
		System.out.println("BoardController /board/WriteForm Start...");
		return "/board/writeForm";
	}

	// 게시판 게시글 insert
	@PostMapping(value ="/board/write")
	public ModelAndView boardInsert(BoardEmpDept bEmp,Model model) {
		log.info("/board/write start");
		ModelAndView mView = new ModelAndView("redirect:/board/checkList?brd_type="+bEmp.getBrd_type()+"");
		System.out.println(bEmp);
		int insertCnt = 0;
		insertCnt=bs.brdInsert(bEmp); 
		System.out.println("BoardController bs.brdInsert insertCnt=>" + insertCnt);
		return mView;
		}
	
	// 게시판 게시글 delete
	@PostMapping(value = "/board/delete")
	public ModelAndView boardDelete(BoardEmpDept bEmpDept,Model model) {
		log.info("/board/delete start");
		System.out.println(bEmpDept);
		ModelAndView mView = new ModelAndView("redirect:/board/checkList?brd_type="+bEmpDept.getBrd_type()+"");
		int deleteCnt =0;
		deleteCnt=bs.brdDelete(bEmpDept);
		log.info("deleteCnt:"+deleteCnt);
		return mView;
	}
	
	
	
	
	// 선택 게시판 게시글 목록 이동
	@GetMapping(value ="/board/checkList") 
	public String boardList(int brd_type,Model model,HttpSession session) {
	  log.info("/board/checkList start"); // Emp 세션 값 받아오기 
	  model.addAttribute("brd_type",brd_type);
	  if(brd_type==5) {
		  return "/board/myBoardList"; 
	  }else {
		  return "/board/boardList"; 
		  }
	  
	}
	// ajax 게시판 게시글 목록 출력
	  @ResponseBody
	  @GetMapping(value ="/board/ajaxCheckList")
	  public BoardEmpDeptVo boardCheckList(int brd_type, String currentPage, Model model,HttpSession session){
		  log.info("/board/ajaxCheckList start"); 
		  // Emp 세션 값 받아오기 
		  Emp emp =(Emp)session.getAttribute("emp");
		  System.out.println(emp);
		  System.out.println("brd_type->"+brd_type);
		  BoardEmpDept bEmp=new BoardEmpDept();
		  bEmp.setDept_num(emp.getDept().getDept_num());
		  bEmp.setDept_name(emp.getDept().getDept_name());
		  bEmp.setEmp_num(emp.getEmp_num()); 
		  bEmp.setBrd_type(brd_type); 
		  int brdTotalCnt = bs.checkListTotalCnt(bEmp);
		  System.out.println("BoardController /board/checkList  brdTotalCnt-->" +brdTotalCnt); 
		  // Paging 작업 
		  Paging page = new Paging(brdTotalCnt,currentPage);
		  
		  bEmp.setStart(page.getStart());
		  bEmp.setEnd(page.getEnd());
		  
		  List<BoardEmpDept> brdCheckList = bs.boardCheckList(bEmp); 
		  BoardEmpDeptVo boardList=new BoardEmpDeptVo();
		  boardList.setBrdCheckList(brdCheckList);
		  boardList.setPage(page);
		  
		  return boardList;
		  }

	  // 선택 게시판 게시글 상세조회
	  @GetMapping(value ="/board/detail") 
	  public String boardDetail(BoardEmpDept bEmpDept,Model model,HttpSession session) {
		  log.info("/board/detail start");
		  Emp emp =(Emp)session.getAttribute("emp");
		  log.info("brd_type: "+bEmpDept.getBrd_type());
		  log.info("emp_num: " +bEmpDept.getEmp_num());
		  log.info("brd_num: " +bEmpDept.getBrd_num());
		  log.info("dept_num:" +emp.getDept().getDept_num());
		  String brd_date=null;
		   if(bEmpDept.getBrd_date() !=null) {
			  brd_date=bEmpDept.getBrd_date().substring(0,19);
			  bEmpDept.setBrd_date(brd_date);
			  }
		  log.info("brd_date=>" +brd_date);
		  bEmpDept.setDept_num(emp.getDept().getDept_num());
		  BoardEmpDept detailInfo=bs.detailBoard(bEmpDept);
		  model.addAttribute("board",detailInfo);
		  return "/board/detailBoard"; 
	  }
}
	 

