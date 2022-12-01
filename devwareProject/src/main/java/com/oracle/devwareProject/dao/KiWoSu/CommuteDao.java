package com.oracle.devwareProject.dao.KiWoSu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.oracle.devwareProject.dto.KiWoSu.Commute;

public interface CommuteDao {

	Commute findTime(String com_num);

	Commute updateTime(Commute commute);

	Commute selectTime(int com_num);

	List<Commute> commuteList(Commute commute);

	void saveTime(Commute commute);


}
