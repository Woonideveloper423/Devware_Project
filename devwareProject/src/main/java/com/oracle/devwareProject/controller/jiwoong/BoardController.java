package com.oracle.devwareProject.controller.jiwoong;


import java.util.List;


import javax.servlet.http.HttpSession;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.oracle.devwareProject.domain.Emp;

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
		log.info("/board/WriteForm Start...");
		model.addAttribute("enterBrdType",brd_type);
		return "/board/writeForm";
	}

	// 게시판 게시글 작성
	@PostMapping(value ="/board/write")
	public ModelAndView boardInsert(BoardEmpDept bEmp,Model model) {
		log.info("/board/write start");
		ModelAndView mView = new ModelAndView("redirect:/board/checkList?brd_type="+bEmp.getBrd_type()+"");
		log.info("bEmp:"+bEmp);
		int insertCnt = 0;
		insertCnt=bs.brdInsert(bEmp); 
		log.info("bs.brdInsert insertCnt=>" + insertCnt);
		return mView;
		}
	
	// 게시판 게시글 수정 화면 이동
	@GetMapping(value ="/board/UpdateForm")
	public String boardupdateForm(BoardEmpDept bEmpDept,Model model) throws Exception {
		log.info("/board/UpdateForm start");
		log.info("brd_type:"+bEmpDept.getBrd_type());
		log.info("brd_num:"+bEmpDept.getBrd_num());
		log.info("dept_num:"+bEmpDept.getDept_num());
		model.addAttribute("board",bEmpDept);
		return "/member/user/updateForm";
		}
	
	// 게시판 게시글 수정
	@PostMapping(value ="/board/update")
	public ModelAndView boardUpdate(BoardEmpDept bEmpDept,Model model) {
		log.info("/board/update start");
		ModelAndView mView = new ModelAndView("redirect:/board/checkList?brd_type="+bEmpDept.getBrd_type()+"");
		log.info("brd_title:"+bEmpDept.getBrd_title());
		log.info("brd_content:"+bEmpDept.getBrd_content());
		log.info("emp_num:"+bEmpDept.getEmp_num());
		log.info("dept_num:"+bEmpDept.getDept_num());
		log.info("brd_type:"+bEmpDept.getBrd_type());
		log.info("brd_num:"+bEmpDept.getBrd_num());
		int updateCnt=0;
		updateCnt=bs.brdUpdate(bEmpDept);
		log.info("updateCnt:" +updateCnt);
		return mView;
	}
	
	// 게시판 게시글 삭제
	@PostMapping(value = "/board/delete")
	public ModelAndView boardDelete(BoardEmpDept bEmpDept,Model model) {
		log.info("/board/delete start");
		ModelAndView mView = new ModelAndView("redirect:/board/checkList?brd_type="+bEmpDept.getBrd_type()+"");
		int deleteCnt =0;
		deleteCnt=bs.brdDelete(bEmpDept);
		log.info("deleteCnt:"+deleteCnt);
		return mView;
	}
	
	// 선택 게시판 게시글 목록 이동
	@GetMapping(value ="/board/checkList") 
	public String boardList(int brd_type,Model model,HttpSession session) {
	  log.info("/board/checkList start"); 
	  model.addAttribute("brd_type",brd_type);
	  if(brd_type==5) {
		  return "/member/user/myBoardList"; 
	  }else {
		  return "/member/user/boardList"; 
		  }
	  
	}
	// ajax 게시판 게시글 목록 출력
	  @ResponseBody
	  @GetMapping(value ="/board/ajaxCheckList")
	  public BoardEmpDeptVo boardCheckList(BoardEmpDept bEmp,String currentPage, Model model,HttpSession session){
		  log.info("/board/ajaxCheckList start"); 
		  // Emp 세션 값 받아오기 
		  Emp emp =(Emp)session.getAttribute("emp");
		  bEmp.setDept_num(emp.getDept().getDept_num());
		  bEmp.setDept_name(emp.getDept().getDept_name());
		  bEmp.setEmp_num(emp.getEmp_num()); 
		  log.info("brd_type:"+bEmp.getBrd_type());
		  log.info("dept_num:"+bEmp.getDept_num());
		  log.info("emp_num:" +bEmp.getEmp_num());
		  log.info("searchType:"+bEmp.getSearchType());
		  log.info("keyword:"+bEmp.getKeyword());
		  log.info("arrayType:"+bEmp.getArrayType());
		  log.info("currentPage:"+currentPage);
		  
		  int brdTotalCnt = bs.checkListTotalCnt(bEmp);
		  log.info("brdTotalCnt :" +brdTotalCnt); 
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
		  return "/member/user/detailBoard"; 
	  }
}
	 

