package com.oracle.devwareProject.repository.jehwan;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.domain.jehwan.Mail;
import com.oracle.devwareProject.domain.jehwan.MailImportant;
import com.oracle.devwareProject.domain.jehwan.MailImportantID;
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
		List<Room_res> room_res = new ArrayList<Room_res>();
		System.out.println("MailRepositoryImpl listMail no searchOption");
		try {
			room_res = em.createQuery("SELECT r FROM Room_res r where ROOM_NUM = :ROOM_NUM", Room_res.class).setParameter("ROOM_NUM", room_num).getResultList();
			System.out.println("room_res size->" + room_res.size());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return room_res;
	}
	
}
