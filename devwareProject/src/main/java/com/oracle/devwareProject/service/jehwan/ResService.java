package com.oracle.devwareProject.service.jehwan;

import java.util.List;

import com.oracle.devwareProject.domain.jehwan.Room_info;
import com.oracle.devwareProject.domain.jehwan.Room_res;

public interface ResService {

	List<Room_info> showRoomList();

	List<Room_res> roomResCheck(int room_num);

	int makeRes(Room_res room_res);

	int deleteRes(Long eventId);

}
