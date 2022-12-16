package com.oracle.devwareProject.repository.jehwan;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.jehwan.Mail;
import com.oracle.devwareProject.domain.jehwan.MailImportant;
import com.oracle.devwareProject.domain.jehwan.MailImportantID;
import com.oracle.devwareProject.domain.jehwan.Meeting_atd;
import com.oracle.devwareProject.domain.jehwan.Meeting_atd_vo;
import com.oracle.devwareProject.domain.jehwan.Room_info;
import com.oracle.devwareProject.domain.jehwan.Room_res;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ResRepositoryImpl implements ResRepository {

	private final EntityManager em;

	@Override
	public List<Room_info> showRoomList() {
		List<Room_info> room_infos = new ArrayList<Room_info>();
		System.out.println("MailRepositoryImpl listMail no searchOption");
		try {
			room_infos = em.createQuery("SELECT r FROM Room_info r", Room_info.class).getResultList();
			System.out.println("room_infos size->" + room_infos.size());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return room_infos;
	}

	@Override
	public List<Room_res> roomResCheck(int room_num) {
		List<Room_res> room_res = null;
		List<Meeting_atd> meeting_atds = null;
		
		System.out.println("MailRepositoryImpl listMail no searchOption");
		try {
			room_res = em.createQuery("SELECT r FROM Room_res r where ROOM_NUM = :ROOM_NUM", Room_res.class).setParameter("ROOM_NUM", room_num).getResultList();
			System.out.println("room_res size->" + room_res.size());
			if(room_res!=null) {
				for(Room_res room_res_each : room_res) {
					List<Meeting_atd_vo> meeting_atd_vos = new ArrayList<Meeting_atd_vo>();
					meeting_atds = em.createQuery("SELECT m FROM Meeting_atd m where RES_NUM = :RES_NUM", Meeting_atd.class).setParameter("RES_NUM", room_res_each.getRes_num()).getResultList();
					if(meeting_atds!=null) {
						System.out.println("여기까진 올듯?");
						for(Meeting_atd meeting_atd : meeting_atds) {
							System.out.println(meeting_atd.getEmp_atd().getEmp_num());
							System.out.println(meeting_atd.getEmp_atd().getEmp_name());
							System.out.println(meeting_atd.getEmp_atd().getPosition().getPosition_name());
							Meeting_atd_vo meeting_atd_vo = new Meeting_atd_vo(meeting_atd.getEmp_atd().getEmp_num(), meeting_atd.getEmp_atd().getEmp_name(), meeting_atd.getEmp_atd().getPosition().getPosition_name());
							meeting_atd_vos.add(meeting_atd_vo);
							room_res_each.setMeeting_atd_vos(meeting_atd_vos);
						}
					}
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return room_res;
	}

	@Override
	public int makeRes(Room_res room_res) {
		int result = 0;
		try {
			Emp emp_res = em.find(Emp.class, room_res.getEmp_num());
			Room_info room_info = em.find(Room_info.class, room_res.getRoom_num());
			room_res.setEmp(emp_res);
			room_res.setRoom_info(room_info); 
			room_res.setRes_cancel("N");
			
			em.persist(room_res);
			System.out.println("room_res res_num->" + room_res.getRes_num());
			for(String memNum : room_res.getMemNums()) {
				Emp emp = em.find(Emp.class, Integer.parseInt(memNum));
				Meeting_atd meeting_atd = new Meeting_atd(room_res, emp);
				em.persist(meeting_atd);
			}
			result = 1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	@Override
	public int deleteRes(Long eventId) {
		int result = 0;
		Room_res room_res = null;
		try {
			room_res = em.find(Room_res.class, eventId);
			em.remove(room_res);
			result = 1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
}
