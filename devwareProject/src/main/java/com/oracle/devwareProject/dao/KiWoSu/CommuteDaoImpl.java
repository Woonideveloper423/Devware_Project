package com.oracle.devwareProject.dao.KiWoSu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.dto.KiWoSu.Commute;
import com.oracle.devwareProject.dto.KiWoSu.Commute_cus;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CommuteDaoImpl implements CommuteDao {
	
	private final SqlSession session;
	
	@Override
	public Commute findTime(Commute commute) {
		System.out.println("CommuteDaoImpl findTime start..");
		// empnum 추가로 comnum이 아닌 commute로 변경하자
		System.out.println("CommuteDaoImpl findTime com_num->"+commute.getCom_num());
		try {
			commute = session.selectOne("wsComFindTime", commute);
			System.out.println("CommuteDaoImpl findTime getCom_start->"+commute.getCom_start());
		} catch (Exception e) {
			System.out.println("CommuteDaoImpl findTime Exception->"+e.getMessage());
		}
		return commute;
		
	}

	//퇴근 시간 입력
	@Override
	public Commute updateTime(Commute commute) {
		System.out.println("CommuteDaoImpl updateTime start..");
		int comCount = 0;
		System.out.println("CommuteDaoImpl updateTime com_end->"+commute.getCom_end());
		System.out.println("CommuteDaoImpl updateTime getCom_num->"+commute.getCom_num());
		try {
			comCount = session.update("wsComUpdateTime", commute);
			session.update("wsCusUpdateTime", commute);
			System.out.println("CommuteDaoImpl updateTime getCom_end->"+commute.getCom_end());
		} catch (Exception e) {
			System.out.println("CommuteDaoImpl updateTime Exception->"+e.getMessage());
		}
		return commute;
	}


	// 전제 -> COM_NUM 유일하다는 전제
	// 출근 / 퇴근 / 근무 Setting
	@Override
	public Commute selectTime(String com_num) {
		System.out.println("CommuteDaoImpl selectTime start..");
		Commute commute = new Commute();
		try {
			commute = session.selectOne("wsSelectTime", com_num);
			System.out.println("CommuteDaoImpl selectTime getCom_start->"+commute.getCom_start());
			System.out.println("CommuteDaoImpl selectTime getCom_workTime->"+commute.getCom_workTime());
		} catch (Exception e) {
			System.out.println("CommuteDaoImpl selectTime Exception->"+e.getMessage());
		}
		return commute;
	}

	@Override
	public List<Commute> commuteList(Commute commute) {
		System.out.println("CommuteDaoImpl commuteList start..");
		List<Commute> commuteList = null;

		System.out.println("CommuteDaoImpl commute ->"+ commute.getEmp_num());
				try {
					commuteList = session.selectList("wsComListAll", commute);

				} catch (Exception e) {
					System.out.println("CommuteDaoImpl commuteList Exception->"+e.getMessage());
				}
		return commuteList;
	}

	@Override
	public int saveTime(Commute commute) {
		System.out.println("CommuteDaoImpl saveTime start..");
		int result = 0;
		try {
			result = session.insert("wsComInsert", commute);
			session.insert("wsCusInsert", commute);
		} catch (Exception e) {
			System.out.println("CommuteDaoImpl commuteList Exception->"+e.getMessage());
		}
		return result;
	}

	@Override
	public List<Commute_cus> commuteCusList(Commute_cus commuteCus) {
		System.out.println("CommuteDaoImpl commuteList start..");
		List<Commute_cus> commuteCusList = null;
		System.out.println("CommuteDaoImpl commute ->"+ commuteCus.getEmp_num());
				try {
					commuteCusList = session.selectList("wsCusListAll", commuteCus);
					System.out.println("commuteCusList ->" + commuteCus.getCus_detail());
				} catch (Exception e) {
					System.out.println("CommuteDaoImpl commuteList Exception->"+e.getMessage());
				}
		return commuteCusList;
	}





}
