package com.oracle.devwareProject.dao.KiWoSu;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.domain.Calendar;
import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.dto.KiWoSu.AllForApprove;
import com.oracle.devwareProject.dto.KiWoSu.Approve;
import com.oracle.devwareProject.dto.KiWoSu.Approve_Progress;
import com.oracle.devwareProject.dto.KiWoSu.Vacation;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class approveDaoImpl implements approveDao {
	// Mybatis DB 연동 
		private final SqlSession session;
	
	@Override
	public int totalApv() {
		int totApvCount = 0;
		System.out.println("approveDaoImpl totalApv start...");
		
		try {
			totApvCount = session.selectOne("ApvTotal");
			System.out.println("approveDaoImpl totalApv totApvCount->" +totApvCount);
		} catch (Exception e) {
			System.out.println("approveDaoImpl totalApv Exception->"+e.getMessage());
		}
		return totApvCount;
	}

	@Override
	public List<Approve> listApv(Approve approve) {
		List<Approve> apvList = null;
		System.out.println("approveDaoImpl listApv start...");
		try {
			apvList = session.selectList("wsApvListAll", approve);
			System.out.println("approveDaoImpl listApv apvList.size()->"+apvList.size());
		} catch (Exception e) {
			System.out.println("approveDaoImpl listApv Exception->"+e.getMessage());
		}
		
		return apvList;
	}

	@Override
	public int writeApv(Approve approve, Approve_Progress approve_Progress, Calendar calendar) {
		int result = 0;
		System.out.println("approveDaoImpl writeApv Start..." );
		System.out.println("appgetApp_content ->" +approve.getApp_content());
		System.out.println("appgetApp_title ->" +approve.getApp_title());
		System.out.println("writeApv getPrg_name1->" + approve_Progress.getPrg_name1());
		System.out.println("writeApv getPrg_num1->" + approve_Progress.getPrg_num1());
		try {
			result = session.insert("wsWriteApv", approve);
			System.out.println("writeApv getApp_num1->" + approve.getApp_num());
			approve_Progress.setApp_num(approve.getApp_num());
			System.out.println("writeApv getApp_num2->" + approve_Progress.getApp_num());
			session.insert("wsWriteApvPrg", approve_Progress);
			if (approve.getComu_app() != null) {
				System.out.println("writeApv date->" + calendar.getCalendar_start());
				System.out.println("writeApv date->" + calendar.getCalendar_end());
				calendar.setcalendar_emp_num(approve.getEmp_num());
				System.out.println("writeApv date->" + calendar.getcalendar_emp_num());
				session.update("wsUpdate", calendar);
			}
		} catch (Exception e) {
			System.out.println("approveDaoImpl writeApv Exception->"+e.getMessage());
		}
		return result;
	}

	@Override
	public List<EmpForSearch> getAllUserInfo() {
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		System.out.println("approveDaoImpl getAllUserInfo Start..." );
		try {
			emplist = session.selectList("getAllUserInfo");
			System.out.println("EmpDaoImpl emplist.size: " + emplist.size());
		} catch (Exception e) {
			System.out.println("Error Occurred->" + e.getMessage());
		}
		return emplist;
	}

	@Override
	public EmpForSearch getAllUserInfo(int emp_num) {
		System.out.println("approveDaoImpl getAllUserInfo2 Start..." );
		EmpForSearch empForSearch = new EmpForSearch();
		try {
			empForSearch = session.selectOne("getAllUserInfo2", emp_num);
		} catch (Exception e) {
			System.out.println("approveDaoImpl getAllUserInfo Exception->"+e.getMessage());
		}
		return empForSearch;
	}

	@Override
	public List<EmpForSearch> getempDeptInfo(Dept dept) {
		List<EmpForSearch> empDeptlist = new ArrayList<EmpForSearch>();
		System.out.println("approveDaoImpl getempDeptInfo Start..." );
		try {
			empDeptlist = session.selectList("getempDeptInfo", dept);
			System.out.println("EmpDaoImpl emplist.size: " + empDeptlist.size());
		} catch (Exception e) {
			System.out.println("Error Occurred->" + e.getMessage());
		}
		return empDeptlist;
	}

	@Override
	public AllForApprove detailApv(String app_num) {
		System.out.println("approveDaoImpl detailApv Start..." );
		AllForApprove allForApprove  = new AllForApprove();
		AllForApprove allForApprove2  = new AllForApprove();

		try {
			allForApprove = session.selectOne("wsDetailApv", app_num);
			System.out.println("approveDaoImpl detailApv getPrg_num1->"+allForApprove.getPrg_num1());
			allForApprove2 = session.selectOne("wsPositioName", app_num);
			allForApprove.setPosition_name1(allForApprove2.getPosition_name1());
			allForApprove.setPosition_name2(allForApprove2.getPosition_name2());
			allForApprove.setPosition_name3(allForApprove2.getPosition_name3());
			System.out.println("approveDaoImpl detailApv getPosition_name1->"+allForApprove.getPosition_name1());
			System.out.println("approveDaoImpl detailApv getPosition_name2->"+allForApprove.getPosition_name2());
			System.out.println("approveDaoImpl detailApv getPosition_name3->"+allForApprove.getPosition_name3());
			System.out.println("approveDaoImpl detailApv getPrg_auth1->"+allForApprove.getPrg_auth1());
		} catch (Exception e) {
			System.out.println("approveDaoImpl detailApv Exception->"+e.getMessage());
		}
		
		return allForApprove;
	}

	@Override
	public Vacation getVacation(int emp_num) {
		System.out.println("approveDaoImpl getVacation Start..." );
		Vacation vacation = new Vacation();
		try {
			System.out.println("approveDaoImpl getVacation emp_num ->"+emp_num );
			vacation = session.selectOne("wsGetVacation", emp_num);
			System.out.println("approveDaoImpl getVacation ->"+ vacation.getVa_stock());
		} catch (Exception e) {
			System.out.println("approveDaoImpl getVacation Exception->"+e.getMessage());
		}
		return vacation;
	}

	@Override
	public int authApprove(int chkBtn) {
		int result = 0;
		System.out.println("approveDaoImpl authApprove Start..." );
		try {
			result = session.update("wsAuthApv", chkBtn);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
	}

}
