package com.oracle.devwareProject.controller.GH;

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
import com.oracle.devwareProject.service.GH.CalendarService;
import com.oracle.devwareProject.service.GH.DeptService;
import com.oracle.devwareProject.service.GH.EmpService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CalendarController 
{	
	private final CalendarService calendarService;
	private final DeptService deptService;
	private final EmpService empService;
	
	//캘린더 출력 함수
	@RequestMapping("/user/showCalendar")
	public String showCalendar(Model model, HttpSession session)
	{
		System.out.println("CalendarController showCalendar Start");
		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
		
		System.out.println("유저 번호 : "+emp.getEmp_num());
		
		
		return "/calendar/user/calendar";
	}
	
	@RequestMapping("/admin/manageCalendar")
	public String manageCalendar(Model model, HttpSession session, @RequestParam int emp_num)
	{
		System.out.println("CalendarController manageCalendar Start");
		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
		
		List <Dept> deptlist = new ArrayList<Dept>();
		deptlist = deptService.getDeptInfo();
		
		model.addAttribute("deptlist",deptlist);
		
		System.out.println("캘린더 조회 하려는 유저번호: " + emp_num);
		Emp name = new Emp();
		name = empService.getInfo(emp_num);
		
		
		model.addAttribute("emp_num",emp_num);
		model.addAttribute("name",name.getEmp_name());
		return "/calendar/admin/adminCalendar";
	}
	
	@RequestMapping("/admin/manageCalendarMain")
	public String manageCalendarMain(Model model, HttpSession session)
	{
		System.out.println("CalendarController manageCalendar Start");
		EmpForSearch emp = (EmpForSearch) session.getAttribute("empForSearch");
		
		List <Dept> deptlist = new ArrayList<Dept>();
		deptlist = deptService.getDeptInfo();
		
		model.addAttribute("deptlist",deptlist);
		
		model.addAttribute("emp_num",emp.getEmp_num());
		return "/calendar/admin/adminCalendar";
	}
	
	//캘린더 이벤트 삭제 함수
	@ResponseBody
	@RequestMapping("/deleteEvent")
	public int deleteEventOnCalendar(@RequestParam int eventId)
	{
		System.out.println("CalendarController deleteEventOnCalendar Start");
		System.out.println("삭제 이벤트 EventId: "+ eventId);
		
		int result = 0; 
		result = calendarService.deleteEvent(eventId);
		return result; 
	}
	
	//캘린더 이벤트 출력 함수
	@ResponseBody
	@RequestMapping("/addEvent")
	public int addEventOnCalendar(Calendar calendar)
	{
		int result = 0;
		System.out.println("CalendarController addEventOnCalendar Start");
		
		result = calendarService.addEvent(calendar);
		return result;
	}
	
	//캘린더 이벤트 변경 함수
	@ResponseBody
	@RequestMapping("/modifyEvent")
	public int modifyEventOnCalendar(Calendar calendar)
	{
		int result = 0;
		System.out.println("CalendarController modifyEventOnCalendar Start");
		
		result = calendarService.modifyEvent(calendar);
		return result;
	}
	
	//캘린더의 이벤트를 출력하기 위해서 Map, Key를 설정해서 해쉬맵에 저장
	@ResponseBody
	@RequestMapping("/searchAll")
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchAll(@RequestParam int emp_num)
	{
		List <Calendar> calendars = new ArrayList<Calendar>();
		System.out.println("CalendarController searchAll Start");
		calendars = calendarService.searchAll(emp_num);
		
		JSONObject jsonObj = new JSONObject();
        JSONArray jsonArr = new JSONArray();
		
		HashMap<String, Object> hash = new HashMap<String, Object>();
		
		for(int i = 0; i < calendars.size(); i++)
		{
			hash.put("title",calendars.get(i).getCalendar_title());
			hash.put("start",calendars.get(i).getCalendar_start());
			hash.put("fin",calendars.get(i).getCalendar_end());
            hash.put("content",calendars.get(i).getCalendar_content());
            hash.put("allDay",calendars.get(i).getCalendar_allDay());
            hash.put("id",calendars.get(i).getCalendar_id());
			jsonObj = new JSONObject(hash);
            jsonArr.add(jsonObj);
		}
		
		return jsonArr;
	}
	
}
