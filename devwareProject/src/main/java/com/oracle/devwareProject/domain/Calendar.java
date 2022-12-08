package com.oracle.devwareProject.domain;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data
public class Calendar {
	@Id
	private int calendar_id; 			//일정 번호
	private int calendar_emp_num;		//일정 사원 번호
	private String calendar_start;		//일정 시작일
	private String calendar_end;		//일정 마감일
	private String calendar_title;		//일정 제목
	private String calendar_content;	//일정 내용
	private int calendar_allDay;		//종일 설정
	
	//캘린더 데이터 출력하는 toString()
	@Override
	public String toString() 
	{
		return "Calendar_Dto [calendar_id=" + calendar_id + ", calendar_emp_num=" + calendar_emp_num + ", calendar_start="
				+ calendar_start + ", calendar_end=" + calendar_end + ", calendar_title=" + calendar_title
				+ ", calendar_content=" + calendar_content + ", calendar_allDay="
				+ calendar_allDay + "]";
	}
	
	public Calendar() 
	{
		super();
	}
	
	public Calendar(int calendar_id, int calendar_cate, int calendar_emp_num,
			String calendar_start, String calendar_end, String calendar_title, String calendar_content
			, int calendar_allDay) 
	{
		super();
		this.calendar_id = calendar_id;
		this.calendar_emp_num = calendar_emp_num;
		this.calendar_start = calendar_start;
		this.calendar_end = calendar_end;
		this.calendar_title = calendar_title;
		this.calendar_content = calendar_content;
		this.calendar_allDay = calendar_allDay;
	}
	
	public int getCalendar_id()
	{
		return calendar_id;
	}
	public void setCalendar_id(int calendar_id) 
	{
		this.calendar_id = calendar_id;
	}
	public int getcalendar_emp_num() {
		return calendar_emp_num;
	}
	public void setcalendar_emp_num(int calendar_emp_num) {
		this.calendar_emp_num = calendar_emp_num;
	}
	public String getCalendar_start() {
		return calendar_start;
	}
	public void setCalendar_start(String calendar_start) {
		this.calendar_start = calendar_start;
	}
	public String getCalendar_end() {
		return calendar_end;
	}
	public void setCalendar_end(String calendar_end) {
		this.calendar_end = calendar_end;
	}
	public String getCalendar_title() {
		return calendar_title;
	}
	public void setCalendar_title(String calendar_title) {
		this.calendar_title = calendar_title;
	}
	public String getCalendar_content() {
		return calendar_content;
	}
	public void setCalendar_content(String calendar_content) {
		this.calendar_content = calendar_content;
	}
	public int getCalendar_allDay() {
		return calendar_allDay;
	}
	public void setCalendar_allDay(int calendar_allDay) {
		this.calendar_allDay = calendar_allDay;
	}
}
