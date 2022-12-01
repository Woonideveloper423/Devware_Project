package com.oracle.devwareProject.service.KiWoSu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import com.oracle.devwareProject.dto.KiWoSu.Commute;

public interface ComService {

	Commute findTime(String com_num);

	Commute updateTime(Commute commute);

	Commute selectTime(int com_num);

	List<Commute> ListCommute(Commute commute);

	void saveTime(Commute commute);



}
