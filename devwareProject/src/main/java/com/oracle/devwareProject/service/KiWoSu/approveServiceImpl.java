package com.oracle.devwareProject.service.KiWoSu;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.dao.KiWoSu.approveDao;
import com.oracle.devwareProject.domain.Calendar;
import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.dto.KiWoSu.AllForApprove;
import com.oracle.devwareProject.dto.KiWoSu.Approve;
import com.oracle.devwareProject.dto.KiWoSu.ApproveAttach;
import com.oracle.devwareProject.dto.KiWoSu.Approve_Progress;
import com.oracle.devwareProject.dto.KiWoSu.Vacation;
import com.oracle.devwareProject.dto.jiwoong.BoardAttach;
import com.oracle.devwareProject.service.jiwoong.BoardServiceImpl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class approveServiceImpl implements approveService {
	private final approveDao ad;
	
	@Override
	public int totalApv(EmpForSearch empForSearch) {
		System.out.println("approveServiceImpl totalApv start...");
		int totApvCnt = ad.totalApv(empForSearch);
		return totApvCnt;
	}

	@Override
	public List<Approve> listApv(Approve approve) {
		List<Approve> apvList = null;
		System.out.println("approveServiceImpl listApv start...");
		apvList = ad.listApv(approve);
		System.out.println("approveServiceImpl listApv listApv.size()->" +apvList.size());
		return apvList;
	}

	@Override
	public int writeApv(HttpSession session, Approve approve, Approve_Progress approve_Progress, Calendar calendar, MultipartFile[] files) {
		int result = 0;
		System.out.println("approveServiceImpl writeApv start...");
		 String uploadFolder = session.getServletContext().getRealPath("/upload/approve");
		
		
		 try {
			  if(files != null) {
				  List<ApproveAttach> approveAttachs = new ArrayList<>();
				  int file_num = 0;
				  for(MultipartFile multipartFile : files) {
					  if(multipartFile.getOriginalFilename().length()!=0) {
						  file_num++;
						  System.out.println(file_num);
						  ApproveAttach approveAttach = new ApproveAttach();
						  String original_name = multipartFile.getOriginalFilename();
						  System.out.println(original_name);
						  approveAttach.setFile_num(file_num);
						  approveAttach.setFile_oriname(original_name);
						  approveAttach.setFile_name(uploadFile(original_name, multipartFile.getBytes(), uploadFolder));
						  System.out.println(approveAttach.getFile_num());

						  
						  approveAttachs.add(approveAttach);
					  }else {
						  System.out.println("공갈 파일 넘어옴");
					  }
				  }
				  approve.setApproveAttachs(approveAttachs);
			  }
			  result = ad.writeApv(approve, approve_Progress, calendar);
		  } catch (Exception e) {
			  System.out.println("approveDao writeApv Exception->"+e.getMessage());
		  }
		 
		return result;
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
	public List<EmpForSearch> getUserInfo() {
		System.out.println("approveServiceImpl getUserInfo Start");
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		emplist = ad.getAllUserInfo();
		
		return emplist;
	}

	@Override
	public EmpForSearch getUserInfo(int emp_num) {
		System.out.println("approveServiceImpl getUserInfo Start");
		EmpForSearch empForSearch = null;
		empForSearch = ad.getAllUserInfo(emp_num);
		return empForSearch;
	}

	@Override
	public List<EmpForSearch> getempDeptInfo(Dept dept) {
		System.out.println("approveServiceImpl getempDeptInfo Start");
		List<EmpForSearch> empDeptlist = new ArrayList<EmpForSearch>();
		empDeptlist = ad.getempDeptInfo(dept);
		return empDeptlist;
	}

	@Override
	public AllForApprove myApvDetail(String app_num) {
		System.out.println("approveServiceImpl myApvDetail ...");
		AllForApprove allForApprove = null;
		allForApprove = ad.detailApv(app_num);
		return allForApprove;
	}

	@Override
	public Vacation getVacation(int emp_num) {
		System.out.println("approveServiceImpl getVacation ...");
		Vacation vacation = null;
		vacation = ad.getVacation(emp_num);
		
		return vacation;
	}

	@Override
	public int authApprove(String chkBtn, String sendData, String app_num) {
		System.out.println("approveServiceImpl authApprove ...");
		int result = 0;
		result = ad.authApprove(chkBtn, sendData, app_num);
		return result;
	}

	@Override
	public int notAuthApv(EmpForSearch empForSearch) {
		System.out.println("approveServiceImpl totalApv start...");
		int totNotApvCnt = ad.totalNotApv(empForSearch);
		return totNotApvCnt;
	}

	@Override
	public List<Approve> listNotApv(Approve approve) {
		List<Approve> listNotApv = null;
		System.out.println("approveServiceImpl listApv start...");
		listNotApv = ad.listNotApv(approve);
		System.out.println("approveServiceImpl listApv listApv.size()->" +listNotApv.size());
		return listNotApv;
	}

	@Override
	public int reWriteApv(Approve approve, Approve_Progress approve_Progress, Calendar calendar, String app_num) {
		int result = 0;
		System.out.println("approveServiceImpl writeApv start...");
		result = ad.reWriteApv(approve, approve_Progress, calendar, app_num);
		
		return result;
	}

	@Override
	public Approve_Progress returnApprove(Approve_Progress approve_Progress, int app_num, String apv_return) {
		System.out.println("approveServiceImpl returnApprove start...");
		approve_Progress = null;
		approve_Progress = ad.returnApprove(approve_Progress, app_num, apv_return);
		return approve_Progress;
	}

	@Override
	public String deleteApprove(Approve_Progress approve_Progress, Approve approve) {
		String result ="";
		result = ad.deleteApprove(approve_Progress, approve);
		return result;
	}


}
