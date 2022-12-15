package com.oracle.devwareProject.service.jehwan;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

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
	public List<Room_res> roomResCheck(int room_num) {
		List<Room_res> room_res = resRepository.roomResCheck(room_num);
		return room_res;
	}
	
}
