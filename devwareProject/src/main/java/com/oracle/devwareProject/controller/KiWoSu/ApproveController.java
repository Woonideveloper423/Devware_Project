package com.oracle.devwareProject.controller.KiWoSu;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.dto.KiWoSu.AllForApprove;
import com.oracle.devwareProject.dto.KiWoSu.Approve;
import com.oracle.devwareProject.dto.KiWoSu.ApproveAttach;
import com.oracle.devwareProject.dto.KiWoSu.Approve_Progress;
import com.oracle.devwareProject.dto.KiWoSu.Vacation;
import com.oracle.devwareProject.dto.jiwoong.BoardAttach;
import com.oracle.devwareProject.service.GH.EmpService;
import com.oracle.devwareProject.service.KiWoSu.Paging;
import com.oracle.devwareProject.service.KiWoSu.approveService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ApproveController {
	
	private final approveService as;
	private final EmpService es;
	
	
	//리스트 맵핑
		@RequestMapping("/user/approvalList")
		public String approvalList() {

			System.out.println("CommuteController listCommute start....");

			return "/approve/user/approvalList";
			
		}
		
		@RequestMapping("/user/myApvDetail")
		public String myApvDetail(String app_num, HttpSession session, String file_name, String file_oriname, Model model) {
			System.out.println("CommuteController myApvDetail start....");
			EmpForSearch empForSearch = (EmpForSearch) session.getAttribute("empForSearch"); //JPA 외래키를 설정해 놓은 값을 받아오기 위해서 조회용 객체에 저장한 세션값을 가져온다.
			
			System.out.println("CommuteController myApvDetail ->"+app_num);
			AllForApprove allForApprove = new AllForApprove();
			try {
				allForApprove = as.myApvDetail(app_num); 
			} catch (Exception e) {
				System.out.println("CommuteController myApvDetail error ->" + e.getMessage());
			}
			System.out.println("allForApprove->"+ allForApprove.getPrg_name1());
			model.addAttribute("allApv", allForApprove);
			
			
			// 첨부파일 불러오기
			System.out.println("첨부파일 있음");
			List<ApproveAttach> approveAttachlist = new ArrayList<ApproveAttach>();
			ApproveAttach approveAttach = new ApproveAttach();
			approveAttachlist.add(approveAttach);
				
				
			
			return "/approve/user/myApvDetail";
		}
		
		@RequestMapping("/ApvDetail2")
		public String ApvDetail2() {

			System.out.println("CommuteController listCommute start....");

			return "/approve/user/ApvDetail2";
			
		}
		
//		@RequestMapping("/myApvList")
//		public String myApvList() {
//
//			System.out.println("CommuteController listCommute start....");
//
//			return "myApvList";
//			
//		}
		
//		@RequestMapping("/notAuthApvList")
//		public String notAuthApvList() {
//
//			System.out.println("CommuteController listCommute start....");
//
//			return "/approve/notAuthApvList";
//			
//		}
		
		@RequestMapping("/user/writeForm1")
		public String writeForm(HttpSession session, Model model) {
			
//			Emp emp = (Emp) session.getAttribute("emp"); //"로그인시" 세션을 설정해 놓은 값을 가져온다.
			
			EmpForSearch empForSearch = (EmpForSearch) session.getAttribute("empForSearch"); //JPA 외래키를 설정해 놓은 값을 받아오기 위해서 조회용 객체에 저장한 세션값을 가져온다.
			

			return "/approve/user/writeForm1";
			
		}
		
		@RequestMapping("/user/writeForm2")
		public String writeForm2() {

			System.out.println("CommuteController listCommute start....");

			return "/approve/user/writeForm2";
			
		}
		
		
		@RequestMapping("/user/myApvList")
		public String myApvList(Approve approve, String currentPage, HttpSession session, Model model) {
			System.out.println("approveController myApvList Start...");
			EmpForSearch empForSearch = (EmpForSearch) session.getAttribute("empForSearch"); //JPA 외래키를 설정해 놓은 값을 받아오기 위해서 조회용 객체에 저장한 세션값을 가져온다.
			
			
			int totalApv = as.totalApv(empForSearch);
			System.out.println("approveController totalApv=>" + totalApv);
			
			
			Paging   page = new Paging(totalApv, currentPage);
			// Parameter emp --> Page만 추가 Setting
			approve.setStart(page.getStart());   // 시작시 1
			approve.setEnd(page.getEnd());       // 시작시 10 
			
			approve.setEmp_num(empForSearch.getEmp_num());
			System.out.println("approve.setEmp_num ->" + approve.getEmp_num());
			//리스트 생성
			List<Approve> listApv = as.listApv(approve);
			System.out.println("approveController myApvList listApv.size()=>" + listApv.size());
			
			model.addAttribute("totalAPv", totalApv);
			model.addAttribute("listApv" , listApv);
			model.addAttribute("page"    , page);
			System.out.println("approveController myApvList page -> "+ page);
			System.out.println("approveController myApvList page -> "+ page);
			
			return "/approve/user/myApvList";
		}
		

		@RequestMapping("writeApprove")
		public String writeApproveForm( HttpSession session,
										Approve approve, 
										Approve_Progress approve_Progress, 
										com.oracle.devwareProject.domain.Calendar calendar,
										int emp_num,
										String prg_name1,
										String prg_name2,
										String prg_name3,
										String prg_num1,
										String prg_num2,
										String prg_num3,
										String app_title,
										String app_content,
										String docs_app,
										String comu_app,
										String start_date,
										String end_date,
										MultipartFile[] files,
										Model model) {

			System.out.println("CommuteController writeApproveForm start....");
			
			approve_Progress.setPrg_num1(prg_num1);
			approve_Progress.setPrg_num2(prg_num2);
			approve_Progress.setPrg_num3(prg_num3);
			approve_Progress.setPrg_name1(prg_name1);
			approve_Progress.setPrg_name2(prg_name2);
			approve_Progress.setPrg_name3(prg_name3);
			System.out.println("writeApproveForm setPrg_num1 -> " + approve_Progress.getPrg_num1());
			System.out.println("writeApproveForm setPrg_num2 -> " + approve_Progress.getPrg_num2());
			System.out.println("writeApproveForm setPrg_num3 -> " + approve_Progress.getPrg_num3());
			System.out.println("writeApproveForm getPrg_name1 -> " + approve_Progress.getPrg_name1());
			System.out.println("writeApproveForm getPrg_name2 -> " + approve_Progress.getPrg_name2());
			System.out.println("writeApproveForm getPrg_name3 -> " + approve_Progress.getPrg_name3());
			
			approve.setEmp_num(emp_num);
			approve.setApp_title(app_title);
			approve.setApp_content(app_content);
			approve.setDocs_app(docs_app);
			approve.setComu_app(comu_app);
			System.out.println("emp_num->"+emp_num);
			
			model.addAttribute("docs_app", approve.getDocs_app());
			System.out.println("test docs_app->" + approve.getDocs_app());
			
			model.addAttribute("comu_app", approve.getComu_app());
			System.out.println("test comu_app->" + approve.getComu_app());
			
			System.out.println("test comu_app->" + start_date);
			System.out.println("test comu_app->" + end_date);

			calendar.setCalendar_start(start_date);
			calendar.setCalendar_end(end_date);
			
			System.out.println("test comu_app->" + calendar.getCalendar_start());
			System.out.println("test comu_app->" + calendar.getCalendar_end());
			
			try {
				int writeResult = as.writeApv(session, approve, approve_Progress, calendar,  files); 
			} catch (Exception e) {
				System.out.println("CommuteController writeApproveForm error ->" + e.getMessage());
			}
			return "redirect:user/myApvList";
			
		}
		
		@ResponseBody
		@RequestMapping("writeApprove2")
		public String writeApproveForm2(HttpSession session,
										Approve approve, 
										Approve_Progress approve_Progress, 
										com.oracle.devwareProject.domain.Calendar calendar,
										int emp_num,
										String prg_name1,
										String prg_name2,
										String prg_name3,
										String prg_num1,
										String prg_num2,
										String prg_num3,
										String app_title,
										String app_content,
										String docs_app,
										String comu_app,
										String start_date,
										String end_date,
										int calendar_all_day,
										MultipartFile[] files,
										Model model) {

			System.out.println("CommuteController listCommute2 start....");
			
			approve_Progress.setPrg_num1(prg_num1);
			approve_Progress.setPrg_num2(prg_num2);
			approve_Progress.setPrg_num3(prg_num3);
			approve_Progress.setPrg_name1(prg_name1);
			approve_Progress.setPrg_name2(prg_name2);
			approve_Progress.setPrg_name3(prg_name3);
			System.out.println("writeApproveForm setPrg_num1 -> " + approve_Progress.getPrg_num1());
			System.out.println("writeApproveForm setPrg_num2 -> " + approve_Progress.getPrg_num2());
			System.out.println("writeApproveForm setPrg_num3 -> " + approve_Progress.getPrg_num3());
			System.out.println("writeApproveForm getPrg_name1 -> " + approve_Progress.getPrg_name1());
			System.out.println("writeApproveForm getPrg_name2 -> " + approve_Progress.getPrg_name2());
			System.out.println("writeApproveForm getPrg_name3 -> " + approve_Progress.getPrg_name3());
			
			approve.setEmp_num(emp_num);
			approve.setApp_title(app_title);
			approve.setApp_content(app_content);
			approve.setDocs_app(docs_app);
			approve.setComu_app(comu_app);
			System.out.println("emp_num->"+emp_num);
			
			model.addAttribute("docs_app", approve.getDocs_app());
			System.out.println("test docs_app->" + approve.getDocs_app());
			
			model.addAttribute("comu_app", approve.getComu_app());
			System.out.println("test comu_app->" + approve.getComu_app());
			
			System.out.println("test start_date->" + start_date);
			System.out.println("test end_date->" + end_date);

			calendar.setCalendar_start(start_date);
			calendar.setCalendar_end(end_date);
			calendar.setCalendar_allDay(calendar_all_day);
			System.out.println("test calendar_all_day->" + calendar.getCalendar_allDay());
			System.out.println("test getCalendar_start->" + calendar.getCalendar_start());
			System.out.println("test getCalendar_end->" + calendar.getCalendar_end());
			int writeResult = 0;
			try {
				 writeResult = as.writeApv(session, approve, approve_Progress, calendar, files); 
			} catch (Exception e) {
				System.out.println("CommuteController writeApproveForm error ->" + e.getMessage());
			}
			String resultString = String.valueOf(writeResult);
			System.out.println("CommuteController resultString ->" + resultString);
			return resultString;
			
		}
		
		@ResponseBody
		@RequestMapping("/getVacation")
		public Vacation getVacation(int emp_num, Vacation vacation, Model model) {
			
			System.out.println("CommuteController getVacation start....");
			System.out.println("CommuteController getVacation emp_num->" + emp_num);
			vacation = as.getVacation(emp_num);
			model.addAttribute("vacation", vacation.getVa_stock());

			return vacation;
		}
		
		@ResponseBody
		@RequestMapping("/authApprove")
		public int authApprove(String chkBtn, String sendData, String app_num, Model model) {
			
			System.out.println("CommuteController getVacation start....");
			int result = as.authApprove(chkBtn, sendData, app_num);
			
			return result;
		}
		
		@RequestMapping("/user/notAuthApvList")
		public String notAuthApvList(Approve approve, String currentPage, HttpSession session, Model model) {
			System.out.println("approveController notAuthApvList Start...");
			
			//허가 값이 0 인 사람만 나오게 표시
			EmpForSearch empForSearch = (EmpForSearch) session.getAttribute("empForSearch"); //JPA 외래키를 설정해 놓은 값을 받아오기 위해서 조회용 객체에 저장한 세션값을 가져온다.
			
			int totalApv = as.notAuthApv(empForSearch);
			System.out.println("approveController totalApv=>" + totalApv);
			
			
			Paging   page = new Paging(totalApv, currentPage);
			// Parameter emp --> Page만 추가 Setting
	 		approve.setStart(page.getStart());   // 시작시 1
			approve.setEnd(page.getEnd());       // 시작시 10 
			
			approve.setEmp_num(empForSearch.getEmp_num());
			System.out.println("approve.setEmp_num ->" + approve.getEmp_num());
			//리스트 생성
			List<Approve> listNotApv = as.listNotApv(approve);
			System.out.println("approveController myApvList listApv.size()=>" + listNotApv.size());
			
			model.addAttribute("totalAPv", totalApv);
			model.addAttribute("listApv" , listNotApv);
			model.addAttribute("page"    , page);
			System.out.println("approveController myApvList page -> "+ page);
			System.out.println("approveController myApvList page -> "+ page);
			
			return "/approve/user/notAuthApvList";
		}
		
		
		@RequestMapping("/reWrite")
		public String reWrite(String app_num, HttpSession session, Model model) {
			System.out.println("CommuteController reWrite start....");
			EmpForSearch empForSearch = (EmpForSearch) session.getAttribute("empForSearch"); //JPA 외래키를 설정해 놓은 값을 받아오기 위해서 조회용 객체에 저장한 세션값을 가져온다.
			
			System.out.println("CommuteController myApvDetail ->"+app_num);
			AllForApprove allForApprove = new AllForApprove();
			try {
				allForApprove = as.myApvDetail(app_num); 
			} catch (Exception e) {
				System.out.println("CommuteController reWrite error ->" + e.getMessage());
			}
			System.out.println("allForApprove->"+ allForApprove.getPrg_name1());
			model.addAttribute("reWrite", allForApprove);
			
			return "/approve/user/writeForm1";
			
		}
		
		@RequestMapping("reWriteApprove")
		public String reWriteApproveForm(Approve approve, 
										Approve_Progress approve_Progress, 
										com.oracle.devwareProject.domain.Calendar calendar,
										int emp_num,
										String prg_name1,
										String prg_name2,
										String prg_name3,
										String prg_num1,
										String prg_num2,
										String prg_num3,
										String app_title,
										String app_content,
										String docs_app,
										String comu_app,
										String start_date,
										String end_date,
										String app_num,
										Model model) {

			System.out.println("CommuteController listCommute start....");
			
			approve_Progress.setPrg_num1(prg_num1);
			approve_Progress.setPrg_num2(prg_num2);
			approve_Progress.setPrg_num3(prg_num3);
			approve_Progress.setPrg_name1(prg_name1);
			approve_Progress.setPrg_name2(prg_name2);
			approve_Progress.setPrg_name3(prg_name3);
			System.out.println("writeApproveForm setPrg_num1 -> " + approve_Progress.getPrg_num1());
			System.out.println("writeApproveForm setPrg_num2 -> " + approve_Progress.getPrg_num2());
			System.out.println("writeApproveForm setPrg_num3 -> " + approve_Progress.getPrg_num3());
			System.out.println("writeApproveForm getPrg_name1 -> " + approve_Progress.getPrg_name1());
			System.out.println("writeApproveForm getPrg_name2 -> " + approve_Progress.getPrg_name2());
			System.out.println("writeApproveForm getPrg_name3 -> " + approve_Progress.getPrg_name3());
			
			approve.setEmp_num(emp_num);
			approve.setApp_title(app_title);
			approve.setApp_content(app_content);
			approve.setDocs_app(docs_app);
			approve.setComu_app(comu_app);
			System.out.println("emp_num->"+emp_num);
			
			model.addAttribute("docs_app", approve.getDocs_app());
			System.out.println("test docs_app->" + approve.getDocs_app());
			
			model.addAttribute("comu_app", approve.getComu_app());
			System.out.println("test comu_app->" + approve.getComu_app());
			
			System.out.println("test comu_app->" + start_date);
			System.out.println("test comu_app->" + end_date);

			calendar.setCalendar_start(start_date);
			calendar.setCalendar_end(end_date);
			
			System.out.println("test comu_app->" + calendar.getCalendar_start());
			System.out.println("test comu_app->" + calendar.getCalendar_end());
			
			System.out.println("test app_num->" + app_num);
			try {
				int rewriteResult = as.reWriteApv(approve, approve_Progress, calendar, app_num); 
			} catch (Exception e) {
				System.out.println("CommuteController writeApproveForm error ->" + e.getMessage());
			}
			return "redirect:/user/myApvList";
			
		}
		
		@RequestMapping("/returnApprove")
		public String returnApprove(Approve_Progress approve_Progress ,int app_num, String apv_return, Model model) {
			
			System.out.println("CommuteController getVacation start....");
			
			approve_Progress.setApp_num(app_num);
			approve_Progress.setPrg_return(apv_return);
			System.out.println("test getApp_num->" + approve_Progress.getApp_num());
			System.out.println("test getPrg_return->" + approve_Progress.getPrg_return());
			approve_Progress = as.returnApprove(approve_Progress, app_num, apv_return);
			
			return "redirect:/user/myApvList";
		}
		
		@RequestMapping("/delApv")
		public String deleteApprove(Approve approve, Approve_Progress approve_Progress ,int app_num, Model model) {
			
			System.out.println("CommuteController deleteApprove start....");
			String result = "";
			approve_Progress.setApp_num(app_num);
			approve.setApp_num(app_num);
			System.out.println("test getApp_num->" + approve_Progress.getApp_num());
			result = as.deleteApprove(approve_Progress, approve);
			
			return "redirect:/user/myApvList";
		}
		
		@ResponseBody
		@RequestMapping("/approval/user/notAuthApvCount")
		public int notAuthApvCount(HttpSession session) {
			System.out.println("approveController notAuthApvList Start...");
			
			//허가 값이 0 인 사람만 나오게 표시
			EmpForSearch empForSearch = (EmpForSearch) session.getAttribute("empForSearch"); //JPA 외래키를 설정해 놓은 값을 받아오기 위해서 조회용 객체에 저장한 세션값을 가져온다.
			
			int totalApv = as.notAuthApv(empForSearch);
			System.out.println("approveController totalApv=>" + totalApv);
			
			return totalApv;
		}
		
		@RequestMapping("/approve/apvSearch")
		public String MyListSearch( HttpSession session, String searchType, String key, Model model) {
			
			EmpForSearch empForSearch = (EmpForSearch) session.getAttribute("empForSearch");
			System.out.println("key -->" + key);
			System.out.println("searchType -->" + searchType);
			AllForApprove allForApprove = new AllForApprove();
			
			allForApprove.setApp_num(empForSearch.getEmp_num());
			allForApprove.setKey(key);
			allForApprove.setSearchType(searchType);
			
			List<AllForApprove> MyListSearch = as.myListSearch(allForApprove);
			model.addAttribute("listApv" , MyListSearch);
			
			System.out.println("CommuteController listCommute start....");

			return "redirect:/user/myApvList";
			
		}
}
