package com.oracle.devwareProject.repository.jehwan;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.domain.Emp;
import com.oracle.devwareProject.domain.jehwan.Mail;
import com.oracle.devwareProject.domain.jehwan.MailImportant;
import com.oracle.devwareProject.domain.jehwan.MailImportantID;
import com.oracle.devwareProject.domain.jehwan.Meeting_atd;
import com.oracle.devwareProject.domain.jehwan.Meeting_atd_vo;
import com.oracle.devwareProject.domain.jehwan.RoomResVo;
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
	public List<RoomResVo> roomResCheck(int room_num, int myEmpNum) {
		List<RoomResVo> roomResVos = null;
		List<Room_res> room_res = null;
		List<Meeting_atd> meeting_atds = null;
		
		System.out.println("MailRepositoryImpl listMail no searchOption");
		try {
			if(room_num == 0) {
				room_res = em.createQuery("SELECT r FROM Room_res r where EMP_NUM = :EMP_NUM", Room_res.class).setParameter("EMP_NUM", myEmpNum).getResultList();
			}else {
				room_res = em.createQuery("SELECT r FROM Room_res r where ROOM_NUM = :ROOM_NUM", Room_res.class).setParameter("ROOM_NUM", room_num).getResultList();
			}
			
			System.out.println("room_res size->" + room_res.size());
			if(room_res!=null) {
				roomResVos = new ArrayList<RoomResVo>();
				for(Room_res room_res_each : room_res) {
					RoomResVo roomResVo = new RoomResVo(room_res_each.getRes_num(), room_res_each.getRes_start(), room_res_each.getRes_end(), room_res_each.getMeeting_info(), room_res_each.getEmp().getEmp_num());
					List<Meeting_atd_vo> meeting_atd_vos = new ArrayList<Meeting_atd_vo>();
					System.out.println("startTime->" +  roomResVo.getStart());
					System.out.println("endTime->" +  roomResVo.getFin());
					//meeting_atds = em.createQuery("SELECT m FROM Meeting_atd m where RES_NUM = :RES_NUM", Meeting_atd.class).setParameter("RES_NUM", room_res_each.getRes_num()).getResultList();
					if(room_res_each.getMeeting_atds() != null){
						System.out.println("여기까진 올듯?");
						for(Meeting_atd meeting_atd : room_res_each.getMeeting_atds()) {
							System.out.println(meeting_atd.getEmp_atd().getEmp_num());
							System.out.println(meeting_atd.getEmp_atd().getEmp_name());
							System.out.println(meeting_atd.getEmp_atd().getPosition().getPosition_name());
							Meeting_atd_vo meeting_atd_vo = new Meeting_atd_vo(meeting_atd.getEmp_atd().getEmp_num(), meeting_atd.getEmp_atd().getEmp_name(), meeting_atd.getEmp_atd().getPosition().getPosition_name());
							meeting_atd_vos.add(meeting_atd_vo);
						}
						roomResVo.setMeeting_atd_vos(meeting_atd_vos);
					}
					roomResVos.add(roomResVo);
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return roomResVos;
	}

	@Override
	public int makeRes(Room_res room_res) {
		int result = 0;
		try { 
			List<Room_res> room_res_chk =  em.createQuery("SELECT r FROM Room_res r where ROOM_NUM = :ROOM_NUM AND RES_START between :RES_START and :RES_END", Room_res.class).setParameter("ROOM_NUM", room_res.getRoom_num()).setParameter("RES_START", room_res.getRes_start()).setParameter("RES_END", room_res.getRes_end()).getResultList();
			System.out.println("곂치는 시간 있나?->" + room_res_chk.size());
			if(room_res_chk.size()==0) {
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
			}else {
				result = 2;
				System.out.println("해당 시간대에 예약이 있습니다");
			}
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

	@Override
	public int modifyRes(RoomResVo roomResVo) {
		int result = 0;
		try {
			List<Room_res> room_res_chk =  em.createQuery("SELECT r FROM Room_res r where RES_NUM != :RES_NUM and ROOM_NUM = :ROOM_NUM AND RES_START between :RES_START and :RES_END", Room_res.class).setParameter("RES_NUM", roomResVo.getId()).setParameter("ROOM_NUM", roomResVo.getRoom_num()).setParameter("RES_START", roomResVo.getStart()).setParameter("RES_END", roomResVo.getFin()).getResultList();
			System.out.println("곂치는 시간 있나?->" + room_res_chk.size());
			if(room_res_chk.size()==0) {
			Room_res room_res = em.find(Room_res.class, roomResVo.getId());
//			Emp emp_res = em.find(Emp.class, room_res.getEmp_num());
//			Room_info room_info = em.find(Room_info.class, room_res.getRoom_num());
			
//			room_res.getMeeting_atds().clear();
			room_res.setRes_start(roomResVo.getStart());
			room_res.setRes_end(roomResVo.getFin());
			room_res.setMeeting_info(roomResVo.getTitle());
			
			
			System.out.println("여긴 통과?");
			for(String res_emp_num : roomResVo.getRes_emp_nums()) {
				Emp emp = em.find(Emp.class, Integer.parseInt(res_emp_num));
				Meeting_atd meeting_atd = new Meeting_atd(room_res, emp);
				if(!(room_res.getMeeting_atds().contains(meeting_atd))) {
					System.out.println("멤버 추가");
					room_res.getMeeting_atds().add(meeting_atd);
				}	
				//em.persist(meeting_atd);
			}
			List<Meeting_atd> meeting_atds = room_res.getMeeting_atds();
			System.out.println("how many?->" + meeting_atds.size());
			for(Meeting_atd meeting_atd : meeting_atds) {
				System.out.println("검사시작");
				if(!(Arrays.asList(roomResVo.getRes_emp_nums()).contains(String.valueOf(meeting_atd.getEmp_atd().getEmp_num())))) {
					System.out.println("삭제 멤버 있음");
					room_res.getMeeting_atds().remove(meeting_atd);
					System.out.println("삭제 완료");
				}
			}
			
			
			
			
			em.persist(room_res);
			result = 1;
			}else {
				result = 2;
				System.out.println("해당 시간대에 예약이 있습니다");
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
}
