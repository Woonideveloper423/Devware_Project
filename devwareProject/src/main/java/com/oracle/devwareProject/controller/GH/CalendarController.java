package com.oracle.devwareProject.controller.GH;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.devwareProject.domain.Calendar;
import com.oracle.devwareProject.service.GH.CalendarService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CalendarController 
{	
	private final CalendarService calendarService;

	@RequestMapping("/test")
	public String showCalendar(Model model)
	{
		int user_num = 1805001;
		model.addAttribute("emp_num",user_num);
		return "/calendar/user/calendar";
	}
	
	@ResponseBody
	@RequestMapping("/deleteEvent")
	public int deleteEventOnCalendar(@RequestParam int eventId)
	{
		System.out.println("EventId: "+ eventId);
		int result = 0; 
		System.out.println("CalendarController deleteEventOnCalendar Start");
		result = calendarService.deleteEvent(eventId);
		return result; 
	}
	
	@ResponseBody
	@RequestMapping("/addEvent")
	public int addEventOnCalendar(Calendar calendar)
	{
		int result = 0;
		System.out.println("CalendarController addEventOnCalendar Start");
		result = calendarService.addEvent(calendar);
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping("/modifyEvent")
	public int modifyEventOnCalendar(Calendar calendar)
	{
		int result = 0;
		System.out.println("CalendarController modifyEventOnCalendar Start");
		result = calendarService.modifyEvent(calendar);

		return result;
	}
	
	
	@ResponseBody
	@RequestMapping("/searchAll")
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
			System.out.print("End"+calendars.get(i).getCalendar_end());
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
