package com.oracle.devwareProject.dao.KiWoSu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.oracle.devwareProject.dto.KiWoSu.Commute;

public interface CommuteDao {

	Commute findTime(Commute commute);

	Commute updateTime(Commute commute);

	Commute selectTime(String com_num);

	List<Commute> commuteList(Commute commute);

	void saveTime(Commute commute);


}
