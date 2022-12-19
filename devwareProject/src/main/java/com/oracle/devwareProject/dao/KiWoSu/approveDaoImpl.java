package com.oracle.devwareProject.dao.KiWoSu;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.ibatis.session.SqlSession;
import org.apache.kafka.common.protocol.types.Field.Str;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.domain.Calendar;
import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.dto.KiWoSu.AllForApprove;
import com.oracle.devwareProject.dto.KiWoSu.Approve;
import com.oracle.devwareProject.dto.KiWoSu.ApproveAttach;
import com.oracle.devwareProject.dto.KiWoSu.Approve_Progress;
import com.oracle.devwareProject.dto.KiWoSu.Vacation;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class approveDaoImpl implements approveDao {
	// Mybatis DB 연동 
		private final SqlSession session;
	
	@Override
	public int totalApv(EmpForSearch empForSearch) {
		int totApvCount = 0;
		System.out.println("approveDaoImpl totalApv start...");
		
		try {
			totApvCount = session.selectOne("ApvTotal", empForSearch);
			System.out.println("approveDaoImpl totalApv totApvCount->" +totApvCount);
		} catch (Exception e) {
			System.out.println("approveDaoImpl totalApv Exception->"+e.getMessage());
		}
		return totApvCount;
	}
	
	@Override
	public int totalNotApv(EmpForSearch empForSearch) {
		int totNotApvCount = 0;
		System.out.println("approveDaoImpl totalNotApv start...");
		System.out.println("empForSearch -> " + empForSearch.getEmp_num());
		try {
			totNotApvCount = session.selectOne("NotApvTotal", empForSearch);
			System.out.println("approveDaoImpl totalNotApv totApvCount->" +totNotApvCount);
		} catch (Exception e) {
			System.out.println("approveDaoImpl totalNotApv Exception->"+e.getMessage());
		}
		return totNotApvCount;
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
	public List<Approve> listNotApv(Approve approve) {
		List<Approve> notApvList = null;
		System.out.println("approveDaoImpl listApv start...");
		try {
			notApvList = session.selectList("wsNotApvListAll", approve);
			System.out.println("approveDaoImpl listApv apvList.size()->"+notApvList.size());
		} catch (Exception e) {
			System.out.println("approveDaoImpl listApv Exception->"+e.getMessage());
		}
		
		return notApvList;
	}

	@Override
	public int writeApv(Approve approve, Approve_Progress approve_Progress, Calendar calendar) {
		int result = 1;
		System.out.println("approveDaoImpl writeApv Start..." );
		System.out.println("appgetApp_content ->" +approve.getApp_content());
		System.out.println("appgetApp_title ->" +approve.getApp_title());
		System.out.println("writeApv getPrg_name1->" + approve_Progress.getPrg_name1());
		System.out.println("writeApv getPrg_num1->" + approve_Progress.getPrg_num1());
		try {
			session.insert("wsWriteApv", approve);
			System.out.println("writeApv getApp_num1->" + approve.getApp_num());
			approve_Progress.setApp_num(approve.getApp_num());
			System.out.println("writeApv getApp_num2->" + approve_Progress.getApp_num());
			result = session.insert("wsWriteApvPrg", approve_Progress);
			if (approve.getDocs_app() != null) {
				session.insert("wsApvAttach", approve);
			}
			
			if (approve.getComu_app() != null) {
				System.out.println("writeApv date1->" + calendar.getCalendar_start());
				System.out.println("writeApv date2->" + calendar.getCalendar_end());
				
				calendar.setcalendar_emp_num(approve.getEmp_num());
				System.out.println("writeApv date3->" + calendar.getcalendar_emp_num());
				
				calendar.setCalendar_id(approve.getApp_num());
				System.out.println("writeApv date4->" + calendar.getCalendar_id());
				
				System.out.println("writeApv date4->" + calendar.getCalendar_allDay());
				if (calendar.getCalendar_allDay() == 1) {
					System.out.println("approveDaoImpl writeApv Start 1..." );
					session.update("wsUpdate", calendar);
				} else if (calendar.getCalendar_allDay() == 2 || calendar.getCalendar_allDay() == 3 ) {
					System.out.println("approveDaoImpl writeApv Start 2 or 3..." );
					session.update("wsUpdate", calendar);
				}
				session.insert("wsCalInsert", calendar);
				System.out.println("approveDaoImpl wsUpdate finish..." );
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
			vacation.setEmp_num(emp_num);
			vacation = session.selectOne("wsGetVacation", vacation);
			System.out.println("approveDaoImpl getVacation ->"+ vacation.getVa_stock());
		} catch (Exception e) {
			System.out.println("approveDaoImpl getVacation Exception->"+e.getMessage());
		}
		return vacation;
	}

	@Override
	public int authApprove(String chkBtn, String sendData, String app_num) {
		int result = 0;
		System.out.println("approveDaoImpl authApprove Start..." );
		System.out.println("approveDaoImpl chkBtn ->"+ chkBtn);
		System.out.println("approveDaoImpl sendData ->"+ sendData);
		System.out.println("approveDaoImpl app_num ->"+ app_num);
		try {
			System.out.println("try Start..." );
			
			System.out.println("approveDaoImpl app_num ->"+ app_num);
			int numCnt = 0;
			int authCnt = 0;
			int authResult = 0;
			int authResult2 = 0;
			
			if (sendData.equals("1")) {
				System.out.println("approveDaoImpl 1 Start..." );
				result = session.update("wsAuthApv1", app_num);
			} else if (sendData.equals("2")) {
				System.out.println("approveDaoImpl 2 Start..." );
				result = session.update("wsAuthApv2", app_num);
			} else if (sendData.equals("3")) {
				System.out.println("approveDaoImpl 3 Start..." );
				result = session.update("wsAuthApv3", app_num);
			}
			
			//결재자들이 전부 결재 승인을 했는지에 대한 확인
			numCnt = session.selectOne("wsAuthNumCnt", app_num);
			System.out.println("approveDaoImpl numCnt ->"+ numCnt);
			
			authCnt = session.selectOne("wsAuthCnt", app_num);
			System.out.println("approveDaoImpl authCnt ->"+ authCnt);
			
			if(numCnt == authCnt) {
				authResult = session.update("wsAuthResult", app_num);
				authResult2 = session.update("wsAuthResult2", app_num);
			}
			
		} catch (Exception e) {
			System.out.println("approveDaoImpl authApprove Exception->"+e.getMessage());
		}
		
		return result;
	}

	@Override
	public int reWriteApv(Approve approve, Approve_Progress approve_Progress, Calendar calendar, String app_num) {
		int result = 0;
		System.out.println("approveDaoImpl writeApv Start..." );
		System.out.println("appgetApp_content ->" +approve.getApp_content());
		System.out.println("appgetApp_title ->" +approve.getApp_title());
		System.out.println("writeApv getPrg_name1->" + approve_Progress.getPrg_name1());
		System.out.println("writeApv getPrg_num1->" + approve_Progress.getPrg_num1());
		System.out.println("writeApv getApp_num1->" + approve.getApp_num());
		try {
			int app_num1 = Integer.parseInt(app_num);
			approve_Progress.setApp_num(app_num1);
			System.out.println("writeApv getApp_num1->" + approve.getApp_num());
			
			result = session.update("wsReWriteApv", approve);
			
			System.out.println("writeApv getApp_num2->" + approve_Progress.getApp_num());
			System.out.println("writeApproveForm setPrg_num1 -> " + approve_Progress.getPrg_num1());
			System.out.println("writeApproveForm setPrg_num2 -> " + approve_Progress.getPrg_num2());
			System.out.println("writeApproveForm setPrg_num3 -> " + approve_Progress.getPrg_num3());
			System.out.println("writeApproveForm getPrg_name1 -> " + approve_Progress.getPrg_name1());
			System.out.println("writeApproveForm getPrg_name2 -> " + approve_Progress.getPrg_name2());
			System.out.println("writeApproveForm getPrg_name3 -> " + approve_Progress.getPrg_name3());
			
			session.update("wsReWriteApvPrg", approve_Progress);
		} catch (Exception e) {
			System.out.println("approveDaoImpl writeApv Exception->"+e.getMessage());
		}
		return result;
	}

	@Override
	public Approve_Progress returnApprove(Approve_Progress approve_Progress, int app_num, String apv_return) {
		System.out.println("approveDaoImpl returnApprove Start..." );
		approve_Progress = new Approve_Progress();
		
		approve_Progress.setApp_num(app_num);
		approve_Progress.setPrg_return(apv_return);
		try {
			System.out.println("approveDaoImpl approve_Progress ->" + approve_Progress.getApp_num());
			System.out.println("approveDaoImpl approve_Progress ->" + approve_Progress.getPrg_return());
			session.update("wsRtnApv", approve_Progress);
			session.update("wsRtnApv2", approve_Progress);
		} catch (Exception e) {
			System.out.println("approveDaoImpl returnApprove Exception->"+e.getMessage());
		}
		
		return approve_Progress;
	}

	@Override
	public String deleteApprove(Approve_Progress approve_Progress, Approve approve) {
		String result = "";
		Calendar calendar = new Calendar();
		System.out.println("approveDaoImpl approve_Progress ->" + approve_Progress.getApp_num());
		System.out.println("approveDaoImpl approve ->" + approve.getApp_num());
		System.out.println("approveDaoImpl approve ->" + approve.getEmp_num());
		try {
			session.delete("wsApvPrgDel", approve_Progress);
			
			session.delete("wsApvFileDel", approve);
			session.delete("wsApvDel", approve);
			calendar.setCalendar_id(approve.getApp_num());
			System.out.println("deleteApprove getCalendar_id -> "+ calendar.getCalendar_id());
			calendar = session.selectOne("wsFindComu", calendar);
			System.out.println("deleteApprove getCalendar_start -> "+ calendar.getCalendar_start());
			System.out.println("deleteApprove getCalendar_end -> "+ calendar.getCalendar_end());
			session.update("wsUpdateVa", calendar);
			session.delete("wsCalDel", calendar);
		} catch (Exception e) {
			System.out.println("approveDaoImpl deleteApprove Exception->"+e.getMessage());
		}
		return result;
	}

	@Override
	public List<AllForApprove> myListSearch(AllForApprove allForApprove) {
		List<AllForApprove> myListSearch = new ArrayList<AllForApprove>();
		System.out.println("approveDaoImpl getempDeptInfo Start..." );
		try {
			myListSearch = session.selectList("getMySearch", allForApprove);
			System.out.println("EmpDaoImpl emplist.size: " + myListSearch.size());
		} catch (Exception e) {
			System.out.println("Error Occurred->" + e.getMessage());
		}
		return myListSearch;
	}




}
