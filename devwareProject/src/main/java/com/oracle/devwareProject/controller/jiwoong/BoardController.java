package com.oracle.devwareProject.controller.jiwoong;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.devwareProject.model.jiwoong.Board;
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
	@GetMapping(value = "/boardWriteForm")
	public String boardWriteForm() throws Exception {
		System.out.println("BoardController /boardWriteForm Start...");
		return "/board/boardWriteForm";
	}

	// 게시글 작성
	@RequestMapping(value = "/writeBoard")
	public String writeBoard(Board board, Model model) {
		System.out.println("BoardController /writeBoard Start...");
		System.out.println("BoardController /writeBoard board parameter=>" + board);

		int insertCount = 0;

		insertCount = bs.writeBoard(board);
		model.addAttribute("brd_type", board.getBrd_type());
		System.out.println("BoardController  board.getBrd_type()=>" + board.getBrd_type());
		System.out.println("BoardController bs.insertBoard insertCount=>" + insertCount);
		if (insertCount > 0) {
			return "/board/typeBoardList";
		} else {
			model.addAttribute("msg", "입력 실패 T.T");
			return "forward:boardWriteForm";
		}

	}

	// 유형별 게시글 목록 조회
	@RequestMapping(value = "/typeBoardList")
	public String typeBoardList(Board board, String currentPage, Model model, int brd_type) {
		System.out.println("BoardController /typeBoardList Start...");
		brd_type = board.getBrd_type();
		System.out.println("BoardController /typeBoardList brd_type => " + brd_type);

		// 게시판 Type별 총 게시물 totalCount
		int totalTypeBrdCnt = bs.totalTypeBoard(brd_type);
		System.out.println("BoardController totalTypeBoard-->" + totalTypeBrdCnt);

		// Paging 작업
		Paging page = new Paging(totalTypeBrdCnt, currentPage);

		// Parameter Board --> Paging 추가 Setting
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());

		List<Board> typeBrdList = bs.listTypeBoard(board);
		System.out.println("BoardController list  typeBrdList.size()-->" + typeBrdList.size());
		
		model.addAttribute("totalTypeBrdCnt", totalTypeBrdCnt);
		model.addAttribute("typeBrdList", typeBrdList);
		model.addAttribute("page", page);

		return "/board/typeBoardList";
	}

	
	 // 게시물 상세조회
	  @GetMapping(value = "/detailBoard") 
	  public String detailBoard(int emp_num,int brd_type,int brd_num,Model model) {
		  System.out.println("BoardController /detailBoard Start...");
		  Map<String, Object> map = new HashMap<String, Object>();
		  map.put("emp_num",emp_num);
		  map.put("brd_type",brd_type);
		  map.put("brd_num",brd_num);
		  
		  System.out.println("map.get(\"emp_num\")=>" +map.get("emp_num"));
		  System.out.println("map.get(\"brd_type\")=>" +map.get("brd_type"));
		  System.out.println("map.get(\"brd_num\")=>" +map.get("brd_num"));
		  
		  Board board = bs.detailBoard(map);
		  
		  String brd_date="";
		  if(board.getBrd_date() !=null) {
			  brd_date=board.getBrd_date().substring(0,19);
			  board.setBrd_date(brd_date);
		  }
		  System.out.println("brd_date=>" +brd_date);
		  model.addAttribute("board",board);
		  
		  return "/board/detailBoard";
	  
	  }
	  
	     // 댓글 작성 
		 @RequestMapping(value = "/writeBoardReply",method = RequestMethod.POST)
		 @ResponseBody
		 public String writeBrdReply(Board board,Model model) {
			 
			 return "/board/detailBoard";
		 }

}
