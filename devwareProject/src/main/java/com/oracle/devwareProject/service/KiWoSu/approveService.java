package com.oracle.devwareProject.service.KiWoSu;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.domain.Calendar;
import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.dto.KiWoSu.AllForApprove;
import com.oracle.devwareProject.dto.KiWoSu.Approve;
import com.oracle.devwareProject.dto.KiWoSu.ApproveAttach;
import com.oracle.devwareProject.dto.KiWoSu.Approve_Progress;
import com.oracle.devwareProject.dto.KiWoSu.Vacation;

public interface approveService {

	int totalApv(EmpForSearch empForSearch);
	
	int notAuthApv(EmpForSearch empForSearch);

	List<Approve> listApv(Approve approve);
	
	List<Approve> listNotApv(Approve approve);

	int writeApv(HttpSession session, Approve approve, Approve_Progress approve_Progress, Calendar calendar, MultipartFile[] files);

	List<EmpForSearch> getUserInfo();

	EmpForSearch getUserInfo(int emp_num);

	List<EmpForSearch> getempDeptInfo(Dept dept);

	AllForApprove myApvDetail(String app_num);

	Vacation getVacation(int emp_num);

	int authApprove(String chkBtn, String sendData, String app_num);

	int reWriteApv(Approve approve, Approve_Progress approve_Progress, Calendar calendar, String app_num);

	Approve_Progress returnApprove(Approve_Progress approve_Progress, int app_num, String apv_return);

	String deleteApprove(Approve_Progress approve_Progress, Approve approve);

}
