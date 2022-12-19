package com.oracle.devwareProject.service.GH;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.GH.CalDao;
import com.oracle.devwareProject.domain.Calendar;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CalendarService 
{
	private final CalDao cd;
	public int addEvent(Calendar calendar) 
	{
		int result = cd.addEvent(calendar);
		return result;
	}
	public List<Calendar> searchAll(int emp_num) {
		List<Calendar> calendars = new ArrayList<Calendar>();
		calendars = cd.searchAll(emp_num);
		return calendars;
	}
	
	public int deleteEvent(int eventId) {
		int result = cd.deleteEvent(eventId);
		System.out.println("삭제 결과 : " + result);
		return result;
	}
	
	public int modifyEvent(Calendar calendar) {
		int result = cd.modEvent(calendar);
		System.out.println("수정 결과 : " + result);
		return result;
	}
	public String calCount(int emp_num) {
		String result = cd.calCount(emp_num);
		return result;
	}	
}
