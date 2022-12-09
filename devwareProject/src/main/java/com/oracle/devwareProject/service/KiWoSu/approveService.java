package com.oracle.devwareProject.service.KiWoSu;

import java.util.List;

import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.dto.KiWoSu.AllForApprove;
import com.oracle.devwareProject.dto.KiWoSu.Approve;
import com.oracle.devwareProject.dto.KiWoSu.Approve_Progress;

public interface approveService {

	int totalApv();

	List<Approve> listApv(Approve approve);

	int writeApv(Approve approve, Approve_Progress approve_Progress);

	List<EmpForSearch> getUserInfo();

	EmpForSearch getUserInfo(int emp_num);

	List<EmpForSearch> getempDeptInfo(Dept dept);

	AllForApprove myApvDetail(String app_num);

}
