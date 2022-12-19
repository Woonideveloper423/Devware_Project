package com.oracle.devwareProject.service.jehwan;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.domain.jehwan.RoomResVo;
import com.oracle.devwareProject.domain.jehwan.Room_info;
import com.oracle.devwareProject.domain.jehwan.Room_res;
import com.oracle.devwareProject.repository.jehwan.ResRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ResServiceImpl implements ResService {
	private final ResRepository resRepository;

	@Override
	public List<Room_info> showRoomList() {
		List<Room_info> room_infos = resRepository.showRoomList();
		return room_infos;
	}

	@Override
	public List<RoomResVo> roomResCheck(int room_num,int myEmpNum) {
		List<RoomResVo> roomResVos = resRepository.roomResCheck(room_num, myEmpNum);
		return roomResVos;
	}

	@Override
	public int makeRes(Room_res room_res) {
		int result = resRepository.makeRes(room_res);
		return result;
	}

	@Override
	public int deleteRes(Long eventId) {
		int result = resRepository.deleteRes(eventId);
		return result;
	}

	@Override
	public int modifyRes(RoomResVo roomResVo) {
		int result = resRepository.modifyRes(roomResVo);
		return result;
	}
	
}
