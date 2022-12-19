package com.oracle.devwareProject.dao.KiWoSu;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.domain.Calendar;
import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.dto.KiWoSu.AllForApprove;
import com.oracle.devwareProject.dto.KiWoSu.Approve;
import com.oracle.devwareProject.dto.KiWoSu.ApproveAttach;
import com.oracle.devwareProject.dto.KiWoSu.Approve_Progress;
import com.oracle.devwareProject.dto.KiWoSu.Vacation;

public interface approveDao {

	int totalApv(EmpForSearch empForSearch);

	List<Approve> listApv(Approve approve);

	int writeApv(Approve approve, Approve_Progress approve_Progress, Calendar calendar);

	List<EmpForSearch> getAllUserInfo();

	EmpForSearch getAllUserInfo(int emp_num);

	List<EmpForSearch> getempDeptInfo(Dept dept);

	AllForApprove detailApv(String app_num);

	Vacation getVacation(int emp_num);

	int authApprove(String chkBtn, String sendData, String app_num);

	int totalNotApv(EmpForSearch empForSearch);

	List<Approve> listNotApv(Approve approve);

	int reWriteApv(Approve approve, Approve_Progress approve_Progress, Calendar calendar, String app_num);
	
	Approve_Progress returnApprove(Approve_Progress approve_Progress, int app_num, String apv_return);

	String deleteApprove(Approve_Progress approve_Progress, Approve approve);

	List<AllForApprove> myListSearch(AllForApprove allForApprove);

}
