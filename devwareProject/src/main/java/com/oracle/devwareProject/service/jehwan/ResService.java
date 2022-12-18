package com.oracle.devwareProject.service.jehwan;

import java.util.List;

import com.oracle.devwareProject.domain.jehwan.RoomResVo;
import com.oracle.devwareProject.domain.jehwan.Room_info;
import com.oracle.devwareProject.domain.jehwan.Room_res;

public interface ResService {

	List<Room_info> showRoomList();

	List<RoomResVo> roomResCheck(int room_num, int myEmpNum);

	int makeRes(Room_res room_res);

	int deleteRes(Long eventId);

	int modifyRes(RoomResVo roomResVo);

}
