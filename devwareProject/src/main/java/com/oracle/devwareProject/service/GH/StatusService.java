package com.oracle.devwareProject.service.GH;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.devwareProject.dao.GH.PosDao;
import com.oracle.devwareProject.dao.GH.StatusDao;
import com.oracle.devwareProject.domain.Position;
import com.oracle.devwareProject.domain.Status;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StatusService 
{
	private final StatusDao sd;
	public List<Status> getStatusInfo() 
	{
		System.out.println("StatusService getStatusInfo Start");
		List<Status> statuslist = new ArrayList<Status>();
		
		try{
			statuslist = sd.getStatusInfo();
			System.out.println("PosService의 poslist의 size"+statuslist.size());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return statuslist;
	}
}
