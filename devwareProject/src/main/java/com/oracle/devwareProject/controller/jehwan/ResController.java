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
import com.oracle.devwareProject.domain.jehwan.Room_info;
import com.oracle.devwareProject.domain.jehwan.Room_res;
import com.oracle.devwareProject.service.GH.CalendarService;
import com.oracle.devwareProject.service.GH.DeptService;
import com.oracle.devwareProject.service.GH.EmpService;
import com.oracle.devwareProject.service.jehwan.ResService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ResController {
	private final ResService resService;
	private final DeptService deptService;
	private final EmpService empService;
	
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
	
//	//캘린더 이벤트 삭제 함수
//	@ResponseBody
//	@RequestMapping("/deleteEvent")
//	public int deleteEventOnCalendar(@RequestParam int eventId)
//	{
//		System.out.println("CalendarController deleteEventOnCalendar Start");
//		System.out.println("삭제 이벤트 EventId: "+ eventId);
//		
//		int result = 0; 
//		//result = calendarService.deleteEvent(eventId);
//		return result; 
//	}
	
//	//캘린더 이벤트 출력 함수
//	@ResponseBody
//	@RequestMapping("/addEvent")
//	public int addEventOnCalendar(Calendar calendar)
//	{
//		int result = 0;
//		System.out.println("CalendarController addEventOnCalendar Start");
//		
//		//result = calendarService.addEvent(calendar);
//		return result;
//	}
	
//	//캘린더 이벤트 변경 함수
//	@ResponseBody
//	@RequestMapping("/modifyEvent")
//	public int modifyEventOnCalendar(Calendar calendar)
//	{
//		int result = 0;
//		System.out.println("CalendarController modifyEventOnCalendar Start");
//		
//		//result = calendarService.modifyEvent(calendar);
//		return result;
//	}
	
	//캘린더의 이벤트를 출력하기 위해서 Map, Key를 설정해서 해쉬맵에 저장
	@ResponseBody
	@RequestMapping("/roomResCheck")
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> roomResCheck(@RequestParam int room_num)
	{
		List <Room_res> room_res = new ArrayList<Room_res>();
		System.out.println("CalendarController roomResCheck Start");
		room_res = resService.roomResCheck(room_num);
		
		JSONObject jsonObj = new JSONObject();
        JSONArray jsonArr = new JSONArray();
		
		HashMap<String, Object> hash = new HashMap<String, Object>();
		
		for(int i = 0; i < room_res.size(); i++)
		{
			hash.put("title",room_res.get(i).getMeeting_info());
			hash.put("start",room_res.get(i).getRes_start());
			hash.put("fin",room_res.get(i).getRes_end());
            hash.put("content",room_res.get(i).getMeeting_info());
            hash.put("id",room_res.get(i).getRes_num());
            hash.put("amount",room_res.get(i).getRes_num());
			jsonObj = new JSONObject(hash);
            jsonArr.add(jsonObj);
		}
		
		return jsonArr;
	}
	
}
