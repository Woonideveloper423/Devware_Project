package com.oracle.devwareProject.dao.GH;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.domain.Calendar;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CalDaoImpl implements CalDao
{
	private final SqlSession session;

	@Override
	public int addEvent(Calendar calendar) 
	{
		int result = 0;
		try {
			result = session.insert("addEvent",calendar);
		} catch (Exception e) {
			System.out.println("CalDaoImpl addEvent Error "+e.getMessage());
		}
				
		System.out.println("이벤트 입력 결과: "+result);
		return result;
	}

	@Override
	public List<Calendar> searchAll(int emp_num) {
		List<Calendar> calendars = new ArrayList<Calendar>();
		
		System.out.println("사원 번호: " + emp_num);
		try {
			calendars = session.selectList("searchCalendar",emp_num);
			System.out.println("캘린더 데이터 크기: " +calendars.size());
		} catch (Exception e) {
			System.out.println("CalDaoImpl searchAll Error "+e.getMessage());
		}
		
		return calendars;
	}

	@Override
	public int deleteEvent(int eventId) {
		int result = 0;
		System.out.println("이벤트 번호: "+eventId);
		
		try {
			result = session.delete("deleteEvent",eventId);
			
		} catch (Exception e) {
			System.out.println("CalDaoImpl deleteEvent Error "+e.getMessage());
		}
		
		return result;
	}

	@Override
	public int modEvent(Calendar calendar) {
		int result = session.update("modifyEvent",calendar);
		/*
		 * try { result = session.update("modifyEvent",calendar); } catch (Exception e)
		 * { System.out.println("CalDaoImpl modEvent Error "+e.getMessage()); }
		 */
		System.out.println("이벤트 수정 결과: "+result);
		return result;
	}

	@Override
	public String calCount(int emp_num) {
		String result = "0";
		
		try {
			result = session.selectOne("calCount",emp_num);
			
		} catch (Exception e) {
			System.out.println("CalDaoImpl deleteEvent Error "+e.getMessage());
		}
		
		return result;
	}
	
}
