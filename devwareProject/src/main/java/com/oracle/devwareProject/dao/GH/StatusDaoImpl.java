package com.oracle.devwareProject.dao.GH;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.devwareProject.domain.Position;
import com.oracle.devwareProject.domain.Status;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class StatusDaoImpl implements StatusDao {
	
	private final SqlSession session;
	
	@Override
	public List<Status> getStatusInfo() 
	{
		List<Status> statuslist = new ArrayList<Status>();
		System.out.println("StatusDaoImpl getStatusInfo Start");
	
		try {
			statuslist = session.selectList("getStatusInfo");
			System.out.println("statuslist의 사이즈: "+statuslist.size());
		} catch (Exception e)
		{
			System.out.println("StatusDaoImpl getStatusInfo Error:"+e.getMessage());
		}
		
		return statuslist;
	}

}
