package com.oracle.devwareProject.dao.GH;

import java.util.List;

import com.oracle.devwareProject.domain.Calendar;

public interface CalDao {

	int addEvent(Calendar calendar);

	List<Calendar> searchAll(int emp_num);

	int deleteEvent(int eventId);

	int modEvent(Calendar calendar);

}
