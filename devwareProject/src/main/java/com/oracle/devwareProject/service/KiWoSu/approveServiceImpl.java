package com.oracle.devwareProject.service.KiWoSu;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.KiWoSu.approveDao;
import com.oracle.devwareProject.domain.Calendar;
import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.dto.KiWoSu.AllForApprove;
import com.oracle.devwareProject.dto.KiWoSu.Approve;
import com.oracle.devwareProject.dto.KiWoSu.Approve_Progress;
import com.oracle.devwareProject.dto.KiWoSu.Vacation;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
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
	public int writeApv(Approve approve, Approve_Progress approve_Progress, Calendar calendar) {
		int result = 0;
		System.out.println("approveServiceImpl writeApv start...");
		result = ad.writeApv(approve, approve_Progress, calendar);
		
		return result;
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


}
