package com.oracle.devwareProject.controller.jehwan;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.devwareProject.domain.Calendar;
import com.oracle.devwareProject.domain.Dept;
import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.EmpForSearch;
import com.oracle.devwareProject.domain.jehwan.RoomResVo;
import com.oracle.devwareProject.domain.jehwan.Room_info;
import com.oracle.devwareProject.domain.jehwan.Room_res;
import com.oracle.devwareProject.service.GH.CalendarService;
import com.oracle.devwareProject.service.GH.DeptService;
import com.oracle.devwareProject.service.GH.EmpService;
import com.oracle.devwareProject.service.KiWoSu.approveService;
import com.oracle.devwareProject.service.jehwan.ResService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ResController {
	private final ResService resService;
	private final DeptService deptService;
	private final EmpService empService;
	private final approveService as;
	//캘린더 출력 함수
	@RequestMapping("/user/showRoomList")
	public String showRoomList(Model model, HttpSession session)
	{
		System.out.println("ResController showRoomList Start");
		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
		List<Room_info> room_infos = resService.showRoomList();
		model.addAttribute("roomInfo", room_infos);
		
		return "/reserve/user/reserveRoomForm";
	}
	
//	@RequestMapping("/admin/manageCalendar")
//	public String manageCalendar(Model model, HttpSession session, @RequestParam int emp_num)
//	{
//		System.out.println("CalendarController manageCalendar Start");
//		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
//		
//		List <Dept> deptlist = new ArrayList<Dept>();
//		deptlist = deptService.getDeptInfo();
//		
//		model.addAttribute("deptlist",deptlist);
//		
//		System.out.println("캘린더 조회 하려는 유저번호: " + emp_num);
//		Emp name = new Emp();
//		name = empService.getInfo(emp_num);
//		
//		
//		model.addAttribute("emp_num",emp_num);
//		model.addAttribute("name",name.getEmp_name());
//		return "/calendar/admin/adminCalendar";
//	}
	
//	@RequestMapping("/admin/manageCalendarMain")
//	public String manageCalendarMain(Model model, HttpSession session)
//	{
//		System.out.println("CalendarController manageCalendar Start");
//		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
//		
//		List <Dept> deptlist = new ArrayList<Dept>();
//		deptlist = deptService.getDeptInfo();
//		
//		model.addAttribute("deptlist",deptlist);
//		
//		model.addAttribute("emp_num",emp.getEmp_num());
//		return "/calendar/admin/adminCalendar";
//	}
	
	//캘린더 이벤트 삭제 함수 
	@ResponseBody
	@RequestMapping("/deleteRes")
	public int deleteRes(@RequestParam Long eventId)
	{
		System.out.println("CalendarController deleteEventOnCalendar Start");
		System.out.println("삭제 이벤트 EventId: "+ eventId);
		
		int result = 0; 
		result = resService.deleteRes(eventId);
		return result; 
	}
	
	//캘린더 이벤트 출력 함수
	@ResponseBody
	@RequestMapping("/makeRes")
	public int makeRes(HttpSession session, Room_res room_res, String[] res_emp_nums)
	{
		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
		room_res.setEmp_num(emp.getEmp_num());
		System.out.println("CalendarController addEventOnCalendar Start");
		System.out.println("room_num" + room_res.getRoom_num());
		System.out.println("res_emp_nums.length" + res_emp_nums.length);
		List<String> memNums = new ArrayList<String>();
		for(String emp_num : res_emp_nums) {
			memNums.add(emp_num);
		}
		room_res.setMemNums(memNums);
		int result = resService.makeRes(room_res);
		//result = calendarService.addEvent(calendar);
		return result;
	}
	
	//캘린더 이벤트 변경 함수
	@ResponseBody
	@RequestMapping("/modifyRes")
	public int modifyRes(RoomResVo roomResVo)
	{
		int result = 0;
		System.out.println("CalendarController modifyEventOnCalendar Start res_emp_nums->" + roomResVo.getRes_emp_nums().length);
		System.out.println("roomResVo->" + roomResVo);
		
		result = resService.modifyRes(roomResVo);
		return result;
	}
	
	
	@RequestMapping(value="/user/findEmpList")
	public String approval(HttpSession session,Model model, Long sel_room_num, Long is_modify, String[] res_emp_nums) {
		System.out.println("sel_room_num->" + sel_room_num);
		List<EmpForSearch> emplist = new ArrayList<EmpForSearch>();
		List<Dept> deptlist = new ArrayList<Dept>();
		
		try {
			//직원 조회 기능 수행
			emplist = as.getUserInfo();
			deptlist = deptService.getDeptInfo();

			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		System.out.println("res_emp_nums length->" + res_emp_nums);
//		List<String> resEmpNums = new ArrayList<String>();
//		for(int i = 0 ; i < res_emp_nums.length ; i++) {
//			resEmpNums.add(res_emp_nums[i]);
//		}
		model.addAttribute("emplist",emplist);
		model.addAttribute("deptlist",deptlist);
		model.addAttribute("sel_room_num",sel_room_num);
		model.addAttribute("is_modify",is_modify);
		model.addAttribute("res_emp_nums",res_emp_nums);
		
		
		return "/reserve/resmemList";
	}
	


	
	//캘린더의 이벤트를 출력하기 위해서 Map, Key를 설정해서 해쉬맵에 저장
	@ResponseBody
	@RequestMapping("/roomResCheck")
	@SuppressWarnings("unchecked")
	public List<RoomResVo> roomResCheck(@RequestParam int room_num, HttpSession session)
	{
		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
		List <RoomResVo> roomResVos = new ArrayList<RoomResVo>();
		System.out.println("CalendarController roomResCheck Start");
		roomResVos = resService.roomResCheck(room_num, emp.getEmp_num());
		if(roomResVos != null) {
			for(RoomResVo roomResVo : roomResVos) {
				System.out.println("controller check test start->" + roomResVo.getStart());
				System.out.println("controller check test end->" + roomResVo.getFin());
				if(roomResVo.getEmp_num() == emp.getEmp_num()) {
					roomResVo.setColor("lightgreen");
				}else {
					roomResVo.setColor("skyblue");
				}
			}
		}
		JSONObject jsonObj = new JSONObject();
        JSONArray jsonArr = new JSONArray();
		
		HashMap<String, Object> hash = new HashMap<String, Object>();
		
//		for(int i = 0; i < roomResVos.size(); i++)
//		{
//			hash.put("title",roomResVos.get(i).getMeeting_info());
//			hash.put("start",roomResVos.get(i).getRes_start());
//			hash.put("fin",roomResVos.get(i).getRes_end());
//            hash.put("memList",roomResVos.get(i).getMeeting_atd_vos());
//            hash.put("id",roomResVos.get(i).getRes_num());
//			jsonObj = new JSONObject(hash);
//            jsonArr.add(jsonObj);
//		}
		
		return roomResVos;
	}
	
}
