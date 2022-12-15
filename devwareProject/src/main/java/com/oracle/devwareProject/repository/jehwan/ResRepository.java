package com.oracle.devwareProject.repository.jehwan;

import java.util.List;

import com.oracle.devwareProject.domain.jehwan.Room_info;
import com.oracle.devwareProject.domain.jehwan.Room_res;

public interface ResRepository {

	List<Room_info> showRoomList();

	List<Room_res> roomResCheck(int room_num);

}
