package com.oracle.devwareProject.controller.jiwoong;


import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.dto.jiwoong.BoardAttach;
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
		return "/board/user/writeForm";
	}

	// 게시판 게시글 작성
	@PostMapping(value ="/board/write")
	public ModelAndView boardInsert(HttpSession session, BoardEmpDept bEmp,MultipartFile[] files,Model model) {
		log.info("/board/write start");
		ModelAndView mView = new ModelAndView("redirect:/board/checkList?brd_type="+bEmp.getBrd_type()+"");
		
		log.info("bEmp:"+bEmp);
		int insertCnt = 0;
		insertCnt=bs.brdInsert(session,bEmp,files); 
		log.info("bs.brdInsert insertCnt=>" + insertCnt);
		return mView;
		}
	
	// 게시판 게시글 수정 화면 이동
	@GetMapping(value ="/board/UpdateForm")
	public String boardupdateForm(BoardEmpDept bEmpDept,String[] saveName,String[] realName,Model model) throws Exception {
		log.info("/board/UpdateForm start");
		log.info("brd_type:"+bEmpDept.getBrd_type());
		log.info("brd_num:"+bEmpDept.getBrd_num());
		log.info("dept_num:"+bEmpDept.getDept_num());
		log.info("brd_content:"+bEmpDept.getBrd_content());
		log.info("brd_title:"+bEmpDept.getBrd_title());
		log.info("saveName:"+saveName);
		log.info("realName:"+realName);
			
		if(saveName!=null){
			System.out.println("첨부파일 있음");
			log.info("saveName.length:"+saveName.length);
			for(int i=0; i<saveName.length; i++) {
			List<BoardAttach> boardAttachList=new ArrayList<BoardAttach>();
			BoardAttach boardAttach=new BoardAttach(realName[i],saveName[i]);
			boardAttachList.add(boardAttach);
			bEmpDept.setBoardAttachs(boardAttachList);
			}
			log.info("BoardAttachs():"+bEmpDept.getBoardAttachs());
			}else {
				log.info("첨부파일 없음");
			}
			model.addAttribute("board",bEmpDept);
			return "/board/user/updateForm";
		}
	
	// 게시판 게시글 수정
	@PostMapping(value ="/board/update")
	public ModelAndView boardUpdate(HttpSession session,BoardEmpDept bEmpDept,String[] attachNum,MultipartFile[] files,Model model) {
		log.info("/board/update start");
		ModelAndView mView = new ModelAndView("redirect:/board/checkList?brd_type="+bEmpDept.getBrd_type()+"");
		log.info("brd_title:"+bEmpDept.getBrd_title());
		log.info("brd_content:"+bEmpDept.getBrd_content());
		log.info("emp_num:"+bEmpDept.getEmp_num());
		log.info("dept_num:"+bEmpDept.getDept_num());
		log.info("brd_type:"+bEmpDept.getBrd_type());
		log.info("brd_num:"+bEmpDept.getBrd_num());
		log.info("files[]:"+files.length);
		int updateCnt=0;
		updateCnt=bs.brdUpdate(bEmpDept,session);
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
		  return "/board/user/myBoardList"; 
	  }else if(brd_type==6){
		  return "/board/user/noticeList"; 
	  }else {
		  return "/board/user/boardList"; 
		  }
	  
	}
	// ajax 게시판 게시글 목록 출력
	  @ResponseBody
	  @GetMapping(value ="/board/ajaxCheckList")
	  public BoardEmpDeptVo boardCheckList(BoardEmpDept bEmp,String currentPage,Model model,HttpSession session){
		  log.info("/board/ajaxCheckList start"); 
		  // Emp 세션 값 받아오기 
		  Emp emp =(Emp)session.getAttribute("emp");
		  bEmp.setDept_num(emp.getDept().getDept_num());
		  bEmp.setDept_name(emp.getDept().getDept_name());
		  bEmp.setEmp_num(emp.getEmp_num());
		  System.out.println(bEmp.getArrayType());
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
		  bs.detailBoard(bEmpDept);
		  log.info("brd_type: "+bEmpDept.getBrd_type());
		  log.info("emp_num: " +bEmpDept.getEmp_num());
		  log.info("brd_num: " +bEmpDept.getBrd_num());
		  log.info("dept_num:" +emp.getDept().getDept_num());
		  log.info("brd_ref: " +bEmpDept.getBrd_ref());
		  log.info("brd_re_level: " +bEmpDept.getBrd_re_level());
		  log.info("brd_re_step: " +bEmpDept.getBrd_re_step());
		  log.info("qa_status: " +bEmpDept.getQa_status());
		  model.addAttribute("board",bEmpDept);
		  return "/board/user/detailBoard"; 
	  }
	  
	  // qa 게시판 스터디게시판 qa_status 변경 
	  @PostMapping(value = "/board/updateStatus")
	  public ModelAndView updateStatus(BoardEmpDept bEmpDept,Model model) {
		log.info("/board/updateStatus start");
		ModelAndView mView = new ModelAndView("redirect:/board/checkList?brd_type="+bEmpDept.getBrd_type()+"");
		int statusUpdateCnt =0;
		statusUpdateCnt=bs.updateStatus(bEmpDept);
		log.info("statusUpdateCnt:"+statusUpdateCnt);
		return mView;
		  
	  }
	  
	  
}
	 

