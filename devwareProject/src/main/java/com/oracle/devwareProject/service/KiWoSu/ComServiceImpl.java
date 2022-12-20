package com.oracle.devwareProject.service.KiWoSu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.KiWoSu.CommuteDao;
import com.oracle.devwareProject.dto.KiWoSu.Commute;
import com.oracle.devwareProject.dto.KiWoSu.Commute_cus;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ComServiceImpl implements ComService {
	
	private final CommuteDao cd;

	@Override
	public Commute findTime(Commute commute) {
		System.out.println("ComServiceImpl findTime ...");
		commute = null;
		commute = cd.findTime(commute);
		return commute;
	}

	@Override
	public Commute updateTime(Commute commute) {
		System.out.println("ComServiceImpl updateTime ...");
		commute = cd.updateTime(commute);
		
		return commute;
	}

	// 전제 -> COM_NUM 유일하다는 전제
	// 출근 / 퇴근 / 근무 Setting
	@Override
	public Commute selectTime(String com_num) {
		Commute commute = null;
		commute = cd.selectTime(com_num);
		return commute;
	}

	@Override
	public List<Commute> ListCommute(Commute commute) {
		System.out.println("CommuteService ListCommute start");
		List<Commute> listCommute = cd.commuteList(commute);
		System.out.println("CommuteService ListCommute listCommute.size() ->"+ listCommute.size());
		return listCommute;
	}

	@Override
	public int saveTime(Commute commute) {
		int result = 0;
		System.out.println("CommuteService saveTime start..");
		result = cd.saveTime(commute);
		return result;
		
	}

	@Override
	public List<Commute_cus> ListCommuteCus(Commute_cus commuteCus) {
		System.out.println("CommuteService ListCommute start");
		List<Commute_cus> listCommuteCus = cd.commuteCusList(commuteCus);
		System.out.println("CommuteService ListCommute listCommute.size() ->"+ listCommuteCus.size());
		return listCommuteCus;
	}



}
