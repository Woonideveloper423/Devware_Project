package com.oracle.devwareProject.service.jiwoong;


import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.dao.jiwoong.BoardDao;
import com.oracle.devwareProject.dto.jiwoong.BoardAttach;
import com.oracle.devwareProject.dto.jiwoong.BoardEmpDept;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {
	
	private final BoardDao bd;

	@Override
	public int brdInsert(BoardEmpDept bEmp) {
		log.info("brdInsert start");
		int brdInsertCnt = bd.boardInsert(bEmp);
		log.info("brdInsertCnt=>" +brdInsertCnt);
		return brdInsertCnt;
	}
	
	 @Override 
	  public int brdInsert(HttpSession session, BoardEmpDept bEmp, MultipartFile[] files) {
		  log.info("brdInsert(file) start");
		  int brdFileInsert = 0;
		  String uploadFolder = session.getServletContext().getRealPath("/upload");
		  log.info("emp_num:" +bEmp.getEmp_num());
		  log.info("brd_type:"+bEmp.getBrd_type());
		  log.info("brd_num:" +bEmp.getBrd_num());
		  try {
			  if(files != null) {
				  List<BoardAttach> boardAttachs = new ArrayList<>();
				  int file_num = 0;
				  for(MultipartFile multipartFile : files) {
					  if(multipartFile.getOriginalFilename().length()!=0) {
						  file_num++;
						  System.out.println(file_num);
						  BoardAttach boardAttach = new BoardAttach();
						  String original_name = multipartFile.getOriginalFilename();
						  System.out.println(original_name);
						  boardAttach.setBrd_num(bEmp.getBrd_type());
						  boardAttach.setFile_num(file_num);
						  boardAttach.setFile_original_name(original_name);
						  boardAttach.setFile_size(multipartFile.getSize());
						  boardAttach.setFile_save_name(uploadFile(original_name, multipartFile.getBytes(), uploadFolder));
						  System.out.println(boardAttach.getFile_num());
						  
						  boardAttachs.add(boardAttach);
					  }else {
						  System.out.println("공갈 파일 넘어옴");
					  }
				  }
				  bEmp.setBoardAttachs(boardAttachs);
			  }
			  brdFileInsert = bd.boardInsert(bEmp);
		  } catch (Exception e) {
			// TODO: handle exception
		  }
		  return brdFileInsert; 
	  }
	 
	 private String uploadFile(String originalName, byte[] fileData , String uploadPath) 
			  throws Exception {
		  // universally unique identifier (UUID).
	     UUID uid = UUID.randomUUID();
	   // requestPath = requestPath + "/resources/image";
	    System.out.println("uploadPath->"+uploadPath);
	    // Directory 생성 
		File fileDirectory = new File(uploadPath);
		if (!fileDirectory.exists()) {
			// 신규 폴더(Directory) 생성 
			fileDirectory.mkdirs();
			System.out.println("업로드용 폴더 생성 : " + uploadPath);
		}
	
	    String savedName = uid.toString() + "_" + originalName;
	    log.info("savedName: " + savedName);
	    File target = new File(uploadPath, savedName);
	//	    File target = new File(requestPath, savedName);
	    // File UpLoad   --->  uploadPath / UUID+_+originalName
	    FileCopyUtils.copy(fileData, target);   // org.springframework.util.FileCopyUtils
	    
	    return savedName;
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
	public void detailBoard(BoardEmpDept bEmpDept) {
		log.info("BoardServiceImpl detailBoard Start");
		// 게시글 상세조회 service
		 bd.detailBoard(bEmpDept);
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
