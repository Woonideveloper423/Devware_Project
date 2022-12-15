package com.oracle.devwareProject.service.jiwoong;


import java.util.List;


import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.dao.jiwoong.BoardDao;


import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;
import com.oracle.devwareProject.dto.jiwoong.File;
import com.oracle.devwareProject.mapper.jiwoong.FileMapper;
import com.oracle.devwareProject.util.jiwoong.FileUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {
	
	private final BoardDao bd;
	private final FileMapper fileMapper;
	private final FileUtils fileUtils;
	
	@Override
	public int brdInsert(BoardEmpDept bEmp) {
		log.info("brdInsert start");
		int brdInsertCnt = bd.boardInsert(bEmp);
		log.info("brdInsertCnt=>" +brdInsertCnt);
		return brdInsertCnt;
	}
	
	 @Override 
	  public int brdInsert(BoardEmpDept bEmp, MultipartFile[] files) {
		  log.info("brdInsert(file) start");
		  int brdFileInsert = 0;
//		  if(brdInsert(bEmp)!=1){ 
//			  log.info("작성글을 찾을 수 없음");
//			  brdFileInsert=0;
//			  return brdFileInsert; 
//		  }
		  List<File> fileList = fileUtils.uploadFiles(files,bEmp.getEmp_num(),bEmp.getBrd_type(),bEmp.getBrd_num());
		  log.info("emp_num:" +bEmp.getEmp_num());
		  log.info("brd_type:"+bEmp.getBrd_type());
		  log.info("brd_num:" +bEmp.getBrd_num());
		  
		  brdInsert(bEmp);
		  
		  if(CollectionUtils.isEmpty(fileList)==false) {
			  brdFileInsert=fileMapper.insertFile(fileList);
		  }
		  return brdFileInsert; 
	  }
	 
	
	@Override
	public int checkListTotalCnt(BoardEmpDept bEmp) {
		log.info("checkListTotalCnt start");
		int checkListTotalCnt =bd.checkListTotalCnt(bEmp);
		log.info("checkListTotalCnt=>" +checkListTotalCnt);
		return checkListTotalCnt;
	}
	
	@Override
	public List<BoardEmpDept> boardCheckList(BoardEmpDept bEmp) {
		log.info("boardCheckList start");
		List<BoardEmpDept> brdCheckList = bd.boardCheckList(bEmp);
		return brdCheckList;
		}
	
	@Override
	public BoardEmpDept detailBoard(BoardEmpDept bEmpDept) {
		log.info("BoardServiceImpl detailBoard Start");
		int viewUpdateCnt=0;
		BoardEmpDept boardInfo=null;
		// 게시글 조회수 증가 service
		viewUpdateCnt=bd.brdViewUpdate(bEmpDept);
		log.info("viewUpdateCount:" +viewUpdateCnt);
		// 게시글 상세조회 service
		boardInfo = bd.detailBoard(bEmpDept);
		
		return boardInfo;
	}

	@Override
	public int brdDelete(BoardEmpDept bEmpDept) {
		log.info("brdDelete start");
		int brdDeleteCnt = 0;
		brdDeleteCnt=bd.brdDelete(bEmpDept);
		log.info("brdDeleteCnt:" +brdDeleteCnt);
		return brdDeleteCnt;
	}

	@Override
	public int brdUpdate(BoardEmpDept bEmpDept) {
		log.info("brdUpdate start");
		int brdUpdateCnt=0;
		brdUpdateCnt=bd.brdUpdate(bEmpDept);
		log.info("brdUpdateCnt:" +brdUpdateCnt);
		return brdUpdateCnt;
	}

	

	

	




	

	

	


	
}
