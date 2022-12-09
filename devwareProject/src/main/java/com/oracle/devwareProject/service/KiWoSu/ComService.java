package com.oracle.devwareProject.service.KiWoSu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import com.oracle.devwareProject.dto.KiWoSu.Commute;

public interface ComService {

	Commute findTime(Commute commute);

	Commute updateTime(Commute commute);

	Commute selectTime(String com_num);

	List<Commute> ListCommute(Commute commute);

	void saveTime(Commute commute);



}
