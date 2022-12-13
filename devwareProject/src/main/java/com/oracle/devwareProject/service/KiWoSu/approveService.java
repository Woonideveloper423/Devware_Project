package com.oracle.devwareProject.service.KiWoSu;

import java.util.List;

import com.oracle.devwareProject.domain.Calendar;
import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.dto.KiWoSu.AllForApprove;
import com.oracle.devwareProject.dto.KiWoSu.Approve;
import com.oracle.devwareProject.dto.KiWoSu.Approve_Progress;
import com.oracle.devwareProject.dto.KiWoSu.Vacation;

public interface approveService {

	int totalApv();

	List<Approve> listApv(Approve approve);

	int writeApv(Approve approve, Approve_Progress approve_Progress, Calendar calendar);

	List<EmpForSearch> getUserInfo();

	EmpForSearch getUserInfo(int emp_num);

	List<EmpForSearch> getempDeptInfo(Dept dept);

	AllForApprove myApvDetail(String app_num);

	Vacation getVacation(int emp_num);

	int authApprove(int chkBtn);

}
